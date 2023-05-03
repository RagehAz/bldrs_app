import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){

  group('Phrase.copyWith', () {
    test('returns a new Phrase instance with the given id', () {
      const original = Phrase(id: 'original_id', langCode: 'en', value: 'hello', trigram: []);
      final copy = original.copyWith(id: 'new_id');
      expect(copy.id, equals('new_id'));
      expect(copy.langCode, equals('en'));
      expect(copy.value, equals('hello'));
      expect(copy.trigram, equals([]));
    });

    test('returns a new Phrase instance with the given langCode', () {
      const original = Phrase(id: 'original_id', langCode: 'en', value: 'hello', trigram: []);
      final copy = original.copyWith(langCode: 'es');
      expect(copy.id, equals('original_id'));
      expect(copy.langCode, equals('es'));
      expect(copy.value, equals('hello'));
      expect(copy.trigram, equals([]));
    });

    test('returns a new Phrase instance with the given value', () {
      const original = Phrase(id: 'original_id', langCode: 'en', value: 'hello', trigram: []);
      final copy = original.copyWith(value: 'hola');
      expect(copy.id, equals('original_id'));
      expect(copy.langCode, equals('en'));
      expect(copy.value, equals('hola'));
      expect(copy.trigram, equals([]));
    });

    test('returns a new Phrase instance with the given trigram', () {
      const original = Phrase(id: 'original_id', langCode: 'en', value: 'hello', trigram: []);
      final copy = original.copyWith(trigram: ['hel', 'ell', 'llo']);
      expect(copy.id, equals('original_id'));
      expect(copy.langCode, equals('en'));
      expect(copy.value, equals('hello'));
      expect(copy.trigram, equals(['hel', 'ell', 'llo']));
    });

    test('returns an identical Phrase instance if no parameters are given', () {
      const original = Phrase(id: 'original_id', langCode: 'en', value: 'hello', trigram: []);
      final copy = original.copyWith();
      expect(copy, equals(original));
    });
  });

  group('Phrase.completeTrigram', () {

    test('A', () {
      const phrase = Phrase(id: '1', value: 'hello', langCode: 'en', trigram: ['hel', 'ell', 'llo']);
      final result = phrase.completeTrigram();
      expect(result.id, equals('1'));
      expect(result.langCode, equals('en'));
      expect(result.value, equals('hello'));
      expect(result.trigram, equals(['hel', 'ell', 'llo']));
    });

    test('B', () {
      const phrase = Phrase(id: '2', value: 'hi', langCode: 'en', trigram: []);
      final result = phrase.completeTrigram();
      expect(result.id, equals('2'));
      expect(result.langCode, equals('en'));
      expect(result.value, equals('hi'));
      expect(result.trigram.isNotEmpty, true);
    });

  });

  group('Insert Phrases manual tests', () {
    const List<Phrase> _normalList = <Phrase>[
      Phrase(id: 'a', value: 'aaa', langCode: 'en'),
      Phrase(id: 'b', value: 'bbb', langCode: 'en'),
    ];

    // const List<Phrase> _mixedLangList = <Phrase>[
    //   Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
    //   Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
    // ];
    //
    // const List<Phrase> _duplicateIDsList = <Phrase>[
    //   Phrase(id: 'a', value: 'aaa', langCode: 'en'),
    //   Phrase(id: 'a', value: 'xxxxx', langCode: 'xr',),
    // ];

    const Phrase _extraPhrase = Phrase(id: 'c', value: 'ccc', langCode: 'en');
    const Phrase _aPhraseOverride = Phrase(id: 'a', value: 'fuck', langCode: 'xx');
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase', () {
      final List<Phrase> _phrases = Phrase.insertPhrase(
        phrases: _normalList,
        phrase: _extraPhrase,
        overrideDuplicateID: false,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'aaa', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        Phrase(id: 'c', value: 'ccc', langCode: 'en'),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase2', () {
      final List<Phrase> _phrases = Phrase.insertPhrase(
        phrases: _normalList,
        phrase: _aPhraseOverride,
        overrideDuplicateID: false,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'aaa', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase3', () {
      final List<Phrase> _phrases = Phrase.insertPhrase(
        phrases: _normalList,
        phrase: _aPhraseOverride,
        overrideDuplicateID: true,
        addLanguageCode: 'teez',
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'fuck', langCode: 'teez'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase3', () {
      final List<Phrase> _phrases = Phrase.insertPhrases(
        insertIn: const <Phrase>[
          Phrase(id: 'a', value: 'aaa', langCode: 'en'),
          Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        ],
        phrasesToInsert: const <Phrase>[
          Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'ar',
          ),
        ],
        overrideDuplicateID: true,
        // addLanguageCode:
        allowDuplicateIDs: false,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        Phrase(
          id: 'س',
          value: 'سسس',
          langCode: 'ar',
        ),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase4', () {
      final List<Phrase> _phrases = Phrase.insertPhrases(
        insertIn: const <Phrase>[
          Phrase(id: 'a', value: 'aaa', langCode: 'en'),
          Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        ],
        phrasesToInsert: const <Phrase>[
          Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'ar',
          ),
        ],
        overrideDuplicateID: false,
        // addLanguageCode:
        allowDuplicateIDs: true,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'aaa', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
        Phrase(
          id: 'س',
          value: 'سسس',
          langCode: 'ar',
        ),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase4', () {
      final List<Phrase> _phrases = Phrase.insertPhrases(
        insertIn: const <Phrase>[
          Phrase(id: 'a', value: 'aaa', langCode: 'en'),
          Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        ],
        phrasesToInsert: const <Phrase>[
          Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'ar',
          ),
        ],
        overrideDuplicateID: true,
        // addLanguageCode:
        allowDuplicateIDs: false,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        Phrase(
          id: 'س',
          value: 'سسس',
          langCode: 'ar',
        ),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('Phrase.insertPhrase5', () {
      final List<Phrase> _phrases = Phrase.insertPhrases(
        insertIn: const <Phrase>[
          Phrase(id: 'a', value: 'aaa', langCode: 'en'),
          Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        ],
        phrasesToInsert: const <Phrase>[
          Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'ar',
          ),
        ],
        overrideDuplicateID: false,
        // addLanguageCode:
        allowDuplicateIDs: false,
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(id: 'a', value: 'aaa', langCode: 'en'),
        Phrase(id: 'b', value: 'bbb', langCode: 'en'),
        Phrase(
          id: 'س',
          value: 'سسس',
          langCode: 'ar',
        ),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
    test('searchPhrasesByLangs', () {
      final List<Phrase> _phrases = Phrase.searchPhrasesByLangs(
        phrases: const <Phrase>[
          Phrase(id: 'a', value: 'aaa', langCode: 'en'),
          Phrase(id: 'b', value: 'bbb', langCode: 'en'),
          Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'ar',
          ),
          Phrase(
            id: 'س',
            value: 'سسس',
            langCode: 'x',
          ),
        ],
        langCodes: ['ar'],
      );
      const List<Phrase> _expectedList = <Phrase>[
        Phrase(
          id: 'س',
          value: 'سسس',
          langCode: 'ar',
        ),
        // Phrase(id: 'س', value: 'سسس', langCode: 'x',),
      ];
      expect(_phrases, _expectedList);
    });
    // -----------------------------------------------------------------------------
  });

}
