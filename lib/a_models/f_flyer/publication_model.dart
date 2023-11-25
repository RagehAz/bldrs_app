import 'package:basics/helpers/classes/checks/tracers.dart';
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
  ///  TESTED : WORKS PERFECT
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
  static Map<String, dynamic>? cipherToMap({
    required PublicationModel? publication,
  }){

    if (publication == null){
      return null;
    }

    else {
      return {
        'drafts': publication.drafts,
        'pendings': publication.pendings,
        'published': publication.published,
        'unpublished': publication.unpublished,
        'suspended': publication.suspended,
      };
    }

  }
  // --------------------
  /// AI TESTED
  static PublicationModel decipher(Map<String, dynamic>? map){
    PublicationModel _output = emptyModel;

    if (map != null){

      _output = PublicationModel(
        drafts: Stringer.getStringsFromDynamics(map['drafts']),
        pendings: Stringer.getStringsFromDynamics(map['pendings']),
        published: Stringer.getStringsFromDynamics(map['published']),
        unpublished: Stringer.getStringsFromDynamics(map['unpublished']),
        suspended: Stringer.getStringsFromDynamics(map['suspended']),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PUBLISH STATE CYPHERS

  // --------------------
  ///  TESTED : WORKS PERFECT
  static String? cipherPublishState (PublishState? x){
    switch (x){
      case PublishState.draft         :     return  'draft'       ;
      case PublishState.pending       :     return  'pending'     ;
      case PublishState.published     :     return  'published'   ;
      case PublishState.unpublished   :     return  'unpublished' ;
      case PublishState.suspended     :     return  'suspended'   ;
      default : return null;
    }
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static PublishState decipherPublishState (String? x){
    switch (x){
      case 'draft'        :   return  PublishState.draft;
      case 'pending'      :   return  PublishState.pending;
      case 'published'    :   return  PublishState.published;
      case 'unpublished'  :   return  PublishState.unpublished;
      case 'suspended'    :   return  PublishState.suspended;
      default : return   PublishState.draft;
    }
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  static const List<PublishState> publishStates = <PublishState>[
    PublishState.draft,
    PublishState.pending,
    PublishState.published,
    PublishState.unpublished,
    PublishState.suspended,
  ];
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  ///  TESTED : WORKS PERFECT
  static String? getPublishStatePhid(PublishState? state){
    // 'phid_verified_flyer' deprecated
    switch (state){
      case PublishState.draft         :     return  'phid_draft_flyer'        ;
      case PublishState.pending       :     return  'phid_pending_flyer'      ;
      case PublishState.published     :     return  'phid_published'          ;
      case PublishState.unpublished   :     return  'phid_unpublished_flyer'  ;
      case PublishState.suspended     :     return  'phid_suspended_flyer'    ;
      default : return null;
    }
  }
  // --------------------
  ///  TESTED : WORKS PERFECT
  List<String> getAllFlyersIDs(){
    return [
      ...drafts,
      ...pendings,
      ...published,
      ...unpublished,
      ...suspended,
    ];
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
        return bringIDToEnd(
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
      newList: [...toStateIDs, flyerID],
    );

  }
  // --------------------
  /// AI TESTED
  static PublicationModel bringIDToEnd({
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
      newList: [..._withoutInputID, flyerID],
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

      toStateIDs = [...toStateIDs, flyerID];

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static PublicationModel removeFlyerIDFromPublication({
    required PublicationModel pub,
    required String flyerID,
  }){

    final PublishState? _state = getFlyerState(
      pub: pub,
      flyerID: flyerID,
    );

    if (_state == null){
      return pub;
    }
    else {

      List<String> _newList = getFlyersIDsByState(
        pub: pub,
        state: _state,
      );

      _newList = Stringer.removeStringsFromStrings(
          removeFrom: _newList,
          removeThis: [flyerID],
      );

      return replaceFlyersIDsInState(
        pub: pub,
        state: _state,
        newList: _newList,
      );


    }

  }
  // --------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static PublishState concludeFlyerStateOnUpload({
    required PublishState? existingState,
    required bool isPublishing,
    required bool bzIsVerified,
  }){

    /// draft,
    /// pending,
    /// published,
    /// unpublished,
    /// suspended,

    if (existingState == PublishState.suspended){
      return PublishState.pending;
    }

    else {

      /// IS PUBLISHING
      if (isPublishing == true){

        /// BZ IS VERIFIED
        if (bzIsVerified == true){
          return PublishState.published;
        }

        /// BZ IS NOT VERIFIED
        else {
          return PublishState.pending;
        }

      }

      /// IS DRAFTING
      else {

        if (existingState == PublishState.unpublished){
          return PublishState.unpublished;
        }
        else {
          return PublishState.draft;
        }

      }


    }

  }
  // --------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  ///  TESTED : WORKS PERFECT
  static void blogPublications({
    required PublicationModel publication,
  }){

    blog('publication : ${publication.drafts.length} drafts : ${publication.drafts}');
    blog('publication : ${publication.pendings.length} pendings : ${publication.pendings}');
    blog('publication : ${publication.published.length} published : ${publication.published}');
    blog('publication : ${publication.unpublished.length} unpublished : ${publication.unpublished}');
    blog('publication : ${publication.suspended.length} suspended : ${publication.suspended}');

  }
  // --------------------------------------------------------------------------

  /// CHECKS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPublicationIsEmpty({
    required PublicationModel? publication,
  }){

    if (publication == null){
      return true;
    }
    else if (
        publication.drafts.isEmpty == true &&
        publication.pendings.isEmpty == true &&
        publication.published.isEmpty == true &&
        publication.unpublished.isEmpty == true &&
        publication.suspended.isEmpty == true
    ){
      return true;
    }
    else {
      return false;
    }

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

/*

  /// AUDIT STATE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherAuditState(AuditState? auditState){
    switch(auditState){
      case AuditState.verified:     return 'verified';
      case AuditState.suspended:    return 'suspended';
      case AuditState.pending:      return 'pending';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuditState? decipherAuditState(String? state){
    switch(state){
      case 'verified':  return AuditState.verified;
      case 'suspended': return AuditState.suspended;
      case 'pending':   return AuditState.pending;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<AuditState> auditStates = <AuditState>[
    AuditState.verified,
    AuditState.suspended,
    AuditState.pending,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getAuditStatePhid(AuditState? state){
    switch (state){
      case AuditState.verified  : return 'phid_verified_flyer'  ;
      case AuditState.suspended : return 'phid_suspended_flyer' ;
      case AuditState.pending   : return 'phid_pending_flyer'   ;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------

 */

/*
      final bool _bzIsVerified = bzModel.isVerified != null && bzModel.isVerified! == true;
        auditState: _bzIsVerified == true ? AuditState.verified : AuditState.pending,

 */
