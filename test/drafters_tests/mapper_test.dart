import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  // -----------------------------------------------------------------------------

  /// CLEANING

  // --------------------
  const Map<String, dynamic> _map = {
    'id': 'id',
    'name': 'name',
    'phid': 'phid',
    'phidType': 'phidType',
    'thing': 0,
  };
  // --------------------
  test('cleanZeroValuesPairs', () {

    final Map<String, dynamic> _cleaned = Mapper.cleanZeroValuesPairs(
      map: _map,
    );

    const Map<String, dynamic> _expected = {
      'id': 'id',
      'name': 'name',
      'phid': 'phid',
      'phidType': 'phidType',
    };

    expect(_cleaned, _expected);

  });
  // --------------------
  test('removePair', () {

    final Map<String, dynamic> _a = Mapper.removePair(
      map: {},
      fieldKey: 'id',
    );
    expect(_a, {});

    final Map<String, dynamic> _b = Mapper.removePair(
      map: null,
      fieldKey: 'id',
    );
    expect(_b, {});


    final Map<String, dynamic> _c = Mapper.removePair(
      map: {'id' : 'x'},
      fieldKey: 'id',
    );
    expect(_c, {});

    final Map<String, dynamic> _d = Mapper.removePair(
      map: _map,
      fieldKey: 'id',
    );

    const Map<String, dynamic> _expected = {
      'name': 'name',
      'phid': 'phid',
      'phidType': 'phidType',
      'thing': 0,
    };

    expect(_d, _expected);



  });
  // --------------------


  // -----------------------------------------------------------------------------
}
