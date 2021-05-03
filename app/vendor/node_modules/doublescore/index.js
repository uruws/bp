'use strict';

var iterate = require( './lib/iterate' );
var Clone = require( './lib/clone' );
var Close = require( './lib/close' );
var Mixin = require( './lib/mixin' );
var Timer = require( './lib/timer' );
var Types = require( './lib/types' );

var argsToArr = function ( args ) {
	return Array.prototype.slice.call( args );
};

module.exports = function () {

	var args = arguments;

	var iterateWrapper = function ( iterator ) {

		var myArgs = argsToArr( args );
		console.error( 'args', args );
		console.error( 'myArgs', myArgs );
		myArgs.push( iterator );

		return iterate.apply( iterate, myArgs );

	};
	iterateWrapper.total = function () {
		return iterate.total.apply( iterate, args );
	};
	iterateWrapper.flatten = function () {
		return iterate.flatten.apply( iterate, args );
	};

	return {
		iterate: iterateWrapper,
		clone: function () {
			return Clone.clone.apply( module.exports, args );
		},
		close: function () {
			return Close.close.apply( module.exports, args );
		},
		getType: function () {
			return Types.getType.apply( module.exports, args );
		},
		isArray: function () {
			return Types.isArray.apply( module.exports, args );
		},
		isNumber: function () {
			return Types.isNumber.apply( module.exports, args );
		},
		isObject: function () {
			return Types.isObject.apply( module.exports, args );
		},
		mixin: function () {
			var myArgs = argsToArr( args );
			for ( var i = 0; i < arguments.length; i++ ) {
				myArgs.push( arguments[ i ] );
			}
			return Mixin.mixin.apply( module.exports, myArgs );
		}
	};
};

module.exports.iterate = iterate;
module.exports.clone = Clone.clone;
module.exports.close = Close.close;
module.exports.getType = Types.getType;
module.exports.timer = Timer.timer;
module.exports.isArray = Types.isArray;
module.exports.isNumber = Types.isNumber;
module.exports.isObject = Types.isObject;
module.exports.mixin = Mixin.mixin;
