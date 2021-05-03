doublescore
====================

A natively written, no external dependency utility library.


These are the available utility functions.


iterate()

```javascript

var __ = require( 'doublescore' );

__([0, { one: 1}, [2, 3] ]).iterate(function( value, index) {
	/** is called 4 times with the params value/index:
	 * 0/[0]
	 * 1/[1,'one']
	 * 2/[2, 0]
	 * 3/[2, 1]
	 */

});

```


close() 

```javascript

var __ = require( 'doublescore' );

close = __( {
	timeout: 30000
} ).close()

function doSomething( params, done ) {

	// ensure done is called within 30 seconds, multiple calls ignored
	done = close( done );
	
	someIoCall( params, done );

}
```

Returns a function used to generate callbacks with a service level of max calls and minimum TTL until callback errors


isObject() 

Will return TRUE for anything that is typeof object, is not an Array, and is not NULL.

```javascript

var __ = require( 'doublescore' );

__.isObject( new Date() ); // true
__.isObject( {} ); // true
__.isObject( null ); // false
__.isObject( "hello" ); // false
__.isObject( Infinity ); // false
__.isObject( 5 ); // false
__.isObject( true ); // false

```


getType() 

Will return 'null' for NULL, 'array' for an Array, 'float' for a non-integer number, 'integer' for an integer number, and typeof result for all else.


clone() 

Will return a distinct copy of the object it was called from. Date objects are cloned, arrays and objects are recursively cloned down 100 levels max and all else is just passed through.


mixin() 

Applies clone() to params and then recursively mixes all values into default. If types do not match, params type is taken. mixin() accepts an arbitrary number of arguments, they will be mixed in from left to right.

```javascript

var __ = require( 'doublescore' );

function doSomething  ( params, done ) {

    // sets defaults recursively
	params = __( {
		deep: [
			{
				merge: 'on this default object of'
			}
		],
		strings: {
			objects: 'and',
			numbers: 1.5
		},
		and: null,
		boolean: true,
		etc: [ false, false ],
		from: 'params'
	} ).mixin( params );
	
	//... 
	
	done();

}
```

timer() 

Will return a function that will track time deltas with 1ms resolution and < 0.1% error on average. The returned function accepts a single parameter: reset, which if true will reset the timer, returning the last interval

NOTE: timer() is experimental. 0.5% margin of error for both precision and accuracy at best, probably closer to 1% for most intervals of time. However, deviance is constant regardless of actual time interval measured. Thus, error rates for higher intervals (> 100ms) will be considerably lower than those for short intervals (< 50ms).
 

Usage
====================

The usage for doublescore is patterned after other utility libraries like underscore. BUT, it is not interchangeable.


More examples
=============

Please see the test cases in test/default.js for extensive examples of all supported use cases.


License
====================

(The MIT License)

Copyright (c) 2016 BlueRival Software <support@bluerival.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
