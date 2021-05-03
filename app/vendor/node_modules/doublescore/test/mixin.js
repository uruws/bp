"use strict";

var assert = require( 'assert' );
var __ = require( '../' );

describe( 'mixin', function() {

	var theObject = {
		statusCode: 200,
		data: {
			subscription: {
				id: '1234567890',
				principal_id: 'STACK',
				callback_url: 'https://a.host.com',
				date_created: '2013-02-04T06:57:18Z',
				tags: {
					string: 'germany'
				}
			},
			contacts: [
				{
					name: 'user1'
				},
				{
					name: 'user2'
				}
			]
		},
		func: function() {
		}
	};

	var theDefaultObject = {
		statusCode: 500,
		data: {
			subscription: {
				id: null
			},
			contacts: []
		}
	};

	var theArray = [
		'one',
		1,
		'onepointone',
		1.1,
		{
			'hi': 'germany',
			'bye': 'france',
			'an array': [
				'one',
				function() {
				},
				1,
				'onepointone',
				1.1,
				{
					'hi 2': 'germany',
					'bye 2': 'france',
					'an array 2': [

					]
				}
			]
		}
	];

	var theDefaultArray = [
		'two',
		undefined,
		null,
		null,
		{
			'hi': null
		}
	];

	// original should not be modified
	it( 'should not modify original object', function() {

		__.mixin( theDefaultObject, theObject );
		assert.notDeepEqual( theObject, theDefaultObject );

		__( theDefaultObject ).mixin( theObject );
		assert.notDeepEqual( theObject, theDefaultObject );

	} );
	it( 'should not modify original array', function() {
		__.mixin( theDefaultArray, theArray );
		assert.notDeepEqual( theArray, theDefaultArray );

		__( theDefaultArray ).mixin( theArray );
		assert.notDeepEqual( theArray, theDefaultArray );
	} );

	// a new one
	it( 'should return a new object', function() {
		assert.notStrictEqual( __.mixin( theObject, {} ), theObject );
		assert.notStrictEqual( __( theObject ).mixin( {} ), theObject );
	} );
	it( 'should return a new array', function() {
		assert.notStrictEqual( __.mixin( theArray, [] ), theArray );
		assert.notStrictEqual( __( theArray ).mixin( [] ), theArray );
	} );

	// deep structure with empty default
	it( 'should return the same deep structure with empty default object', function() {
		assert.notStrictEqual( __.mixin( {}, theObject ), theObject );
		assert.notStrictEqual( __( {} ).mixin( theObject ), theObject );
	} );
	it( 'should return the same deep structure with empty default array', function() {
		assert.notStrictEqual( __.mixin( [], theArray ), theArray );
		assert.notStrictEqual( __( [] ).mixin( theArray ), theArray );
	} );

	// deep structure with empty input
	it( 'should return the same deep structure with empty input object', function() {
		assert.deepEqual( __.mixin( theObject, {} ), theObject );
		assert.deepEqual( __( theObject ).mixin( {} ), theObject );
	} );
	it( 'should return the same deep structure with empty input array', function() {
		assert.deepEqual( __.mixin( theArray, [] ), theArray );
		assert.deepEqual( __( theArray ).mixin( [] ), theArray );
	} );

	// deep structure with undefined input
	it( 'should return the same deep structure with undefined input object', function() {
		assert.deepEqual( __.mixin( theObject, undefined ), theObject );
		assert.deepEqual( __( theObject ).mixin( undefined ), theObject );
	} );
	it( 'should return the same deep structure with undefined input array', function() {
		assert.deepEqual( __.mixin( theArray, undefined ), theArray );
		assert.deepEqual( __( theArray ).mixin( undefined ), theArray );
	} );

	// deep structure with null input
	it( 'should return the same deep structure with null input object', function() {
		assert.deepEqual( __.mixin( theObject, null ), theObject );
		assert.deepEqual( __( theObject ).mixin( null ), theObject );
	} );
	it( 'should return the same deep structure with null input array', function() {
		assert.deepEqual( __.mixin( theArray, null ), theArray );
		assert.deepEqual( __( theArray ).mixin( null ), theArray );
	} );

	// deep structure with initialized default
	it( 'should return the same deep structure with initialized default object', function() {
		assert.deepEqual( __.mixin( theDefaultObject, theObject ), theObject );
		assert.deepEqual( __( theDefaultObject ).mixin( theObject ), theObject );
	} );
	it( 'should return the same deep structure with initialized default array', function() {
		assert.deepEqual( __.mixin( theDefaultArray, theArray ), theArray );
		assert.deepEqual( __( theDefaultArray ).mixin( theArray ), theArray );
	} );

	// mixin an object to an array
	it( 'should mixin all integer fields from the object to the array', function() {

		var theArrayFromObject = {
			'zero': 0,
			'one': 1,
			'two': 2,
			0: 0,
			1: 1,
			'2': 2,
			'3.0': 'three.zero',
			3: 3,
			'4.1': 4,
			5.2: 5,
			'6six': 6,
			7: 7
		};

		var theDefaultArrayFromObject = [
			'zero',
			[
				'one'
			],
			'two',
			'three',
			{
				'four': 4
			}
		];

		var expectedArrayFromObject = [
			0,
			[ 'one' ],
			2,
			3,
			{
				'four': 4
			}
		];
		expectedArrayFromObject[7] = 7;

		assert.deepEqual( __.mixin( theDefaultArrayFromObject, theArrayFromObject ), expectedArrayFromObject );
		assert.deepEqual( __( theDefaultArrayFromObject ).mixin( theArrayFromObject ), expectedArrayFromObject );

	} );

	// mixin an array to an object
	it( 'should mixin in an array to an object by converting the integer indexes in the array to string field names in the object', function() {

		var theObjectFromArray = [
			'zero',
			'one',
			'two',
			'three'
		];
		theObjectFromArray[5] = 'five';


		var theDefaultObjectFromArray = {
			zero: 0,
			'one': 1,
			'two': 2,
			0: 0,
			1: 1,
			'2': 2
		};

		var expectedObjectFromArray = {
			'0': 'zero',
			'1': 'one',
			'2': 'two',
			'3': 'three',
			'5': 'five',
			zero: 0,
			one: 1,
			two: 2
		};

		assert.deepEqual( __.mixin( theDefaultObjectFromArray, theObjectFromArray ), expectedObjectFromArray );
		assert.deepEqual( __( theDefaultObjectFromArray ).mixin( theObjectFromArray ), expectedObjectFromArray );

	} );

	it( 'should mixin nested arrays to objects', function() {

		var theInput = {
			two: [
				'zero',
				'one',
				'two',
				'three'
			]
		};
		theInput.two[5] = 'five';


		var theDefault = {
			zero: 0,
			'one': 1,
			'two': {
				zero: 0,
				'one': 1,
				'two': 'two',
				0: 0,
				1: 1,
				'2': 2
			},
			0: 0,
			1: 1,
			'2': 2
		};

		var expectedObject = {
			'0': 0,
			'1': 1,
			'2': 2,
			'zero': 0,
			'one': 1,
			'two': {
				'0': 'zero',
				'1': 'one',
				'2': 'two',
				'3': 'three',
				'5': 'five',
				'zero': 0,
				'one': 1,
				'two': 'two'
			}
		};

		assert.deepEqual( __.mixin( theDefault, theInput ), expectedObject );
		assert.deepEqual( __( theDefault ).mixin( theInput ), expectedObject );

	} );

	it( 'should mixin arrays over primitives', function() {

		var theArray = [
			'one',
			'two',
			{
				'three': 'four'
			},
			[
				'five'
			]
		];

		assert.deepEqual( __.mixin( true, theArray ), theArray );
		assert.deepEqual( __.mixin( false, theArray ), theArray );
		assert.deepEqual( __.mixin( 1, theArray ), theArray );
		assert.deepEqual( __.mixin( -1, theArray ), theArray );
		assert.deepEqual( __.mixin( 1.1, theArray ), theArray );
		assert.deepEqual( __.mixin( -1.1, theArray ), theArray );
		assert.deepEqual( __.mixin( 0, theArray ), theArray );
		assert.deepEqual( __.mixin( 0.0, theArray ), theArray );
		assert.deepEqual( __.mixin( "string", theArray ), theArray );
		assert.deepEqual( __.mixin( "", theArray ), theArray );

		assert.deepEqual( __( true ).mixin( theArray ), theArray );
		assert.deepEqual( __( false ).mixin( theArray ), theArray );
		assert.deepEqual( __( 1 ).mixin( theArray ), theArray );
		assert.deepEqual( __( -1 ).mixin( theArray ), theArray );
		assert.deepEqual( __( 1.1 ).mixin( theArray ), theArray );
		assert.deepEqual( __( -1.1 ).mixin( theArray ), theArray );
		assert.deepEqual( __( 0 ).mixin( theArray ), theArray );
		assert.deepEqual( __( 0.0 ).mixin( theArray ), theArray );
		assert.deepEqual( __( "string" ).mixin( theArray ), theArray );
		assert.deepEqual( __( "" ).mixin( theArray ), theArray );

	} );

	it( 'should mixin objects over primitives', function() {

		var theObject = {
			'one': 1,
			'two': 2,
			'three': {
				'four': 4
			},
			'five': [
				'six'
			]
		};

		assert.deepEqual( __.mixin( true, theObject ), theObject );
		assert.deepEqual( __.mixin( false, theObject ), theObject );
		assert.deepEqual( __.mixin( 1, theObject ), theObject );
		assert.deepEqual( __.mixin( -1, theObject ), theObject );
		assert.deepEqual( __.mixin( 1.1, theObject ), theObject );
		assert.deepEqual( __.mixin( -1.1, theObject ), theObject );
		assert.deepEqual( __.mixin( 0, theObject ), theObject );
		assert.deepEqual( __.mixin( 0.0, theObject ), theObject );
		assert.deepEqual( __.mixin( "string", theObject ), theObject );
		assert.deepEqual( __.mixin( "", theObject ), theObject );

		assert.deepEqual( __( true ).mixin( theObject ), theObject );
		assert.deepEqual( __( false ).mixin( theObject ), theObject );
		assert.deepEqual( __( 1 ).mixin( theObject ), theObject );
		assert.deepEqual( __( -1 ).mixin( theObject ), theObject );
		assert.deepEqual( __( 1.1 ).mixin( theObject ), theObject );
		assert.deepEqual( __( -1.1 ).mixin( theObject ), theObject );
		assert.deepEqual( __( 0 ).mixin( theObject ), theObject );
		assert.deepEqual( __( 0.0 ).mixin( theObject ), theObject );
		assert.deepEqual( __( "string" ).mixin( theObject ), theObject );
		assert.deepEqual( __( "" ).mixin( theObject ), theObject );

	} );

	it( 'should not mixin primitives over objects', function() {

		var theObject = {
			'one': 1,
			'two': 2,
			'three': {
				'four': 4
			},
			'five': [
				'six'
			]
		};

		assert.deepEqual( __.mixin( theObject, undefined ), theObject );
		assert.deepEqual( __.mixin( theObject, null ), theObject );
		assert.deepEqual( __.mixin( theObject, true ), theObject );
		assert.deepEqual( __.mixin( theObject, false ), theObject );
		assert.deepEqual( __.mixin( theObject, 1 ), theObject );
		assert.deepEqual( __.mixin( theObject, -1 ), theObject );
		assert.deepEqual( __.mixin( theObject, 1.1 ), theObject );
		assert.deepEqual( __.mixin( theObject, -1.1 ), theObject );
		assert.deepEqual( __.mixin( theObject, 0 ), theObject );
		assert.deepEqual( __.mixin( theObject, 0.0 ), theObject );
		assert.deepEqual( __.mixin( theObject, "string" ), theObject );
		assert.deepEqual( __.mixin( theObject, "" ), theObject );

		assert.deepEqual( __( theObject ).mixin( undefined ), theObject );
		assert.deepEqual( __( theObject ).mixin( null ), theObject );
		assert.deepEqual( __( theObject ).mixin( true ), theObject );
		assert.deepEqual( __( theObject ).mixin( false ), theObject );
		assert.deepEqual( __( theObject ).mixin( 1 ), theObject );
		assert.deepEqual( __( theObject ).mixin( -1 ), theObject );
		assert.deepEqual( __( theObject ).mixin( 1.1 ), theObject );
		assert.deepEqual( __( theObject ).mixin( -1.1 ), theObject );
		assert.deepEqual( __( theObject ).mixin( 0 ), theObject );
		assert.deepEqual( __( theObject ).mixin( 0.0 ), theObject );
		assert.deepEqual( __( theObject ).mixin( "string" ), theObject );
		assert.deepEqual( __( theObject ).mixin( "" ), theObject );

	} );

	it( 'should not mixin primitives over arrays', function() {

		var theArray = [
			'one',
			'two',
			{
				'three': 'four'
			},
			[
				'five'
			]
		];

		assert.deepEqual( __.mixin( theArray, undefined ), theArray );
		assert.deepEqual( __.mixin( theArray, null ), theArray );
		assert.deepEqual( __.mixin( theArray, true ), theArray );
		assert.deepEqual( __.mixin( theArray, false ), theArray );
		assert.deepEqual( __.mixin( theArray, 1 ), theArray );
		assert.deepEqual( __.mixin( theArray, -1 ), theArray );
		assert.deepEqual( __.mixin( theArray, 1.1 ), theArray );
		assert.deepEqual( __.mixin( theArray, -1.1 ), theArray );
		assert.deepEqual( __.mixin( theArray, 0 ), theArray );
		assert.deepEqual( __.mixin( theArray, 0.0 ), theArray );
		assert.deepEqual( __.mixin( theArray, "string" ), theArray );
		assert.deepEqual( __.mixin( theArray, "" ), theArray );

		assert.deepEqual( __( theArray ).mixin( undefined ), theArray );
		assert.deepEqual( __( theArray ).mixin( null ), theArray );
		assert.deepEqual( __( theArray ).mixin( true ), theArray );
		assert.deepEqual( __( theArray ).mixin( false ), theArray );
		assert.deepEqual( __( theArray ).mixin( 1 ), theArray );
		assert.deepEqual( __( theArray ).mixin( -1 ), theArray );
		assert.deepEqual( __( theArray ).mixin( 1.1 ), theArray );
		assert.deepEqual( __( theArray ).mixin( -1.1 ), theArray );
		assert.deepEqual( __( theArray ).mixin( 0 ), theArray );
		assert.deepEqual( __( theArray ).mixin( 0.0 ), theArray );
		assert.deepEqual( __( theArray ).mixin( "string" ), theArray );
		assert.deepEqual( __( theArray ).mixin( "" ), theArray );

	} );

	it( 'should not recurse beyond 100 levels', function() {
		assert.throws( function() {

			var mixinObject1 = {};
			var mixinObject2 = {};
			var ref1 = mixinObject1;
			var ref2 = mixinObject2;

			for ( var i = 0; i < 300; i++ ) {
				ref1.nesting = {};
				ref1 = ref1.nesting;
				ref2.nesting = {};
				ref2 = ref2.nesting;
			}

			ref1.final = "hi";
			ref2.final = "bye";

			__.mixin( mixinObject1, mixinObject2 );

		} );

		assert.throws( function() {

			var mixinObject1 = {};
			var mixinObject2 = {};
			var ref1 = mixinObject1;
			var ref2 = mixinObject2;

			for ( var i = 0; i < 300; i++ ) {
				ref1.nesting = {};
				ref1 = ref1.nesting;
				ref2.nesting = {};
				ref2 = ref2.nesting;
			}

			ref1.final = "hi";
			ref2.final = "bye";

			__( mixinObject1 ).mixin( mixinObject2 );

		} );
	} );

} );
