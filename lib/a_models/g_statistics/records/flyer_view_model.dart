import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class FlyerViewModel {
  // -----------------------------------------------------------------------------
  const FlyerViewModel({
    required this.userID,
    required this.index,
    required this.time,
  });
  // --------------------
  final String userID;
  final int index;
  final DateTime? time;
  // -----------------------------------------------------------------------------

  /// CIPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){

    return {
      'userID': userID,
      'time': Timers.cipherTime(
      time: time,
      toJSON: true,
    ),
    };

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? toPairKey(){
    return createID(
      userID: userID,
      index: index,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerViewModel? decipher({
    required String viewID,
    required Map<String, dynamic>? map,
  }){
    FlyerViewModel? _output;

    if (map != null){

      final String? _userID = getUserIDFromViewRecordModelID(
        recordID: viewID,
      );

      final int? _index = getSlideIndexFromViewRecordModelID(
        recordID: viewID,
      );

      if (_userID != null && _index != null){
        _output = FlyerViewModel(
          userID: _userID,
          index: _index,
          time: Timers.decipherTime(time: map['time'], fromJSON: true),
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerViewModel> decipherMaps({
    required List<Map<String, dynamic>>? maps,
  }){
    final List<FlyerViewModel> _output = [];

    if (Lister.checkCanLoop(maps) == true){

      for (final Map<String, dynamic> map in maps!){

        final FlyerViewModel? _model = decipher(
            viewID: map['id'],
            map: map,
        );

        if (_model != null){
          _output.add(_model);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PATH NODES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createID({
    required String? userID,
    required int? index,
  }){

    if (userID == null || index == null){
      return null;
    }

    else {
      return '${userID}_$index';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getUserIDFromViewRecordModelID({
    required String? recordID,
  }){

    if (recordID == null){
      return null;
    }

    else {
      return TextMod.removeTextAfterFirstSpecialCharacter(
          text: recordID,
          specialCharacter: '_',
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? getSlideIndexFromViewRecordModelID({
    required String? recordID,
  }){
    int? _output;

    final String? _text = TextMod.removeTextBeforeFirstSpecialCharacter(
      text: recordID,
      specialCharacter: '_',
    );

    if (_text != null){
      _output = Numeric.transformStringToInt(_text);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUsersIDsFromRecords({
    required List<FlyerViewModel>? models,
  }){
    List<String> _output = [];

    if (Lister.checkCanLoop(models) == true){

      for (final FlyerViewModel model in models!){
        _output = Stringer.addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: model.userID
        );
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkViewsModelsAreIdentical({
    required FlyerViewModel? model1,
    required FlyerViewModel? model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
          model1.userID == model2.userID &&
          model1.index == model2.index &&
          Timers.checkTimesAreIdentical(
              accuracy: TimeAccuracy.second,
              time1: model1.time,
              time2: model1.time
          ) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
      FlyerViewModel(
        userID: $userID
        index: $index
        time: $time
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FlyerViewModel){
      _areIdentical = checkViewsModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      userID.hashCode^
      index.hashCode^
      time.hashCode;
  // -----------------------------------------------------------------------------
}
