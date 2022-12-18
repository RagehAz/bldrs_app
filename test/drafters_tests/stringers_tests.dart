import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  // -----------------------------------------------------------------------------

  /// STRINGS ADDED AND REMOVED

  // --------------------
  const List<String> _oldList =            <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];
  const List<String> _newWithAdded =   <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k'];
  const List<String> _newWithRemoved = <String>['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'];
  // --------------------
  test('getAddedStrings', () {

    final List<String> _added = Stringer.getAddedStrings(
      oldStrings: _oldList,
      newStrings: _newWithAdded,
    );
    expect(_added, ['k']);


  });
  // --------------------
  test('getRemovedStrings', () {

    final List<String> _removed = Stringer.getRemovedStrings(
      oldStrings: _oldList,
      newStrings: _newWithRemoved,
    );
    expect(_removed, ['j']);

    final List<String> _removed2 = Stringer.getRemovedStrings(
      oldStrings: [],
      newStrings: _newWithRemoved,
    );
    expect(_removed2, []);

    final List<String> _removed3 = Stringer.getRemovedStrings(
      oldStrings: null,
      newStrings: _newWithRemoved,
    );
    expect(_removed3, []);


    final List<String> _removed4 = Stringer.getRemovedStrings(
      oldStrings: [null],
      newStrings: _newWithRemoved,
    );
    expect(_removed4, [null]); // indeed it should remove the null


  });
  // -----------------------------------------------------------------------------
  void f(){}
}
