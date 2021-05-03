'use strict';

var Clone = require( './clone' );
var Types = require( './types' );

module.exports = function () {

	if ( arguments.length < 2 ) {
		return;
	}

	var indexStack = [];

	var iterator = arguments[ arguments.length - 1 ];

	var eachArr = function ( arr ) {
		arr.forEach( function ( value, index ) {
			each( value, index );
		} );
	};

	var eachObj = function ( obj ) {
		for ( var index in obj ) {
			if ( obj.hasOwnProperty( index ) ) {
				each( obj[ index ], index );
			}
		}
	};

	var each = function ( value, index ) {

		indexStack.push( index );

		if ( Types.isArray( value ) ) {
			eachArr( value );
		} else if ( Types.isObject( value ) ) {
			eachObj( value );
		} else {
			iterator( value, Clone.clone( indexStack ) );
		}

		indexStack.pop();

	};

	for ( var i = 0; i < arguments.length - 1; i++ ) {

		var arg = arguments[ i ];
		each( arg, i );

	}

};

module.exports.total = function () {

	var args = module.exports.flatten.apply( this, arguments );

	var eachArr = function ( arr ) {

		var total = 0;

		arr.forEach( function ( item ) {
			total += each( item );
		} );

		return total;

	};

	var eachObj = function ( obj ) {

		var total = 0;

		for ( var field in obj ) {
			if ( obj.hasOwnProperty( field ) ) {
				total += each( obj[ field ] );
			}
		}
		return total;

	};

	var each = function ( arg ) {

		if ( Types.isArray( arg ) ) {
			return eachArr( arg );
		} else if ( Types.isObject( arg ) ) {
			return eachObj( arg );
		} else if ( Types.isNumber( arg ) ) {
			return arg;
		} else {
			return 0;
		}

	};

	var total = 0;
	for ( var i = 0; i < args.length; i++ ) {
		total += each( args[ i ] );
	}

	return total;

};

module.exports.flatten = function () {

	var output = [];

	var args = Array.prototype.slice.call( arguments );

	args.push( function ( value ) {
		output.push( value );
	} );

	module.exports.apply( this, args );

	return output;

};
