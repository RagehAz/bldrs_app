import 'package:flutter_test/flutter_test.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';

void main(){

  List<Map<String, dynamic>> _listOfMaps = [
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

    bool _result = Mapper.listOfMapsContains(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'a',
    );
    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('in-correct input id = c', (){

    bool _result = Mapper.listOfMapsContains(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: 'c',
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct input id = null', (){

    bool _result = Mapper.listOfMapsContains(
      listOfMaps: _listOfMaps,
      field: 'id',
      value: null,
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct field = koko, input = toto', (){

    bool _result = Mapper.listOfMapsContains(
      listOfMaps: _listOfMaps,
      field: 'koko',
      value: 'toto',
    );
    expect(_result, false);

  });
// -----------------------------------------------------------------------------
}