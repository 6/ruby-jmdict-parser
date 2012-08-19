This projects makes Jim Breen's JMDict-related files available in JSON format in UTF-8 encoding. Why? Many of the files are still stored as flat files in EUC-JP or JIS X encodings, rendering them difficult to work with.

See `json-output` folder for the JSON files.

`kanji_radicals.json` is a mapping of each kanji to a list of the radicals contained in that kanji. `radical_kanjis.json` is the inverse of `kanji_radicals.json`.

TODO:
- support for other data files
- better readme examples
