import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
/// ---------------------
enum PublishState{
  draft,
  published,
  unpublished,
  deleted,
}

enum AuditState{
  verified,
  suspended,
}
/// ---------------------
@immutable
class FlyerModel {
  /// --------------------------------------------------------------------------
  const FlyerModel({
    @required this.id,
    @required this.headline,
    @required this.trigram,
    @required this.description,
    // -------------------------
    @required this.flyerType,
    @required this.publishState,
    @required this.auditState,
    @required this.keywordsIDs,
    @required this.zone,
    // -------------------------
    @required this.authorID,
    @required this.bzID,
    // -------------------------
    @required this.position,
    // -------------------------
    @required this.slides,
    // -------------------------
    @required this.specs,
    @required this.times,
    @required this.priceTagIsOn,
    // -------------------------
    @required this.showsAuthor,
    @required this.score,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String headline;
  final List<String> trigram;
  final String description;
  // -------------------------
  final FlyerType flyerType;
  final PublishState publishState;
  final AuditState auditState;
  final List<String> keywordsIDs;
  final bool showsAuthor;
  final ZoneModel zone;
  // -------------------------
  final String authorID;
  final String bzID;
  // -------------------------
  final GeoPoint position;
  // -------------------------
  final List<SlideModel> slides; // TASK : only 10 max slides per flyer
  // -------------------------
  final List<SpecModel> specs;
  final List<PublishTime> times;
  final bool priceTagIsOn;
  final DocumentSnapshot<Object> docSnapshot;
  final int score;
// -----------------------------------------------------------------------------

  /// FLYER CYPHERS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return <String, dynamic>{
      'id' : id,
      'headline' : slides[0].headline,
      'trigram' : TextGen.createTrigram(input: slides[0].headline),
      'description' : description,
      // -------------------------
      'flyerType' : FlyerTyper.cipherFlyerType(flyerType),
      'publishState' : cipherPublishState(publishState),
      'auditState' : cipherAuditState(auditState),
      'keywordsIDs' : keywordsIDs,
      'showsAuthor' : showsAuthor,
      'zone' : zone.toMap(),
      // -------------------------
      'authorID' : authorID,
      'bzID' : bzID,
      // -------------------------
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      // -------------------------
      'slides' : SlideModel.cipherSlides(slides),
      // -------------------------
      'specs' : SpecModel.cipherSpecs(specs),
      'priceTagIsOn' : priceTagIsOn,
      'times' : PublishTime.cipherPublishTimesToMap(times: times, toJSON: toJSON),
      'score' : score,
    };
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, Object>> cipherFlyers({
    @required List<FlyerModel> flyers,
    @required bool toJSON,
  }){
    final List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (Mapper.checkCanLoopList(flyers)){

      for (final FlyerModel flyer in flyers){

        final Map<String, Object> _flyerMap = flyer.toMap(toJSON: toJSON);

        _maps.add(_flyerMap);

      }

    }

    return _maps;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel decipherFlyer({
    @required dynamic map,
    @required bool fromJSON,
  }){
    FlyerModel _flyerModel;
    if (map != null){
      _flyerModel = FlyerModel(
        id: map['id'],
        headline: map['headline'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
        description: map['description'],
        // -------------------------
        flyerType: FlyerTyper.decipherFlyerType(map['flyerType']),
        publishState: decipherFlyerState(map['publishState']),
        auditState: decipherAuditState(map['auditState']),
        keywordsIDs: Mapper.getStringsFromDynamics(dynamics: map['keywordsIDs']),
        showsAuthor: map['showsAuthor'],
        zone: ZoneModel.decipherZoneMap(map['zone']),
        // -------------------------
        authorID: map['authorID'],
        bzID: map['bzID'],
        // -------------------------
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        // -------------------------
        slides: SlideModel.decipherSlides(map['slides']),
        // -------------------------
        specs: SpecModel.decipherSpecs(map['specs']),
        priceTagIsOn: map['priceTagIsOn'],
        times: PublishTime.decipherPublishTimesFromMap(map: map['times'], fromJSON: fromJSON),
        score: map['score'],
        docSnapshot: map['docSnapshot'],
      );

    }
    return _flyerModel;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> decipherFlyers({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<FlyerModel> _flyersList = <FlyerModel>[];

    if (Mapper.checkCanLoopList(maps)){

      for (final Map<String, dynamic> map in maps){
        _flyersList.add(decipherFlyer(
          map: map,
          fromJSON: fromJSON,
        ));
      }

    }

    return _flyersList;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  FlyerModel copyWith({
    String id,
    String headline,
    List<String> trigram,
    String description,
    FlyerType flyerType,
    PublishState publishState,
    AuditState auditState,
    List<String> keywordsIDs,
    bool showsAuthor,
    ZoneModel zone,
    String authorID,
    String bzID,
    GeoPoint position,
    List<SlideModel> slides,
    bool isBanned,
    List<SpecModel> specs,
    List<PublishTime> times,
    bool priceTagIsOn,
    DocumentSnapshot docSnapshot,
    int score,
  }){

    return FlyerModel(
      id: id ?? this.id,
      headline: headline ?? this.headline,
      trigram: trigram ?? this.trigram,
      description: description ?? this.description,
      flyerType: flyerType ?? this.flyerType,
      publishState: publishState ?? this.publishState,
      auditState: auditState ?? this.auditState,
      keywordsIDs: keywordsIDs ?? this.keywordsIDs,
      showsAuthor: showsAuthor ?? this.showsAuthor,
      zone: zone ?? this.zone,
      authorID: authorID ?? this.authorID,
      bzID: bzID ?? this.bzID,
      position: position ?? this.position,
      slides: slides ?? this.slides,
      specs: specs ?? this.specs,
      times: times ?? this.times,
      priceTagIsOn: priceTagIsOn ?? this.priceTagIsOn,
      docSnapshot: docSnapshot ?? this.docSnapshot,
      score: score ?? this.score,
    );

  }
// -----------------------------------------------------------------------------

  /// FLYER INITIALIZERS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel getFlyerModelFromSnapshot(DocumentSnapshot<Object> doc){
    final Object _map = doc.data();
    final FlyerModel _flyerModel = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: false,
    );
    return _flyerModel;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<TextEditingController> createHeadlinesControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (flyerModel != null && Mapper.checkCanLoopList(flyerModel.slides)){

      for (final SlideModel slide in flyerModel.slides){
        final TextEditingController _controller = TextEditingController(text: slide.headline);
        _controllers.add(_controller);
      }

    }

    return _controllers;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<TextEditingController> createDescriptionsControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (flyerModel != null && Mapper.checkCanLoopList(flyerModel.slides)){

      for (final SlideModel slide in flyerModel.slides){
        final TextEditingController _controller = TextEditingController(text: slide.description);
        _controllers.add(_controller);
      }

    }

    return _controllers;
  }
// -----------------------------------------------------------------------------

  /// PUBLISH STATE CYPHERS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static String cipherPublishState (PublishState x){
    switch (x){
      case PublishState.draft         :     return  'draft'       ;  break;
      case PublishState.published     :     return  'published'   ;  break;
      case PublishState.unpublished   :     return  'unpublished' ;  break;
      case PublishState.deleted       :     return  'deleted'     ;  break;
      default : return null;
    }
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static PublishState decipherFlyerState (String x){
    switch (x){
      case 'draft'       :   return  PublishState.draft;         break;
      case 'published'   :   return  PublishState.published;     break;
      case 'unpublished' :   return  PublishState.unpublished;   break;
      case 'deleted'     :   return  PublishState.deleted;       break;
      default : return   null;
    }
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static const List<PublishState> publishStates = <PublishState>[
    PublishState.draft,
    PublishState.published,
    PublishState.unpublished,
    PublishState.deleted,
  ];
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static String translatePublishState({
    @required BuildContext context,
    @required PublishState state,
  }){
    switch (state){
      case PublishState.published     :     return  superPhrase(context, 'phid_published')          ;  break;
      case PublishState.draft         :     return  superPhrase(context, 'phid_draft_flyer')        ;  break;
      case PublishState.deleted       :     return  superPhrase(context, 'phid_deleted_flyer')      ;  break;
      case PublishState.unpublished   :     return  superPhrase(context, 'phid_unpublished_flyer')  ;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------

  /// AUDIT STATE CYPHERS

// ------------------------------------------
  static String cipherAuditState(AuditState auditState){
    switch(auditState){
      case AuditState.verified:     return 'verified';    break;
      case AuditState.suspended:    return 'suspended';   break;
      default: return null;
    }
  }
// ------------------------------------------
  static AuditState decipherAuditState(String state){
    switch(state){
      case 'verified':  return AuditState.verified;   break;
      case 'suspended': return AuditState.suspended;  break;
      default: return null;
    }
  }
// ------------------------------------------
  static const List<AuditState> auditStates = <AuditState>[
    AuditState.verified,
    AuditState.suspended,
  ];
// ------------------------------------------
  static String translateAuditState({
    @required BuildContext context,
    @required AuditState state,
  }){
    switch (state){
      case AuditState.verified      :     return  superPhrase(context, 'phid_verified_flyer')     ;  break;
      case AuditState.suspended     :     return  superPhrase(context, 'phid_suspended_flyer')    ;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------

  /// FLYER BLOGGING

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  void blogFlyer({
    @required String methodName,
  }){

    if (methodName != null){
      blog(methodName);
    }

    blog('FLYER-PRINT in ( $methodName ) --------------------------------------------------START');

    blog('id : $id');
    blog('headline : $headline');
    blog('trigram : $trigram');
    blog('description : $description');
    blog('flyerType : $flyerType');
    blog('publishState : $publishState');
    blog('auditState : $auditState');
    blog('keywordsIDs : $keywordsIDs');
    blog('showsAuthor : $showsAuthor');
    blog('zone : $zone');
    blog('authorID : $authorID');
    blog('bzID : $bzID');
    blog('position : $position');
    blog('specs : $specs');
    PublishTime.blogTimes(times);
    blog('priceTagIsOn : $priceTagIsOn');
    blog('score : $score');
    SlideModel.blogSlides(slides);

    blog('FLYER-PRINT --------------------------------------------------END');
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogFlyers({
    @required List<FlyerModel> flyers,
    String methodName = 'BLOGGING FLYERS',
  }){

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        flyer?.blogFlyer(methodName: methodName);

      }

    }

  }
// ------------------------------------------
  static void blogFlyersDifferences({
    @required FlyerModel flyer1,
    @required FlyerModel flyer2,
  }){

    if (flyer1 == null){
      blog('flyer1 == null');
    }
    if (flyer2 == null){
      blog('flyer2 == null');
    }
    if (flyer1.id != flyer2.id){
      blog('flyer1.id != flyer2.id');
    }
    if (flyer1.headline != flyer2.headline){
      blog('flyer1.headline != flyer2.headline');
    }
    if (Mapper.checkListsAreIdentical(list1: flyer1.trigram, list2: flyer2.trigram) == false){
      blog('flyer1.trigram != flyer2.trigram');
    }
    if (flyer1.description != flyer2.description){
      blog('flyer1.description != flyer2.description');
    }
    if (flyer1.flyerType != flyer2.flyerType){
      blog('flyer1.flyerType != flyer2.flyerType');
    }
    if (flyer1.publishState != flyer2.publishState){
      blog('flyer1.publishState != flyer2.publishState');
    }
    if (flyer1.auditState != flyer2.auditState){
      blog('flyer1.auditState != flyer2.auditState');
    }
    if (Mapper.checkListsAreIdentical(list1: flyer1.keywordsIDs, list2: flyer2.keywordsIDs) == false){
      blog('flyer1.keywordsIDs != flyer2.keywordsIDs');
    }
    if (flyer1.showsAuthor != flyer2.showsAuthor){
      blog('flyer1.showsAuthor != flyer2.showsAuthor');
    }
    if (ZoneModel.checkZonesIDsAreIdentical(zone1: flyer1.zone, zone2: flyer2.zone) == false){
      blog('flyer1.zone != flyer2.zone');
    }
    if (flyer1.authorID != flyer2.authorID){
      blog('flyer1.authorID != flyer2.authorID');
    }
    if (flyer1.bzID != flyer2.bzID){
      blog('flyer1.bzID != flyer2.bzID');
    }
    if (Atlas.checkPointsAreIdentical(point1: flyer1.position, point2: flyer2.position) == false){
      blog('flyer1.position != flyer2.position');
    }
    if (SlideModel.checkSlidesListsAreIdentical(slides1: flyer1.slides, slides2: flyer2.slides) == false){
      blog('flyer1.slides != flyer2.slides');
    }
    if (SpecModel.checkSpecsListsAreIdentical(flyer1.specs, flyer2.specs) == false){
      blog('flyer1.specs != flyer2.specs');
    }
    if (PublishTime.checkTimesListsAreIdentical(times1: flyer1.times, times2: flyer2.times) == false){
      blog('flyer1.times != flyer2.times');
    }
    if (flyer1.priceTagIsOn != flyer2.priceTagIsOn){
      blog('flyer1.priceTagIsOn != flyer2.priceTagIsOn');
    }


  }
// -----------------------------------------------------------------------------

  /// FLYER DUMMIES

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      id : 'x',
      headline: 'Dummy Flyer',
      trigram: TextGen.createTrigram(input: 'Dummy Flyer'),
      description: 'This is a dummy flyer',
      authorID: AuthFireOps.superUserID(),
      flyerType : FlyerType.property,
      publishState : PublishState.published,
      auditState: AuditState.verified,
      keywordsIDs : const <String>[],
      showsAuthor : true,
      bzID: 'br1',
      position : const GeoPoint(0,0),
      slides : <SlideModel>[
        SlideModel.dummySlide(),
      ],
      specs : const <SpecModel>[],
      times : <PublishTime>[
        PublishTime(state: PublishState.published, time: Timers.createDate(year: 1987, month: 06, day: 10)),
      ],
      priceTagIsOn : true,
      zone: ZoneModel.dummyZone(),
      score: 0,
    );
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> dummyFlyers(){
    return <FlyerModel>[
      dummyFlyer(),
      dummyFlyer(),
      dummyFlyer(),
      dummyFlyer(),
    ];
  }
// -----------------------------------------------------------------------------

  /// FLYER COUNTERS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static int getTotalSaves(FlyerModel flyer){
    int _totalSaves = 0;

    if (flyer != null && Mapper.checkCanLoopList(flyer.slides)){

      for (final SlideModel slide in flyer.slides){
        _totalSaves = _totalSaves + slide.savesCount;
      }

    }
    return _totalSaves;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static int getTotalShares(FlyerModel flyer){
    int _totalShares = 0;

    if (flyer != null && Mapper.checkCanLoopList(flyer?.slides)){

      for (final SlideModel slide in flyer.slides){
        _totalShares = _totalShares + slide.sharesCount;
      }

    }
    return _totalShares;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static int getTotalViews(FlyerModel flyer){
    int _totalViews = 0;

    if (flyer != null &&Mapper.checkCanLoopList(flyer?.slides)){

      for (final SlideModel slide in flyer.slides){
        _totalViews = _totalViews + slide.viewsCount;
      }

    }
    return _totalViews;
  }
// ------------------------------------------
  /// TASK : why ?
  static int getNumberOfFlyersFromBzzModels(List<BzModel> bzzModels){
    int _totalFlyers = 0;

    for (final BzModel bzModel in bzzModels){
      _totalFlyers = _totalFlyers + (bzModel.flyersIDs.length);
    }

    return _totalFlyers;
  }
// -----------------------------------------------------------------------------

  /// FLYER SEARCHES

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel getFlyerFromFlyersByID({
    @required List<FlyerModel> flyers,
    @required String flyerID
  }){

    final FlyerModel _flyer = flyers.singleWhere(
            (FlyerModel tinyFlyer) => tinyFlyer.id == flyerID,
        orElse: () => null
    );

    return _flyer;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getFlyersIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    if (Mapper.checkCanLoopList(flyers)){

      for (final FlyerModel flyer in flyers){
        _flyerIDs.add(flyer.id);
      }

    }

    return _flyerIDs;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> filterFlyersByFlyerType({
    @required List<FlyerModel> flyers,
    @required FlyerType flyerType,
  }){
    List<FlyerModel> _filteredFlyers = <FlyerModel>[];

    if(Mapper.checkCanLoopList(flyers)){

      if (flyerType == FlyerType.all){
        _filteredFlyers = flyers;
      }

      else {
        for (final FlyerModel flyer in flyers){
          if (flyer.flyerType == flyerType){
            _filteredFlyers.add(flyer);
          }
        }
      }

    }

    return _filteredFlyers;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> getFlyersFromFlyersByAuthorID({
    @required List<FlyerModel> flyers,
    @required String authorID,
  }){

    final List<FlyerModel> _authorFlyers = <FlyerModel>[];

    if (Mapper.checkCanLoopList(flyers) == true && authorID != null){

      for (final FlyerModel flyer in flyers){

        if (flyer?.authorID == authorID){
          _authorFlyers.add(flyer);
        }

      }

    }

    return _authorFlyers;
  }
// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool flyersContainThisID({
    @required String flyerID,
    @required List<FlyerModel> flyers
  }){
    bool _hasTheID = false;

    if (flyerID != null && Mapper.checkCanLoopList(flyers)){

      for (final FlyerModel flyer in flyers){

        if (flyer.id == flyerID){
          _hasTheID = true;
          break;
        }

      }

    }

    return _hasTheID;
  }
// ------------------------------------------
  static List<FlyerModel> replaceFlyerInFlyers({
    @required List<FlyerModel> flyers,
    @required FlyerModel flyerToReplace,
    @required bool insertIfAbsent,
  }){
    List<FlyerModel> _output = <FlyerModel>[];

    if (Mapper.checkCanLoopList(flyers) == true){
      _output = <FlyerModel>[...flyers];
    }

    if (flyerToReplace != null){

      final int _index = _output.indexWhere((flyer) => flyer.id == flyerToReplace.id);

      /// FLYERS INCLUDE IT
      if (_index != -1){

        _output.removeAt(_index);
        _output.insert(_index, flyerToReplace);

      }

      /// FLYERS DO NOT INCLUDE IT
      else {

        if (insertIfAbsent == true){
          _output.add(flyerToReplace);
        }

      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// FLYER EDITORS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> removeFlyerFromFlyersByID({
    @required List<FlyerModel> flyers,
    @required String flyerIDToRemove,
}){
    final List<FlyerModel> _output = <FlyerModel>[...flyers];

    if (Mapper.checkCanLoopList(flyers) == true && flyerIDToRemove != null){
      _output.removeWhere((flyer) => flyer.id == flyerIDToRemove);
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  /*
//   static FlyerModel replaceSlides({
//     @required FlyerModel flyer,
//     @required List<SlideModel> updatedSlides,
//   }){
//     return
//       FlyerModel(
//         id: flyer.id,
//         headline: flyer.headline,
//         trigram: flyer.trigram,
//         flyerType: flyer.flyerType,
//         flyerState: flyer.flyerState,
//         keywordsIDs: flyer.keywordsIDs,
//         showsAuthor: flyer.showsAuthor,
//         zone: flyer.zone,
//         authorID: flyer.authorID,
//         bzID: flyer.bzID,
//         position: flyer.position,
//         slides: updatedSlides,
//         isBanned: flyer.isBanned,
//         specs: flyer.specs,
//         info: flyer.info,
//         priceTagIsOn: flyer.priceTagIsOn,
//         times: flyer.times,
//       );
//   }
   */
// -----------------------------------------------------------------------------

  /// FLYER CHECKERS

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool canShowFlyerAuthor({
    @required BzModel bzModel,
    @required FlyerModel flyerModel,
  }){
    bool _canShow = true;

    if(bzModel.showsTeam == true){
      _canShow = flyerModel?.showsAuthor ?? true;
    }
    else {
      _canShow = false;
    }
    return _canShow;
  }
// ------------------------------------------
  static bool checkFlyersAreIdentical({
    @required FlyerModel flyer1,
    @required FlyerModel flyer2,
  }){

    bool _areIdentical = false;

    if (flyer1 == null && flyer2 == null){
      _areIdentical = true;
    }
    else if (flyer1 != null && flyer2 != null){

      if (
          flyer1.id == flyer2.id &&
          flyer1.headline == flyer2.headline &&
          Mapper.checkListsAreIdentical(list1: flyer1.trigram, list2: flyer2.trigram) == true &&
          flyer1.description == flyer2.description &&
          flyer1.flyerType == flyer2.flyerType &&
          flyer1.publishState == flyer2.publishState &&
          flyer1.auditState == flyer2.auditState &&
          Mapper.checkListsAreIdentical(list1: flyer1.keywordsIDs, list2: flyer2.keywordsIDs) == true &&
          flyer1.showsAuthor == flyer2.showsAuthor &&
          ZoneModel.checkZonesIDsAreIdentical(zone1: flyer1.zone, zone2: flyer2.zone) == true &&
          flyer1.authorID == flyer2.authorID &&
          flyer1.bzID == flyer2.bzID &&
          Atlas.checkPointsAreIdentical(point1: flyer1.position, point2: flyer2.position) == true &&
          SlideModel.checkSlidesListsAreIdentical(slides1: flyer1.slides, slides2: flyer2.slides) == true &&
          SpecModel.checkSpecsListsAreIdentical(flyer1.specs, flyer2.specs) == true &&
          PublishTime.checkTimesListsAreIdentical(times1: flyer1.times, times2: flyer2.times) == true &&
          flyer1.priceTagIsOn == flyer2.priceTagIsOn
      ){
        _areIdentical = true;
      }

    }

    if (_areIdentical == false){
      blogFlyersDifferences(
        flyer1: flyer1,
        flyer2: flyer2,
      );
    }

    return _areIdentical;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// ------------------------------------------
  String getShortHeadline({int numberOfCharacters = 10}){
    final String _shortHeadline = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: headline,
        numberOfCharacters: numberOfCharacters
    );
    return _shortHeadline;
  }
// -----------------------------------------------------------------------------
}
/// ---------------------
