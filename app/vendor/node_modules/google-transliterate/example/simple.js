/*
 * google-transliterate
 * https://github.com/sanemat/node-google-transliterate
 *
 * Copyright (c) 2014 sanemat
 * Licensed under the MIT license.
 */

'use strict';

// Following the 'Node.js require(s) best practices' by
// http://www.mircozeiss.com/node-js-require-s-best-practices/

// // Nodejs libs
// var fs = require('fs'),
//
// // External libs
// debug = require('debug'),
//
// // Internal libs
// data = require('./data.js');

var googleTransliterate = require('../lib/google-transliterate.js');

googleTransliterate.transliterate('かんだ', 'ja-Hira', 'ja', function(err, transliteration){
  transliteration = [ [ 'かんだ', [ '神田', '噛んだ', '勘だ', 'かんだ', '鑑だ' ] ] ];
});

googleTransliterate.transliterate('おあややおやにおあやまり', 'ja-Hira', 'ja', function(err, transliteration){
  transliteration = [ [ 'おあやや', [ 'お文や', 'おあやや', 'お彩や', 'お綾や', 'Guuuuuuuu' ] ],
    [ 'おやに', [ '親に', 'おやに', 'オヤに', 'お屋に', 'お矢に' ] ],
    [ 'おあやまり', [ 'お誤り', 'お謝り', 'おあやまり', 'オアヤマリ', 'ｵｱﾔﾏﾘ' ] ] ];
});

googleTransliterate.transliterateFirst('かんだ', 'ja-Hira', 'ja', function(err, transliteration){
  transliteration = { original: ['かんだ'], result: ['神田'] };
});

googleTransliterate.transliterateFirst('おあややおやにおあやまり', 'ja-Hira', 'ja', function(err, transliteration){
  transliteration = { original: ['おあやや', 'おやに', 'おあやまり'], result: ['お文や', '親に', 'お誤り'] };
});


// //www.google.com/transliterate?langpair=ja-Hira|ja&text=%E3%81%B8%E3%82%93%E3%81%8B%E3%82%93&jsonp=?
// //www.google.com/transliterate?langpair=ja-Hira|ja&jsonp=?
//google.language.transliterate(["Namaste"], "en", "hi", function(result) {
//  if (!result.error) {
//    var container = document.getElementById("transliteration");
//    if (result.transliterations && result.transliterations.length > 0 &&
//      result.transliterations[0].transliteratedWords.length > 0) {
//      container.innerHTML = result.transliterations[0].transliteratedWords[0];
//    }
//  }
//});
//googleTranslate.translate('My name is Brandon', 'es', function(err, translation) {
//  console.log(translation.translatedText);
//  // =>  Mi nombre es Brandon
//});
