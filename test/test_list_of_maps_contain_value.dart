import 'dart:ui';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:mapper/mapper.dart';
import 'package:numeric/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 'a',
      'name': 'Ahmad',
    },
    <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    },
  ];

  test('test : list of maps contains', () {
    // setup

    // run

    // verify
  });

// -----------------------------------------------------------------------------
  test('correct input id = a', () {
    final bool _result = Mapper.checkMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'a',
    );
    expect(_result, true);
  });
// -----------------------------------------------------------------------------
  test('in-correct input id = c', () {
    final bool _result = Mapper.checkMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'c',
    );
    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('in-correct input id = null', () {
    final bool _result = Mapper.checkMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: null,
    );
    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('in-correct field = koko, input = toto', () {
    final bool _result = Mapper.checkMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'koko',
      value: 'toto',
    );
    expect(_result, false);
  });
// -----------------------------------------------------------------------------

  final List<int> _numbers = <int>[0, 1, 2, 3, 4, 5, 6, 7, 8];

  test('createUniqueIntFrom', () {
    bool _allLoopsAreGood;

    for (int i = 0; i <= 1000; i++) {

      final int _uniqueVal = Numeric.createUniqueIndex(existingIndexes: _numbers);

      if (_numbers.contains(_uniqueVal)) {
        _allLoopsAreGood = false;
        break;
      } else {
        _numbers.add(_uniqueVal);
        _allLoopsAreGood = true;
      }
    }

    expect(_allLoopsAreGood, true);
  });
// -----------------------------------------------------------------------------
  test('cipher and decipher color', () {
    const Color _color = Color.fromARGB(76, 54, 32, 10);

    final String _ciphered = Colorizer.cipherColor(_color);
    const String _expectedString = '76*54*32*10'; // works

    final Color _deciphered = Colorizer.decipherColor(_ciphered);
    final String _decipheredToString = Colorizer.cipherColor(_deciphered);

    /// ALPHA
    // String _a = TextMod.trimTextAfterFirstSpecialCharacter(_ciphered, '*');
    // int _alpha = Numberers.stringToInt(_a);
    //
    // /// RED
    // String _rX_gX_b = TextMod.trimTextBeforeFirstSpecialCharacter(_ciphered, '*');
    // String _r = TextMod.trimTextAfterFirstSpecialCharacter(_rX_gX_b, '*');
    // int _red = Numberers.stringToInt(_r);
    //
    // /// GREEN
    // String _gX_b = TextMod.trimTextBeforeFirstSpecialCharacter(_rX_gX_b, '*');
    // String _g = TextMod.trimTextAfterFirstSpecialCharacter(_gX_b, '*');
    // int _green = Numberers.stringToInt(_g);
    //
    // /// BLUE
    // String _b = TextMod.trimTextBeforeFirstSpecialCharacter(_gX_b, '*');
    // int _blue = Numberers.stringToInt(_b);
    //
    // blog('_a       : $_a         : type : ${_a.runtimeType}');
    // blog('_alpha   : $_alpha     : type : ${_alpha.runtimeType}');
    // blog('_rX_gX_b : $_rX_gX_b   : type : ${_rX_gX_b.runtimeType}');
    // blog('_r       : $_r         : type : ${_r.runtimeType}');
    // blog('_red     : $_red       : type : ${_red.runtimeType}');
    // blog('_gX_b    : $_gX_b      : type : ${_gX_b.runtimeType}');
    // blog('_g       : $_g         : type : ${_g.runtimeType}');
    // blog('_green   : $_green     : type : ${_green.runtimeType}');
    // blog('_b       : $_b         : type : ${_b.runtimeType}');
    // blog('_blue    : $_blue      : type : ${_blue.runtimeType}');

    blog('_expectedString : $_expectedString');
    blog('_decipheredToString : $_decipheredToString');
    blog('_color.toString() : ${_color.toString()}');
    blog('_deciphered.toString() : ${_deciphered.toString()}');

    expect(_expectedString, _decipheredToString);
  });
}
