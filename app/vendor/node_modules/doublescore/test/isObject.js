"use strict";

var assert = require( 'assert' );
var __ = require( '../' );

describe( 'isObject', function() {

	it( 'should return false for an array', function() {
		assert.equal( __.isObject( [] ), false );
		assert.equal( __.isObject( [ "one", "two", "three" ] ), false );

		assert.equal( __( [] ).isObject(), false );
		assert.equal( __( [ "one", "two", "three" ] ).isObject(), false );
	} );

	it( 'should return false for NULL', function() {
		assert.equal( __.isObject( null ), false );
		assert.equal( __( null ).isObject(), false );
	} );

	it( 'should return false for Infinity', function() {
		assert.equal( __.isObject( Infinity ), false );
		assert.equal( __( Infinity ).isObject(), false );
	} );

	it( 'should return false for NaN', function() {
		assert.equal( __.isObject( NaN ), false );
		assert.equal( __( NaN ).isObject(), false );
	} );

	it( 'should return false for UNDEFINED', function() {
		assert.equal( __.isObject( undefined ), false );
		assert.equal( __( undefined ).isObject(), false );
	} );

	it( 'should return false for a string', function() {
		assert.equal( __.isObject( "string" ), false );
		assert.equal( __.isObject( "" ), false );

		assert.equal( __( "string" ).isObject(), false );
		assert.equal( __( "" ).isObject(), false );
	} );

	it( 'should return false for an integer', function() {
		assert.equal( __.isObject( 1 ), false );
		assert.equal( __.isObject( 0 ), false );
		assert.equal( __.isObject( -1 ), false );

		assert.equal( __( 1 ).isObject(), false );
		assert.equal( __( 0 ).isObject(), false );
		assert.equal( __( -1 ).isObject(), false );
	} );

	it( 'should return false for a float', function() {
		assert.equal( __.isObject( 1.1 ), false );
		assert.equal( __.isObject( 0.0 ), false );
		assert.equal( __.isObject( -1.1 ), false );

		assert.equal( __( 1.1 ).isObject(), false );
		assert.equal( __( 0.0 ).isObject(), false );
		assert.equal( __( -1.1 ).isObject(), false );
	} );

	it( 'should return false for a boolean', function() {
		assert.equal( __.isObject( true ), false );
		assert.equal( __.isObject( false ), false );

		assert.equal( __( true ).isObject(), false );
		assert.equal( __( false ).isObject(), false );
	} );

	it( 'should return true for an object {}', function() {
		assert.equal( __.isObject( {} ), true );

		assert.equal( __( {} ).isObject(), true );
	} );

	describe( 'should return true for any other kind of object:', function() {

		it( 'new Date()', function() {
			assert.equal( __.isObject( new Date() ), true );
		} );

		it( 'new RegExp()', function() {
			assert.equal( __.isObject( new RegExp() ), true );
		} );

		it( 'new Date()', function() {
			assert.equal( __( new Date() ).isObject(), true );
		} );

		it( 'new RegExp()', function() {
			assert.equal( __( new RegExp() ).isObject(), true );
		} );

	} );

} );
