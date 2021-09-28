import 'dart:ui';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';

void main(){

  List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
    {
      'id' : 'a',
      'name' : 'Ahmad',
    },
    {
      'id' : 'b',
      'name' : 'meshmesh',
    },
  ];

  test('test : list of maps contains', (){

    // setup

    // run

    // verify

  });

// -----------------------------------------------------------------------------
  test('correct input id = a', (){

    bool _result = Mapper.listOfMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'a',
    );
    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('in-correct input id = c', (){

    bool _result = Mapper.listOfMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'c',
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct input id = null', (){

    bool _result = Mapper.listOfMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: null,
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct field = koko, input = toto', (){

    bool _result = Mapper.listOfMapsContainValue(
      listOfMaps: _listOfMaps,
      field: 'koko',
      value: 'toto',
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------

  List<int> _numbers = <int>[0,1,2,3,4,5,6,7,8];

  test('createUniqueIntFrom', (){

    bool _allLoopsAreGood;

    for (int i = 0; i <= 1000; i++){
      int _uniqueVal = Numberers.createUniqueIndex(existingIndexes: _numbers);

      if (_numbers.contains(_uniqueVal)){
        _allLoopsAreGood == false;
        break;
      }

      else{
      _numbers.add(_uniqueVal);
      _allLoopsAreGood = true;
      }

    }

    expect(_allLoopsAreGood, true);

  });
// -----------------------------------------------------------------------------
  test('cipher and decipher color', (){

    Color _color = Color.fromARGB(76, 54, 32, 10);

    String _ciphered = Colorizer.cipherColor(_color);
    String _expectedString = '76*54*32*10'; // works

    Color _deciphered = Colorizer.decipherColor(_ciphered);
    String _decipheredToString = Colorizer.cipherColor(_deciphered);

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
    // print('_a       : $_a         : type : ${_a.runtimeType}');
    // print('_alpha   : $_alpha     : type : ${_alpha.runtimeType}');
    // print('_rX_gX_b : $_rX_gX_b   : type : ${_rX_gX_b.runtimeType}');
    // print('_r       : $_r         : type : ${_r.runtimeType}');
    // print('_red     : $_red       : type : ${_red.runtimeType}');
    // print('_gX_b    : $_gX_b      : type : ${_gX_b.runtimeType}');
    // print('_g       : $_g         : type : ${_g.runtimeType}');
    // print('_green   : $_green     : type : ${_green.runtimeType}');
    // print('_b       : $_b         : type : ${_b.runtimeType}');
    // print('_blue    : $_blue      : type : ${_blue.runtimeType}');

    print('_expectedString : $_expectedString');
    print('_decipheredToString : $_decipheredToString');
    print('_color.toString() : ${_color.toString()}');
    print('_deciphered.toString() : ${_deciphered.toString()}');

    expect(_expectedString, _decipheredToString);

  });

}