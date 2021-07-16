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
      int _uniqueVal = Numberers.createUniqueIntFrom(existingValues: _numbers);

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
}