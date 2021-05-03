"use strict";

var assert = require( 'assert' );
var __ = require( '../' );

describe( 'getType', function() {

	it( 'should handle UNDEFINED', function() {
		assert.equal( __.getType( undefined ), 'undefined' );
		assert.equal( __( undefined ).getType(), 'undefined' );
	} );

	it( 'should handle NULL', function() {
		assert.equal( __.getType( null ), 'null' );
		assert.equal( __( null ).getType(), 'null' );
	} );

	it( 'should handle strings', function() {
		assert.equal( __.getType( "string" ), "string" );
		assert.equal( __( "string" ).getType(), "string" );
	} );

	it( 'should handle integers', function() {
		[
			1,
			-1,
			0,
			0.0,
			-0,
			-0.0,
			Number.MAX_VALUE,
			-Number.MAX_VALUE,
			new Number( 1 ),
			new Number( -1 ),
			-(new Number( 1 )),
			new Number( 0 ),
			new Number( -0 ),
			-(new Number( 0 )),
			new Number( 0.0 ),
			new Number( -0.0 ),
			-(new Number( 0.0 ))
		].forEach( function( val ) {
			assert.equal( __.getType( val ), 'integer' );
			assert.equal( __( val ).getType(), 'integer' );
		} );

	} );

	it( 'should handle floats', function() {
		[
			1.1,
			-1.1,
			0.1,
			-0.1,
			Number.MIN_VALUE,
			-Number.MIN_VALUE,
			new Number( 10.1 ),
			new Number( -10.1 ),
			-(new Number( 10.1 )),
		].forEach( function( val ) {
			assert.equal( __.getType( val ), 'float' );
			assert.equal( __( val ).getType(), 'float' );
		} );

	} );

	it( 'should handle booleans', function() {
		assert.equal( __.getType( true ), 'boolean' );
		assert.equal( __.getType( false ), 'boolean' );
		assert.equal( __( true ).getType(), 'boolean' );
		assert.equal( __( false ).getType(), 'boolean' );
	} );

	it( 'should handle arrays', function() {
		assert.equal( __.getType( new Array() ), 'array' );
		assert.equal( __.getType( [] ), 'array' );
		assert.equal( __.getType( [ "one", "two", "three" ] ), 'array' );
		assert.equal( __( new Array() ).getType(), 'array' );
		assert.equal( __( [] ).getType(), 'array' );
		assert.equal( __( [ "one", "two", "three" ] ).getType(), 'array' );
	} );

	it( 'should handle functions', function() {
		assert.equal( __.getType( function() {
		} ), 'function' );
		assert.equal( __( function() {
		} ).getType(), 'function' );
	} );

	it( 'should handle {}', function() {
		assert.equal( __.getType( {} ), 'object' );
		assert.equal( __( {} ).getType(), 'object' );
	} );

	it( 'should handle Date', function() {
		assert.equal( __.getType( new Date() ), 'date' );
		assert.equal( __( new Date() ).getType(), 'date' );
	} );

	it( 'should handle RegExp', function() {
		assert.equal( __.getType( new RegExp() ), 'regex' );
		assert.equal( __( new RegExp() ).getType(), 'regex' );
		assert.equal( __.getType( /regex/ ), 'regex' );
		assert.equal( __( /regex/ ).getType(), 'regex' );
	} );

	it( 'should handle objects from custom class new function()', function() {
		var c = function() {
		};
		assert.equal( __.getType( new c() ), 'object' );
		assert.equal( __( new c() ).getType(), 'object' );
	} );

} );
