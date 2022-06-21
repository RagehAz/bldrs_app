import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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
    @required this.title,
    @required this.trigram,
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
    @required this.info,
    @required this.times,
    @required this.priceTagIsOn,
    // -------------------------
    @required this.showsAuthor,
    @required this.score,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String title;
  final List<String> trigram;
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
  final String info;
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
      'title' : slides[0].headline,//title,
      'trigram' : TextGen.createTrigram(input: slides[0].headline), //trigram,
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
      'info' : info,
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
        title: map['title'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
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
        info: map['info'],
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
    String title,
    List<String> trigram,
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
    String info,
    List<PublishTime> times,
    bool priceTagIsOn,
    DocumentSnapshot docSnapshot,
    int score,
  }){

    return FlyerModel(
      id: id ?? this.id,
      title: title ?? this.title,
      trigram: trigram ?? this.trigram,
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
      info: info ?? this.info,
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
    blog('title : $title');
    blog('trigram : $trigram');
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
    blog('info : $info');
    blog('times : $times');
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
// -----------------------------------------------------------------------------

  /// FLYER DUMMIES

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      id : 'x',
      title: 'Dummy Flyer',
      trigram: TextGen.createTrigram(input: 'Dummy Flyer'),
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
      info : 'Nothing just dummy',
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
//         title: flyer.title,
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
// -----------------------------------------------------------------------------

  /// GETTERS

// ------------------------------------------
  String getShortTitle({int numberOfCharacters = 10}){
    final String _shortTitle = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: title,
        numberOfCharacters: numberOfCharacters
    );
    return _shortTitle;
  }
// -----------------------------------------------------------------------------
}
/// ---------------------
