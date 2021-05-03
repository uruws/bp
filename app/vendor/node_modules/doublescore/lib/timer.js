'use strict';

exports.timer = function() {

	// account for overhead within this function, this may not be a good idea
	var offset = 1;

	var start = new Date().getTime() + offset;

	return function( reset ) {

		var diff = new Date().getTime() - start;

		if ( diff < 0 ) {
			diff = 0;
		}

		if ( reset ) {
			start = new Date().getTime() + offset;
		}

		return diff;

	};

};