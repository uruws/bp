"use strict";

var assert = require( 'assert' );
var __ = require( '../' );

describe( 'clone', function() {

	describe( 'string', function() {

		var theString = 'the string';

		it( 'should return a string', function() {
			assert.equal( typeof __.clone( theString ), 'string' );
			assert.equal( typeof __( theString ).clone(), 'string' );
		} );

		it( 'should return a new string with same value', function() {
			assert.equal( __.clone( theString ), theString );
			assert.equal( __( theString ).clone(), theString );
		} );

	} );

	describe( 'Date', function() {

		var theDate = new Date();

		it( 'should return a date object', function() {
			assert.ok( __.clone( theDate ) instanceof Date );
			assert.ok( __( theDate ).clone() instanceof Date );
		} );

		it( 'should have the same ISO date', function() {
			assert.equal( __.clone( theDate ).toISOString(), theDate.toISOString() );
			assert.equal( __( theDate ).clone().toISOString(), theDate.toISOString() );
		} );

		it( 'should be a new object', function() {
			assert.notStrictEqual( __.clone( theDate ), theDate );
			assert.notStrictEqual( __( theDate ).clone(), theDate );
		} );

	} );

	describe( 'Objects and Arrays', function() {

		var theObject = {
			'array field': [
				'hi', 'there'
			],
			'number': 1,
			'float': 1.04,
			'array numbers': [
				1, 4.45, 32, 3, 3413, function() {
				}
			],
			'func': function() {
			},
			'object': {
				'array field': [
					'hi', 'there'
				],
				'number': 1,
				'float': 1.04,
				'array numbers': [
					1, 4.45, 32, 3, 3413,
					{
						name: 'user1'
					},
					{
						name: 'user2'
					}
				],
				'object': {
					'deep': {
						'array': [
							{
								'more:': 'here'
							}
						]
					}
				}
			}
		};

		it( 'should return an object', function() {
			assert.ok( __.clone( theObject ) instanceof Object );
			assert.ok( __( theObject ).clone() instanceof Object );
		} );

		it( 'should have the same structure and values', function() {
			assert.deepEqual( __.clone( theObject ), theObject );
			assert.deepEqual( __( theObject ).clone(), theObject );
		} );

		it( 'should be a new object', function() {
			assert.notStrictEqual( __.clone( theObject ), theObject );
			assert.notStrictEqual( __( theObject ).clone(), theObject );
		} );

		it( 'should not recurse beyond 100 levels', function() {
			assert.throws( function() {

				var cloneObject = {};
				var ref = cloneObject;

				for ( var i = 0; i < 300; i++ ) {
					ref.nesting = {};
					ref = ref.nesting;
				}

				ref.final = "hi";

				__.clone( cloneObject );

			} );
			assert.throws( function() {

				var cloneObject = {};
				var ref = cloneObject;

				for ( var i = 0; i < 300; i++ ) {
					ref.nesting = {};
					ref = ref.nesting;
				}

				ref.final = "hi";

				__( cloneObject ).clone();

			} );
		} );

	} );

	describe( 'everything else', function() {

		var theFunction = function() {
			return 'hello';
		};

		it( 'should be === of original', function() {
			assert.strictEqual( __.clone( theFunction ), theFunction );
			assert.strictEqual( __( theFunction ).clone(), theFunction );
		} );

	} );

} );
