'use strict';

var Types = require( './types' );

var cloneDepth = 0;
exports.clone = function( arg ) {

	cloneDepth++;

	if ( cloneDepth >= 100 ) {
		cloneDepth = 0;
		throw new Error( 'max clone depth of 100 reached' );
	}

	var target = null;

	if ( arg instanceof Date ) {
		target = new Date( arg.toISOString() );
	} else if ( Types.isArray( arg ) ) {
		target = [];
		for ( var i = 0; i < arg.length; i++ ) {
			target[ i ] = exports.clone( arg[ i ] );
		}
	} else if ( Types.isObject( arg ) ) {
		target = {};
		for ( var field in arg ) {
			if ( arg.hasOwnProperty( field ) ) {
				target[ field ] = exports.clone( arg[ field ] );
			}
		}
	} else { // functions, etc. not cloneable, and will pass through, though for primitives like strings and numbers, arg is cloning
		target = arg;
	}

	cloneDepth--;

	return target;

};
