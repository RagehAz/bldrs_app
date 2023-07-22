import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:flutter/material.dart';

enum PublishState {
  draft,
  pending,
  published,
  unpublished,
  suspended,
}

/// => TAMAM
@immutable
class PublicationModel {
  // --------------------------------------------------------------------------
  const PublicationModel({
    required this.drafts,
    required this.pendings,
    required this.published,
    required this.unpublished,
    required this.suspended,
  });
  // --------------------------------------------------------------------------
  final List<String> drafts;
  final List<String> pendings;
  final List<String> published;
  final List<String> unpublished;
  final List<String> suspended;
  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const PublicationModel emptyModel = PublicationModel(
      drafts: [],
      pendings: [],
      published: [],
      unpublished: [],
      suspended: [],
  );
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  ///  TESTED : WORKS PERFECT
  PublicationModel copyWith({
    List<String>? drafts,
    List<String>? pendings,
    List<String>? published,
    List<String>? unpublished,
    List<String>? suspended,
  }){
    return PublicationModel(
      drafts: drafts ?? this.drafts,
      pendings: pendings ?? this.pendings,
      published: published ?? this.published,
      unpublished: unpublished ?? this.unpublished,
      suspended: suspended ?? this.suspended,
    );
  }
  // --------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// AI TESTED
  Map<String, dynamic> toMap(){
    return {
      'drafts': drafts,
      'pendings': pendings,
      'published': published,
      'unpublished': unpublished,
      'suspended': suspended,
    };
  }
  // --------------------
  /// AI TESTED
  static PublicationModel decipher(Map<String, dynamic>? map){
    PublicationModel _output = emptyModel;

    if (map != null){

      _output = PublicationModel(
        drafts: Stringer.getStringsFromDynamics(dynamics: map['drafts']),
        pendings: Stringer.getStringsFromDynamics(dynamics: map['pendings']),
        published: Stringer.getStringsFromDynamics(dynamics: map['published']),
        unpublished: Stringer.getStringsFromDynamics(dynamics: map['unpublished']),
        suspended: Stringer.getStringsFromDynamics(dynamics: map['suspended']),
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// AI TESTED
  static PublishState? getFlyerState({
    required PublicationModel pub,
    required String flyerID,
  }){

    if (Stringer.checkStringsContainString(strings: pub.drafts, string: flyerID)){
      return PublishState.draft;
    }
    else if (Stringer.checkStringsContainString(strings: pub.pendings, string: flyerID)){
      return PublishState.pending;
    }
    else if (Stringer.checkStringsContainString(strings: pub.published, string: flyerID)){
      return PublishState.published;
    }
    else if (Stringer.checkStringsContainString(strings: pub.unpublished, string: flyerID)){
      return PublishState.unpublished;
    }
    else if (Stringer.checkStringsContainString(strings: pub.suspended, string: flyerID)){
      return PublishState.suspended;
    }
    else {
      return null;
    }

  }
  // --------------------
  /// AI TESTED
  static List<String> getFlyersIDsByState({
    required PublicationModel pub,
    required PublishState state,
  }){

    switch (state){
      case PublishState.draft:        return pub.drafts;
      case PublishState.pending:      return pub.pendings;
      case PublishState.published:    return pub.published;
      case PublishState.unpublished:  return pub.unpublished;
      case PublishState.suspended:    return pub.suspended;
    }

  }
  // --------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// AI TESTED
  static PublicationModel insertFlyerInPublications({
    required PublicationModel pub,
    required String flyerID,
    required PublishState toState,
  }){

    final PublishState? _fromState = getFlyerState(
        pub: pub,
        flyerID: flyerID,
    );

    /// DOES NOT EXIST
    if (_fromState == null){
      return addNewFlyerIDToPublication(
        pub: pub,
        toState: toState,
        flyerID: flyerID,
      );
    }

    /// EXISTS
    else {

      /// SAME STATE
      if (_fromState == toState){
        return bringIDToStart(
          pub: pub,
          toState: toState,
          flyerID: flyerID,
        );
      }

      /// DIFFERENT STATE
      else {
        return moveFlyerIDFToNewState(
          pub: pub,
          toState: toState,
          flyerID: flyerID,
        );
      }

    }

  }
  // --------------------
  /// AI TESTED
  static PublicationModel replaceFlyersIDsInState({
    required PublicationModel pub,
    required List<String> newList,
    required PublishState state,
  }){

    switch (state){
      case PublishState.draft:        return pub.copyWith(drafts: newList);
      case PublishState.pending:      return pub.copyWith(pendings: newList);
      case PublishState.published:    return pub.copyWith(published: newList);
      case PublishState.unpublished:  return pub.copyWith(unpublished: newList);
      case PublishState.suspended:    return pub.copyWith(suspended: newList);
    }

  }
  // --------------------
  /// AI TESTED
  static PublicationModel addNewFlyerIDToPublication({
    required PublicationModel pub,
    required String flyerID,
    required PublishState toState,
  }){

    final List<String> toStateIDs = getFlyersIDsByState(
      pub: pub,
      state: toState,
    );

    return replaceFlyersIDsInState(
      pub: pub,
      state: toState,
      newList: [flyerID, ...toStateIDs],
    );

  }
  // --------------------
  /// AI TESTED
  static PublicationModel bringIDToStart({
    required PublicationModel pub,
    required String flyerID,
    required PublishState toState,
  }){

    final List<String> toStateIDs = getFlyersIDsByState(
      pub: pub,
      state: toState,
    );

    final List<String> _withoutInputID = Stringer.removeStringsFromStrings(
      removeFrom: toStateIDs,
      removeThis: [flyerID],
    );

    return replaceFlyersIDsInState(
      pub: pub,
      state: toState,
      newList: [flyerID, ..._withoutInputID],
    );

  }
  // --------------------
  /// AI TESTED
  static PublicationModel moveFlyerIDFToNewState({
    required PublicationModel pub,
    required String flyerID,
    required PublishState toState,
  }){

    PublicationModel _output = pub;

    final PublishState? _fromState = getFlyerState(
      pub: pub,
      flyerID: flyerID,
    );

    if (_fromState != null){

      List<String> fromStateIDs = getFlyersIDsByState(
        pub: pub,
        state: _fromState,
      );

      fromStateIDs = Stringer.removeStringsFromStrings(
        removeFrom: fromStateIDs,
        removeThis: [flyerID],
      );

      List<String> toStateIDs = getFlyersIDsByState(
        pub: pub,
        state: toState,
      );

      toStateIDs = Stringer.removeStringsFromStrings(
        removeFrom: toStateIDs,
        removeThis: [flyerID],
      );

      toStateIDs = [flyerID, ...toStateIDs];

      final PublicationModel _pub = replaceFlyersIDsInState(
          pub: pub,
          newList: fromStateIDs,
          state: _fromState
      );

      _output = replaceFlyersIDsInState(
        pub: _pub,
        newList: toStateIDs,
        state: toState,
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// AI TESTED
  static bool checkPublicationsAreIdentical({
    required PublicationModel? pub1,
    required PublicationModel? pub2,
  }){
    bool _identical = false;

    if (pub1 == null && pub2 == null){
      _identical = true;
    }

    else if (pub1 != null && pub2 != null){

      if (
      Mapper.checkListsAreIdentical(list1: pub1.drafts, list2: pub2.drafts) &&
      Mapper.checkListsAreIdentical(list1: pub1.pendings, list2: pub2.pendings) &&
      Mapper.checkListsAreIdentical(list1: pub1.published, list2: pub2.published) &&
      Mapper.checkListsAreIdentical(list1: pub1.unpublished, list2: pub2.unpublished) &&
      Mapper.checkListsAreIdentical(list1: pub1.suspended, list2: pub2.suspended)
      ){
        _identical = true;
      }

    }

    return _identical;
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
    if (other is PublicationModel){
      _areIdentical = checkPublicationsAreIdentical(
        pub1: this,
        pub2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      drafts.hashCode^
      pendings.hashCode^
      published.hashCode^
      unpublished.hashCode^
      suspended.hashCode;
  // -----------------------------------------------------------------------------
}
