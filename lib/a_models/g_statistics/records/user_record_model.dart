// ignore_for_file: non_constant_identifier_names
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class UserRecordModel {
  // -----------------------------------------------------------------------------
  const UserRecordModel({
    required this.id,
    required this.userID,
    required this.recordType,
    required this.time,
    required this.modelID,
  });
  // --------------------
  final String? id;
  final String? userID;
  final RecordType? recordType;
  final DateTime? time;
  final String? modelID;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  UserRecordModel copyWith({
    String? id,
    String? userID,
    RecordType? recordType,
    DateTime? time,
    String? modelID,
  }){
    return UserRecordModel(
      id: id ?? this.id,
      userID: userID ?? this.userID,
      recordType: recordType ?? this.recordType,
      time: time ?? this.time,
      modelID: modelID ?? this.modelID,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      // 'id' : id,
      // 'userID' : userID,
      'recordType' : RecordTyper.cipherRecordType(recordType),
      'time' : Timers.cipherTime(time: time, toJSON: true),
      'modelID' : modelID,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserRecordModel> decipherAllUserRecordsMap({
    required String userID,
    required Map<String, dynamic>? map,
  }){
    final List<UserRecordModel> _output = [];

    if (map != null){

      /// DAYS NODES
      final List<String> _keys = map.keys.toList();
      _keys.remove('id');

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String dayNode in _keys){

          final List<UserRecordModel> _dayRecords = decipherDayNodeMap(
            userID: userID,
            dayMap: map[dayNode],
          );

          _output.addAll(_dayRecords);

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserRecordModel> decipherDayNodeMap({
    required String userID,
    required Map<String, dynamic>? dayMap,
  }){
    final List<UserRecordModel> _output = [];

    if (dayMap != null){

      // blog('dayMap is : $dayMap');

      final List<String> _recordsIDs = dayMap.keys.toList();
      _recordsIDs.remove('id');

      if (Mapper.checkCanLoopList(_recordsIDs) == true){

        for (final String recordID in _recordsIDs){

          final Map<String, dynamic> _recordMap = dayMap[recordID];

          final UserRecordModel _record = UserRecordModel(
            id: recordID,
            userID: userID,
            modelID: _recordMap['modelID'],
            recordType: RecordTyper.decipherRecordType(_recordMap['recordType']),
            time: Timers.decipherTime(time: _recordMap['time'], fromJSON: true),
          );

          _output.add(_record);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static UserRecordModel generatorsSessionRecord({
    required String userID,
  }){
    return UserRecordModel(
        recordType: RecordType.session,
        userID: userID,
        time: DateTime.now(),
        modelID: null,
        id: null,
    );
  }
  // -----------------------------------------------------------------------------

  /// PATH NODES

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherDayNodeName({
    required DateTime? dateTime,
  }){

    if (dateTime == null){
      return null;
    }
    else {

      final String? _year = Numeric.formatIntWithinDigits(
        num: dateTime.year,
        digits: 4,
      );
      final String? _month = Numeric.formatIntWithinDigits(
        num: dateTime.month,
        digits: 2,
      );
      final String? _day = Numeric.formatIntWithinDigits(
        num: dateTime.day,
        digits: 2,
      );

      if (_year == null || _month == null || _day == null){
        return null;
      }
      else {
        return 'd_${_year}_${_month}_$_day';
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DateTime? decipherDayNodeName({
    required String? nodeName,
  }){

    /// d_yyyy_mm_dd

    if (TextCheck.isEmpty(nodeName) == true){
      return null;
    }
    else {

      final String yyyy_mm_dd = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: nodeName,
          specialCharacter: '_',
      )!;
      final String yyyy_mm = TextMod.removeTextAfterLastSpecialCharacter(
          text: yyyy_mm_dd,
          specialCharacter: '_',
      )!;

      final String yyyy = TextMod.removeTextAfterLastSpecialCharacter(
          text: yyyy_mm,
          specialCharacter: '_',
      )!;
      final String mm = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: yyyy_mm,
          specialCharacter: '_',
      )!;
      final String dd = TextMod.removeTextBeforeLastSpecialCharacter(
          text: yyyy_mm_dd,
          specialCharacter: '_',
      )!;

      final int? year = Numeric.transformStringToInt(yyyy);
      final int? month = Numeric.transformStringToInt(mm);
      final int? day = Numeric.transformStringToInt(dd);

      if (year == null || month == null || day == null){
        return null;
      }

      else {
        return Timers.createDate(
            year: year,
            month: month,
            day: day
        );
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> sortUserRecordsDays({
    required List<Map<String, dynamic>>? maps,
    required bool ascending,
  }){
    List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(maps) == true){

      _output = <Map<String, dynamic>>[...maps!];

      _output.sort((Map<String, dynamic> a, Map<String, dynamic> b){

        final DateTime? _a = decipherDayNodeName(nodeName: a['id']);
        final DateTime? _b = decipherDayNodeName(nodeName: b['id']);

        if (_a == null){
          return 1;
        }
        else if (_b == null){
          return -1;
        }
        else {
          if (ascending == true){
            return _a.compareTo(_b);
          }
          else {
            return _b.compareTo(_a);
          }
        }

      });

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserRecordModel> sortRecordsByTime(List<UserRecordModel> records){
    List<UserRecordModel> _output = [];

    if (Mapper.checkCanLoopList(records) == true){

      _output = [...records];

      _output.sort((UserRecordModel a, UserRecordModel b){

        final DateTime? _a = a.time;
        final DateTime? _b = b.time;

        if (_a != null && _b != null){
          return _a.compareTo(_b);
        }
        else {
          return 0;
        }

      });

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkRecordsAreIdentical({
    required UserRecordModel? record1,
    required UserRecordModel? record2,
  }){
    bool _identical = false;

    if (record1 == null && record2 == null){
      _identical = true;
    }

    else if (record1 != null && record2 != null){

      if (
          record1.id == record2.id &&
          record1.userID == record2.userID &&
          record1.recordType == record2.recordType &&
          Timers.checkTimesAreIdentical(
              accuracy: TimeAccuracy.second,
              time1: record1.time,
              time2: record2.time
          ) == true &&
          record1.modelID == record2.modelID
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  @override
  String toString() =>
      '''
      UserRecordModel(
         id: $id
         userID: $userID
         recordType: ${RecordTyper.cipherRecordType(recordType)}
         time: $time
         modelID: $modelID
      )
      ''';
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is UserRecordModel){
      _areIdentical = checkRecordsAreIdentical(
        record1: this,
        record2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      userID.hashCode^
      recordType.hashCode^
      time.hashCode^
      modelID.hashCode;
  // -----------------------------------------------------------------------------
}
