'use strict';

var Mixin = require( './mixin' );

module.exports = {
	close: function ( params ) {

		params = Mixin.mixin( {
			max: 1,
			maxException: false,
			maxLog: false,
			ttl: 30000
		}, params );

		return function ( cb ) {

			var calls = 0;
			var timeout = null;

			if ( params.ttl && params.ttl > 0 ) {
				timeout = setTimeout( function () {
					calls++;
					timeout = null;
					setImmediate( cb, new Error( 'timeout' ) );
				}, params.ttl );
			}

			var lastCall = [];

			return function ( err, data ) {

				calls++;

				if ( params.max > -1 && calls > params.max ) {

					err = new Error( 'max callbacks ' + params.max + ' exceeded by call ' + calls + ' after last calls: ' + JSON.stringify( lastCall ) );

					if ( params.maxLog ) {
						var stack = err.stack;

						// don't need the line number inside doublescore to appear in trace
						stack = stack.replace( /\n[^\n]*\n/, "\n" );

						console.error( stack );

					} else if ( params.maxException ) {
						throw err;
					}

					return;
				}

				lastCall.push( arguments );

				if ( timeout ) {
					clearTimeout( timeout );
					timeout = null;
				}

				if ( err ) {
					cb( err );
				} else if ( arguments.length > 1 ) {
					cb.apply( {}, arguments );
				} else {
					cb( null );
				}

				return true;

			};

		};

	}
};