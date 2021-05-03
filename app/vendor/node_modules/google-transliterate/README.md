# google-transliterate
[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Dependency Status][daviddm-url]][daviddm-image] [![Coverage Status][coveralls-image]][coveralls-url]

Non-official Google Transliterate API for Node.js

## Note
  - Important: The Google Transliteration API has been officially deprecated as of May 26, 2011.
  - https://developers.google.com/transliterate/
  - https://developers.google.com/transliterate/v1/getting_started
  - http://www.google.co.jp/ime/cgiapi.html

## Install

```bash
$ npm install --save google-transliterate
```


## Usage

```javascript
var googleTransliterate = require('google-transliterate');

googleTransliterate.transliterate('おあややおやにおあやまり', 'ja-Hira', 'ja', function(err, transliteration){
  transliteration = [
    [ 'おあやや', [ 'お文や', 'おあやや', 'お彩や', 'お綾や', 'オアヤヤ' ] ],
    [ 'おやに', [ '親に', 'おやに', 'オヤに', 'お屋に', 'お矢に' ] ],
    [ 'おあやまり', [ 'お誤り', 'お謝り', 'おあやまり', 'オアヤマリ', 'ｵｱﾔﾏﾘ' ] ]
  ];
});
```

## Contributing

In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [gulp](http://gulpjs.com/).


## Release History

0.1.0 release

## License

Copyright (c) 2014 sanemat. Licensed under the MIT license.



[npm-url]: https://npmjs.org/package/google-transliterate
[npm-image]: https://badge.fury.io/js/google-transliterate.svg
[travis-url]: https://travis-ci.org/sanemat/node-google-transliterate
[travis-image]: https://travis-ci.org/sanemat/node-google-transliterate.svg?branch=master
[daviddm-url]: https://david-dm.org/sanemat/node-google-transliterate.svg?theme=shields.io
[daviddm-image]: https://david-dm.org/sanemat/node-google-transliterate
[coveralls-url]: https://coveralls.io/r/sanemat/node-google-transliterate
[coveralls-image]: https://coveralls.io/repos/sanemat/node-google-transliterate/badge.png
