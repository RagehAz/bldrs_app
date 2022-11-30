

import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main (){

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
        Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
      ],
      overrideDuplicateID: true,
      // addLanguageCode:
      allowDuplicateIDs: false,
    );
    const List<Phrase> _expectedList = <Phrase>[
      Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
      Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
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
        Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
      ],
      overrideDuplicateID: false,
      // addLanguageCode:
      allowDuplicateIDs: true,
    );
    const List<Phrase> _expectedList = <Phrase>[
      Phrase(id: 'a', value: 'aaa', langCode: 'en'),
      Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
      Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
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
        Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
      ],
      overrideDuplicateID: true,
      // addLanguageCode:
      allowDuplicateIDs: false,
    );
    const List<Phrase> _expectedList = <Phrase>[
      Phrase(id: 'a', value: 'bibooo', langCode: 'en'),
      Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
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
        Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
      ],
      overrideDuplicateID: false,
      // addLanguageCode:
      allowDuplicateIDs: false,
    );
    const List<Phrase> _expectedList = <Phrase>[
      Phrase(id: 'a', value: 'aaa', langCode: 'en'),
      Phrase(id: 'b', value: 'bbb', langCode: 'en'),
      Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
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
        Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
        Phrase(id: 'س', value: 'سسس', langCode: 'x',),
      ],
      langCodes: ['ar'],
    );
    const List<Phrase> _expectedList = <Phrase>[
      Phrase(id: 'س', value: 'سسس', langCode: 'ar',),
      // Phrase(id: 'س', value: 'سسس', langCode: 'x',),
    ];
    expect(_phrases, _expectedList);
  });
  // -----------------------------------------------------------------------------
}
