/*
 * google-transliterate
 * https://github.com/sanemat/node-google-transliterate
 *
 * Copyright (c) 2014 sanemat
 * Licensed under the MIT license.
 */

'use strict';

var jsonpClient = require('jsonp-client');
var URITemplate = require('URIjs/src/URITemplate');

var template = new URITemplate('https://www.google.com/transliterate?langpair={srcLang}|{destLang}&text={words}');

module.exports.transliterate = function(words, srcLang, destLang, callback){
  var url = template.expand({ srcLang: srcLang, destLang: destLang, words: words });
  jsonpClient(url, function (err, data) {
    callback(err, data);
  });
};

module.exports.transliterateFirst = function(words, srcLang, destLang, callback){
  var self = this;
  self.transliterate(words, srcLang, destLang, function(err, data){
    var keys = data.map(function(datum){ return datum[0]; });
    var values = data.map(function(datum){ return datum[1][0]; });
    var result = {original: keys, result: values};
    callback(err, result);
  });
};
