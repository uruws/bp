'use strict';

var myArray = Array;

if ( !myArray.isArray ) {
	myArray = {
		isArray: function( arg ) {
			return Object.prototype.toString.call( arg ) === '[object Array]';
		}
	};
}

var Types = module.exports = {

	isArray: function( arg ) {
		return myArray.isArray( arg );
	},

	isNumber: function( arg ) {
		return typeof arg === 'number' && !isNaN( arg );
	},

	isObject: function( arg ) {
		return typeof arg === 'object' && !Types.isArray( arg ) && !(arg instanceof Number) && arg !== null;
	},

	getType: function( arg ) {

		if ( arg instanceof Number ) {
			arg = arg * 1;
		}

		// handle exceptions that typeof doesn't handle
		if ( arg === null ) {
			return 'null';
		} else if ( Types.isArray( arg ) ) {
			return 'array';
		} else if ( arg instanceof Date ) {
			return 'date';
		} else if ( arg instanceof RegExp ) {
			return 'regex';
		}

		var type = typeof arg;

		// more resolution on numbers
		if ( type === 'number' ) {

			if ( isNaN( arg ) ) {
				type = 'not-a-number';
			} else if ( Infinity === arg ) {
				type = 'infinity';
			} else if ( Math.ceil( arg ) > Math.floor( arg ) ) {
				type = 'float';
			} else {
				type = 'integer';
			}
		}

		return type;

	}

};