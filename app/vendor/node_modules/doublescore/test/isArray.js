"use strict";

var assert = require( 'assert' );
var __ = require( '../' );

describe( 'isArray', function() {

	it( 'should return true for an array', function() {
		assert.equal( __.isArray( [] ), true );
		assert.equal( __.isArray( new Array() ), true );
		assert.equal( __.isArray( [ "one", "two", "three" ] ), true );

		assert.equal( __( [] ).isArray(), true );
		assert.equal( __( new Array() ).isArray(), true );
		assert.equal( __( [ "one", "two", "three" ] ).isArray(), true );
	} );

	it( 'should return false for NULL', function() {
		assert.equal( __.isArray( null ), false );
		assert.equal( __( null ).isArray(), false );
	} );

	it( 'should return false for UNDEFINED', function() {
		assert.equal( __.isArray( undefined ), false );
		assert.equal( __( undefined ).isArray(), false );
	} );

	it( 'should return false for Infinity', function() {
		assert.equal( __.isArray( Infinity ), false );
		assert.equal( __( Infinity ).isArray(), false );
	} );

	it( 'should return false for NaN', function() {
		assert.equal( __.isArray( NaN ), false );
		assert.equal( __( NaN ).isArray(), false );
	} );

	it( 'should return false for a string', function() {
		assert.equal( __.isArray( "string" ), false );
		assert.equal( __.isArray( "" ), false );
		assert.equal( __( "string" ).isArray(), false );
		assert.equal( __( "" ).isArray(), false );
	} );

	it( 'should return false for an integer', function() {
		assert.equal( __.isArray( 1 ), false );
		assert.equal( __.isArray( 0 ), false );
		assert.equal( __.isArray( -1 ), false );
		assert.equal( __( 1 ).isArray(), false );
		assert.equal( __( 0 ).isArray(), false );
		assert.equal( __( -1 ).isArray(), false );
	} );

	it( 'should return false for a float', function() {
		assert.equal( __.isArray( 1.1 ), false );
		assert.equal( __.isArray( 0.0 ), false );
		assert.equal( __.isArray( -1.1 ), false );
		assert.equal( __( 1.1 ).isArray(), false );
		assert.equal( __( 0.0 ).isArray(), false );
		assert.equal( __( -1.1 ).isArray(), false );
	} );

	it( 'should return false for a boolean', function() {
		assert.equal( __.isArray( true ), false );
		assert.equal( __.isArray( false ), false );
		assert.equal( __( true ).isArray(), false );
		assert.equal( __( false ).isArray(), false );
	} );

	it( 'should return false for an object {}', function() {
		assert.equal( __.isArray( {} ), false );
		assert.equal( __( {} ).isArray(), false );
	} );

	describe( 'should return false for any kind of object:', function() {

		it( 'new Date()', function() {
			assert.equal( __.isArray( new Date() ), false );
		} );

		it( 'new RegExp()', function() {
			assert.equal( __.isArray( new RegExp() ), false );
		} );


		it( 'new Date()', function() {
			assert.equal( __( new Date() ).isArray(), false );
		} );

		it( 'new RegExp()', function() {
			assert.equal( __( new RegExp() ).isArray(), false );
		} );

	} );

} );
