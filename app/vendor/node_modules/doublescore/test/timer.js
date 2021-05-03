"use strict";

var async = require( 'async' );
var assert = require( 'assert' );
var __ = require( '../' );

describe( 'timer', function() {
	it( 'should measure time delta with <= 0.5% error', function( done ) {

		var timer = __.timer();

		async.times( 100, function( i, done ) {

			var timeout = 50 + i * 5;
			setTimeout( function() {

				var delta = timer();
				var error = Math.abs( delta - timeout );
				var errorRate = error / timeout;

				try {
					assert( errorRate <= 0.5 );
					done();
				} catch ( e ) {
					done( e );
				}

			}, timeout );

		}, done );

	} );

	it( 'should take intervals with <= 0.5% error per interval', function( done ) {

		var timer = __.timer();
		var total = 0;
		async.timesSeries( 10, function( i, done ) {

			// count from 1;
			i++;

			var timeout = 50;

			setTimeout( function() {

				total += timeout;

				var delta = timer();

				var error = Math.abs( delta - total );
				var errorRate = error / timeout;

				try {
					assert( errorRate <= (i * 0.5) );
					done();
				} catch ( e ) {
					done( e );
				}

			}, timeout );

		}, done );

	} );

	it( 'should reset intervals with <= 0.5% error per interval', function( done ) {

		var timer = __.timer();
		async.timesSeries( 10, function( i, done ) {

			var timeout = 50;

			setTimeout( function() {

				// -1 to account for async framework
				var delta = timer( true ) - 1;

				var error = Math.abs( delta - timeout );
				var errorRate = error / timeout;

				try {
					assert( errorRate <= 0.5 );

					done();
				} catch ( e ) {
					done( e );
				}

			}, timeout );

		}, done );

	} );

} );
