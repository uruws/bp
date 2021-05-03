'use strict';

var googleTransliterate = require('../lib/google-transliterate.js');
var assert = require('power-assert');
var nock = require('nock');

describe('googleTransliterate.transliterate', function () {
  it('should transliterate', function (done) {
    nock('https://www.google.com')
      .get('/transliterate?langpair=ja-Hira|ja&text=' + encodeURI('かんだ'))
      .replyWithFile(200, __dirname + '/kanda.json');
    googleTransliterate.transliterate('かんだ', 'ja-Hira', 'ja', function(err, transliteration){
      assert.deepEqual(transliteration, [ [ 'かんだ', [ '神田', '噛んだ', '勘だ', 'かんだ', 'HOOOOOO' ] ] ]);
      done();
    });
  });

  it('should transliterate multi literal', function (done) {
    nock('https://www.google.com')
      .get('/transliterate?langpair=ja-Hira|ja&text=' + encodeURI('おあややおやにおあやまり'))
      .replyWithFile(200, __dirname + '/oayaya.json');
    googleTransliterate.transliterate('おあややおやにおあやまり', 'ja-Hira', 'ja', function(err, transliteration){
      assert.deepEqual(transliteration,
        [ [ 'おあやや', [ 'お文や', 'おあやや', 'お彩や', 'お綾や', 'Guuuuuuuu' ] ],
        [ 'おやに', [ '親に', 'おやに', 'オヤに', 'お屋に', 'お矢に' ] ],
        [ 'おあやまり', [ 'お誤り', 'お謝り', 'おあやまり', 'オアヤマリ', 'ｵｱﾔﾏﾘ' ] ] ]);
      done();
    });
  });
});

describe('googleTransliterate.transliterateFirst', function () {
  it('should transliterateFirst', function (done) {
    nock('https://www.google.com')
      .get('/transliterate?langpair=ja-Hira|ja&text=' + encodeURI('かんだ'))
      .replyWithFile(200, __dirname + '/kanda.json');
    googleTransliterate.transliterateFirst('かんだ', 'ja-Hira', 'ja', function(err, transliteration){
      assert.deepEqual(transliteration, {original: ['かんだ'], result: ['神田']});
      done();
    });
  });

  it('should transliterateFirst multi literal', function (done) {
    nock('https://www.google.com')
      .get('/transliterate?langpair=ja-Hira|ja&text=' + encodeURI('おあややおやにおあやまり'))
      .replyWithFile(200, __dirname + '/oayaya.json');
    googleTransliterate.transliterateFirst('おあややおやにおあやまり', 'ja-Hira', 'ja', function(err, transliteration){
      assert.deepEqual(transliteration, {original: ['おあやや', 'おやに', 'おあやまり'], result: ['お文や', '親に', 'お誤り']});
      done();
    });
  });
});
