import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class PendingAuthor {
  // -----------------------------------------------------------------------------
  const PendingAuthor({
    required this.userID,
    required this.noteID,
  });
  // -----------------------------------------------------------------------------
  final String userID;
  final String noteID;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? cipherPendingAuthors(List<PendingAuthor>? pendings){
    Map<String, dynamic>? _map;

    if (Lister.checkCanLoop(pendings) == true){

      _map = {};

      for (final PendingAuthor pending in pendings!){

        _map = Mapper.insertPairInMap(
          map: _map,
          key: pending.userID,
          value: pending.noteID,
          overrideExisting: true,
        );

      }

    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PendingAuthor> decipherPendingAuthors(Map<String, dynamic>? map){
    final List<PendingAuthor> _output = <PendingAuthor>[];

    if (map != null){

      final List<String> _usersIDs = map.keys.toList();

      if (Lister.checkCanLoop(_usersIDs) == true){

        for (final String userID in _usersIDs){

          final PendingAuthor _pendingAuthor = PendingAuthor(
              userID: userID,
              noteID: map[userID],
          );

          _output.add(_pendingAuthor);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPendingsUsersIDs(List<PendingAuthor>? pendingAuthors){
    final List<String> _usersIDs = <String>[];

    if (Lister.checkCanLoop(pendingAuthors) == true){

      final Map<String, dynamic>? _map = cipherPendingAuthors(pendingAuthors);
      if (_map != null){
        _usersIDs.addAll(_map.keys.toList());
      }

    }

    return _usersIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PendingAuthor? getModelByUserID({
    required List<PendingAuthor>? pendingAuthors,
    required String? userID,
  }){
    PendingAuthor? _output;

    if (Lister.checkCanLoop(pendingAuthors) == true && userID != null){
      _output = pendingAuthors!.firstWhere((element) => element.userID == userID);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PendingAuthor> addNewPendingAuthor({
    required List<PendingAuthor>? pendingAuthors,
    required String? userID,
    required String? noteID,
  }){
    final List<PendingAuthor> _output = <PendingAuthor>[];

    if (Lister.checkCanLoop(pendingAuthors) == true){
      _output.addAll(pendingAuthors!);
    }

    if (userID != null && noteID != null){
      final PendingAuthor _newPending = PendingAuthor(
        userID: userID,
        noteID: noteID,
      );
      _output.add(_newPending);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PendingAuthor> removePendingAuthor({
    required List<PendingAuthor>? pendingAuthors,
    required String? userID,
  }){
    final List<PendingAuthor> _output = <PendingAuthor>[];

    if (Lister.checkCanLoop(pendingAuthors) == true){
      _output.addAll(pendingAuthors!);
    }

    if (userID != null){
      _output.removeWhere((element) => element.userID == userID);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel? removePendingAuthorFromBz({
    required BzModel? bzModel,
    required String? userID,
  }){
    BzModel? _bzModel = bzModel;

    if (bzModel != null){

      final List<PendingAuthor> _updatedPendingAuthors = removePendingAuthor(
        pendingAuthors: bzModel.pendingAuthors,
        userID: userID,
      );

      _bzModel = _bzModel!.copyWith(
        pendingAuthors: _updatedPendingAuthors,
      );

    }

    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPendingsAuthorsAreIdentical({
    required PendingAuthor? pending1,
    required PendingAuthor? pending2,
  }){
    bool _identical = false;

    if (pending1 == null && pending2 == null){
      _identical = true;
    }

    else if (pending1 != null && pending2 != null){

      if (
      pending1.noteID == pending2.noteID &&
      pending1.userID == pending2.userID
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPendingAuthorsListsAreIdentical({
    required List<PendingAuthor>? list1,
    required List<PendingAuthor>? list2,
  }){
    bool _listsAreIdentical = false;

    if (list1 == null && list2 == null){
      _listsAreIdentical = true;
    }
    else if (list1 != null && list1.isEmpty == true && list2 != null && list2.isEmpty == true){
      _listsAreIdentical = true;
    }

    else if (Lister.checkCanLoop(list1) == true && Lister.checkCanLoop(list2) == true){

      if (list1!.length != list2!.length) {
        // blog('lists do not have the same length : list1 is ${list1.length} : list2 is ${list2.length}');
        // blog(' ---> lis1 is ( ${list1.toString()} )');
        // blog(' ---> lis2 is ( ${list2.toString()} )');
        _listsAreIdentical = false;
      }

      else {
        for (int i = 0; i < list1.length; i++) {

          if (list1[i].userID != list2[i].userID) {
            _listsAreIdentical = false;
            break;
          }
          else if (list1[i].noteID != list2[i].noteID) {
            _listsAreIdentical = false;
            break;
          }
          else {
            _listsAreIdentical = true;
          }

        }
      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPendingAuthorsIncludeUserID({
    required List<PendingAuthor>? pendingAuthors,
    required String? userID,
  }){

    final List<String> usersIDs = getPendingsUsersIDs(pendingAuthors);

    return Stringer.checkStringsContainString(
        strings: usersIDs,
        string: userID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanInviteUser({
    required BzModel? bzModel,
    required String? userID,
  }){
    bool _can = false;

    if (bzModel != null && userID != null){

      final bool _isAuthor = AuthorModel.checkAuthorsContainUserID(
        authors: bzModel.authors,
        userID: userID,
      );

      final bool _isPendingAuthor = checkPendingAuthorsIncludeUserID(
        pendingAuthors: bzModel.pendingAuthors,
        userID: userID,
      );

      if (_isAuthor == true || _isPendingAuthor == true){
        _can = false;
      }
      else {
        _can = true;
      }

    }

    return _can;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPendingAuthor({
    required BzModel? bzModel,
    required String? userID,
  }){

    final List<String> _usersIDs = getPendingsUsersIDs(bzModel?.pendingAuthors);

    blog('checkIsPendingAuthor : _usersIDs : $_usersIDs : bzModel : ${bzModel?.id} : userID : $userID');

    return Stringer.checkStringsContainString(
      strings: _usersIDs,
      string: userID,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPendingAuthors(List<PendingAuthor>? pendingAuthors){

    if (Lister.checkCanLoop(pendingAuthors) == true){

      for (int i = 0; i < pendingAuthors!.length; i++){

        final PendingAuthor pending = pendingAuthors[i];

        blog('${i+1} : PendingAuthor : userID ${pending.userID} : noteID ${pending.noteID}');

      }

    }

    else {
      blog('X : PendingAuthor : No pending authors found');
    }

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is PendingAuthor){
      _areIdentical = checkPendingsAuthorsAreIdentical(
        pending1: this,
        pending2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      userID.hashCode^
      noteID.hashCode;
  // -----------------------------------------------------------------------------
}
