import 'dart:ui' as ui;

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:space_time/space_time.dart';
import 'package:stringer/stringer.dart';

enum PublishState{
  draft,
  published,
  unpublished,
  deleted,
}

enum AuditState{
  verified,
  suspended,
  pending,
}
/// TAMAM
@immutable
class FlyerModel {
  /// --------------------------------------------------------------------------
  const FlyerModel({
    @required this.id,
    @required this.headline,
    @required this.trigram,
    @required this.description,
    @required this.flyerType,
    @required this.publishState,
    @required this.auditState,
    @required this.keywordsIDs,
    @required this.zone,
    @required this.authorID,
    @required this.bzID,
    @required this.position,
    @required this.slides,
    @required this.specs,
    @required this.times,
    @required this.priceTagIsOn,
    @required this.showsAuthor,
    @required this.score,
    @required this.pdfPath,
    this.bzLogoImage,
    this.authorImage,
    this.bzModel,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String headline;
  final List<String> trigram;
  final String description;
  final FlyerType flyerType;
  final PublishState publishState;
  final AuditState auditState;
  final List<String> keywordsIDs;
  final bool showsAuthor;
  final ZoneModel zone;
  final String authorID;
  final String bzID;
  final GeoPoint position;
  final List<SlideModel> slides;
  final List<SpecModel> specs;
  final List<PublishTime> times;
  final bool priceTagIsOn;
  final DocumentSnapshot<Object> docSnapshot;
  final int score;
  final String pdfPath;
  final ui.Image bzLogoImage;
  final ui.Image authorImage;
  final BzModel bzModel;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
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
    String pdfPath,
    ui.Image bzLogoImage,
    ui.Image authorImage,
    BzModel bzModel,
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
      pdfPath: pdfPath ?? this.pdfPath,
      bzLogoImage: bzLogoImage ?? this.bzLogoImage,
      authorImage: authorImage ?? this.authorImage,
      bzModel: bzModel ?? this.bzModel,
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return <String, dynamic>{
      'id' : id,
      'headline' : headline,
      'trigram' : Stringer.createTrigram(input: headline),
      'description' : description,
      // -------------------------
      'flyerType' : FlyerTyper.cipherFlyerType(flyerType),
      'publishState' : cipherPublishState(publishState),
      'auditState' : cipherAuditState(auditState),
      'keywordsIDs' : keywordsIDs,
      'showsAuthor' : showsAuthor,
      'zone' : zone?.toMap(),
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
      'times' : PublishTime.cipherTimes(times: times, toJSON: toJSON),
      'score' : score,
      'pdfPath' : pdfPath,
    };
  }
  // --------------------
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
  // --------------------
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
        trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram']),
        description: map['description'],
        // -------------------------
        flyerType: FlyerTyper.decipherFlyerType(map['flyerType']),
        publishState: decipherFlyerState(map['publishState']),
        auditState: decipherAuditState(map['auditState']),
        keywordsIDs: Stringer.getStringsFromDynamics(dynamics: map['keywordsIDs']),
        showsAuthor: map['showsAuthor'],
        zone: ZoneModel.decipherZone(map['zone']),
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
        times: PublishTime.decipherTimes(map: map['times'], fromJSON: fromJSON),
        score: map['score'],
        pdfPath: map['pdfPath'],
        docSnapshot: map['docSnapshot'],
      );

    }
    return _flyerModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> decipherFlyers({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<FlyerModel> _flyersList = <FlyerModel>[];

    if (Mapper.checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){
        _flyersList.add(decipherFlyer(
          map: map,
          fromJSON: fromJSON,
        ));
      }

    }

    return _flyersList;
  }
  // -----------------------------------------------------------------------------

  /// FLYER INITIALIZERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel getFlyerModelFromSnapshot(DocumentSnapshot<Object> doc){
    final Object _map = doc.data();
    final FlyerModel _flyerModel = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: false,
    );
    return _flyerModel;
  }
  // --------------------
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
  // --------------------
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

  // --------------------
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
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<PublishState> publishStates = <PublishState>[
    PublishState.draft,
    PublishState.published,
    PublishState.unpublished,
    PublishState.deleted,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String translatePublishState({
    @required BuildContext context,
    @required PublishState state,
  }){
    switch (state){
      case PublishState.published     :     return  'phid_published'          ;  break;
      case PublishState.draft         :     return  'phid_draft_flyer'        ;  break;
      case PublishState.deleted       :     return  'phid_deleted_flyer'      ;  break;
      case PublishState.unpublished   :     return  'phid_unpublished_flyer'  ;  break;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// AUDIT STATE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherAuditState(AuditState auditState){
    switch(auditState){
      case AuditState.verified:     return 'verified';    break;
      case AuditState.suspended:    return 'suspended';   break;
      case AuditState.pending:      return 'pending';   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuditState decipherAuditState(String state){
    switch(state){
      case 'verified':  return AuditState.verified;   break;
      case 'suspended': return AuditState.suspended;  break;
      case 'pending':   return AuditState.pending;  break;
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
  static String translateAuditState({
    @required BuildContext context,
    @required AuditState state,
  }){
    switch (state){
      case AuditState.verified  : return 'phid_verified_flyer'  ; break;
      case AuditState.suspended : return 'phid_suspended_flyer' ; break;
      case AuditState.pending   : return 'phid_pending_flyer'   ; break;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// FLYER BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogFlyer({
    String invoker,
  }){

    // if (invoker != null){
    //   blog(invoker);
    // }

    blog('> FLYER-PRINT in ( $invoker ) --------------------------------------------------START');

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
    SpecModel.blogSpecs(specs);
    PublishTime.blogTimes(times);
    blog('priceTagIsOn : $priceTagIsOn');
    blog('score : $score');
    blog('pdfPath : $pdfPath');
    SlideModel.blogSlides(slides);
    blog('bzLogoImage exists : ${bzLogoImage != null}');
    blog('authorImage exists : ${authorImage != null}');
    bzModel?.blogBz(invoker: invoker);

    blog('> FLYER-PRINT in ( $invoker ) --------------------------------------------------END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFlyers({
    @required List<FlyerModel> flyers,
    String invoker = 'BLOGGING FLYERS',
  }){

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        flyer?.blogFlyer(invoker: invoker);

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
    if (flyer1 != null && flyer2 != null){

      if (flyer1.id != flyer2.id){
        blog('flyers ids are not identical');
      }
      if (flyer1.headline != flyer2.headline){
        blog('flyers headlines are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: flyer1.trigram, list2: flyer2.trigram) == false){
        blog('flyers trigrams are not identical');
      }
      if (flyer1.description != flyer2.description){
        blog('flyers descriptions are not identical');
      }
      if (flyer1.flyerType != flyer2.flyerType){
        blog('flyers flyersTypes are not identical');
      }
      if (flyer1.publishState != flyer2.publishState){
        blog('flyers publishStates are not identical');
      }
      if (flyer1.auditState != flyer2.auditState){
        blog('flyers auditStates are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: flyer1.keywordsIDs, list2: flyer2.keywordsIDs) == false){
        blog('flyers keywordsIDs are not identical');
      }
      if (flyer1.showsAuthor != flyer2.showsAuthor){
        blog('flyers showsAuthor are not identical');
      }
      if (ZoneModel.checkZonesIDsAreIdentical(zone1: flyer1.zone, zone2: flyer2.zone) == false){
        blog('flyers zones are not identical');
      }
      if (flyer1.authorID != flyer2.authorID){
        blog('flyers authorsIDs are not identical');
      }
      if (flyer1.bzID != flyer2.bzID){
        blog('flyers bzzIDs are not identical');
      }
      if (Atlas.checkPointsAreIdentical(point1: flyer1.position, point2: flyer2.position) == false){
        blog('flyers positions are not identical');
      }
      if (SlideModel.checkSlidesListsAreIdentical(slides1: flyer1.slides, slides2: flyer2.slides) == false){
        blog('flyers slides are not identical');
      }
      if (SpecModel.checkSpecsListsAreIdentical(flyer1.specs, flyer2.specs) == false){
        blog('flyers specs are not identical');
      }
      if (PublishTime.checkTimesListsAreIdentical(times1: flyer1.times, times2: flyer2.times) == false){
        blog('flyers times are not identical');
      }
      if (flyer1.priceTagIsOn != flyer2.priceTagIsOn){
        blog('flyers priceTagIsOn are not identical');
      }
      if (flyer1.score != flyer2.score){
        blog('flyers scores are not identical');
      }
      if (flyer1.pdfPath != flyer2.pdfPath){
        blog('flyers pdfPath are not identical');
      }
      if (flyer1.bzLogoImage != flyer2.bzLogoImage){
        blog('flyers bzLogoImage are not identical');
      }
      if (flyer1.authorImage != flyer2.authorImage){
        blog('flyers authorImage are not identical');
      }
      if (BzModel.checkBzzAreIdentical(bz1: flyer1.bzModel, bz2: flyer2.bzModel) == false){
        blog('flyers bzz are not identical');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FLYER DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      id : 'x',
      headline: 'Dummy Flyer',
      trigram: Stringer.createTrigram(input: 'Dummy Flyer'),
      description: 'This is a dummy flyer',
      authorID: 'x',
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
      specs : SpecModel.dummySpecs(),
      times : <PublishTime>[
        PublishTime(state: PublishState.published, time: Timers.createDate(year: 1987, month: 06, day: 10)),
      ],
      priceTagIsOn : true,
      zone: ZoneModel.dummyZone(),
      score: 0,
      pdfPath: null,
    );
  }
  // --------------------
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

  // --------------------
  /*
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
   */
  // --------------------
  /*
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
   */
  // --------------------
  /*
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
   */
  // --------------------
  /// NOT USED
  /*
  static int getNumberOfFlyersFromBzzModels(List<BzModel> bzzModels){
    int _totalFlyers = 0;

    for (final BzModel bzModel in bzzModels){
      _totalFlyers = _totalFlyers + (bzModel.flyersIDs.length);
    }

    return _totalFlyers;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getNumberOfFlyersSlides(List<FlyerModel> flyers){
    int _count = 0;

    if (Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        _count = _count + flyer.slides.length;

      }

    }

    return _count;
  }
  // -----------------------------------------------------------------------------

  /// FLYER SEARCHES

  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerModel getFlyerFromFlyersByID({
    @required List<FlyerModel> flyers,
    @required String flyerID
  }){
    FlyerModel _output;

    if (Mapper.checkCanLoopList(flyers) == true){

      _output = flyers.singleWhere((FlyerModel tinyFlyer) => tinyFlyer.id == flyerID,
             orElse: () => null);

    }

    return _output;
  }
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerModel> filterFlyersByFlyerType({
    @required List<FlyerModel> flyers,
    @required FlyerType flyerType,
  }){
    final List<FlyerModel> _filteredFlyers = <FlyerModel>[];

    if(Mapper.checkCanLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){
        if (flyer.flyerType == flyerType){
          _filteredFlyers.add(flyer);
        }
      }
    }

    return _filteredFlyers;
  }
  // --------------------
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
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
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

  // --------------------
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
  // --------------------
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

  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  String getShortHeadline({
    int numberOfCharacters = 10
  }){
    final String _shortHeadline = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: headline,
        numberOfChars: numberOfCharacters
    );
    return _shortHeadline;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> generateFlyerOwners({
    @required BuildContext context,
    @required String bzID,
  }) async {
    List<String> _owners = <String>[];

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
        context: context,
        bzID: bzID,
      );

      if (_bzModel != null){

        final AuthorModel _creator = AuthorModel.getCreatorAuthorFromAuthors(_bzModel.authors);

        _owners.add(_creator.userID);

        _owners = Stringer.addStringToListIfDoesNotContainIt(
          strings: _owners,
          stringToAdd: OfficialAuthing.getUserID(),
        );

      }

    }

    return _owners;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getPicsPaths(FlyerModel flyer){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(flyer?.slides) == true){

      for (final SlideModel slide in flyer?.slides){
        _output.add(slide.picPath);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
    /// TESTED : WORKS PERFECT
  static FlyerModel migrateOwnership({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required String newOwnerID,
    @required BzModel bzModel,
  }){

    FlyerModel _output = flyerModel;

    if (flyerModel == null || newOwnerID == null || bzModel == null){
      return _output;
    }
    else {

      final bool _imAuthorInThisBz = AuthorModel.checkImAuthorInBzOfThisFlyer(
        context: context,
        flyerModel: flyerModel,
      );

      final bool _newOwnerIsCreator = AuthorModel.checkUserIsCreatorAuthor(
        bzModel: bzModel,
        userID: newOwnerID,
      );

      if (_newOwnerIsCreator == true && _imAuthorInThisBz == true) {

        _output= flyerModel.copyWith(
          authorID: newOwnerID,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
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
          flyer1.priceTagIsOn == flyer2.priceTagIsOn &&
          flyer1.pdfPath == flyer2.pdfPath &&
          Floaters.checkUiImagesAreIdentical(flyer1.bzLogoImage, flyer2.bzLogoImage) == true &&
          Floaters.checkUiImagesAreIdentical(flyer1.authorImage, flyer2.authorImage) == true
          // && flyer1.score == flyer2.score
      ){
        _areIdentical = true;
      }

    }

    // if (_areIdentical == false){
    //   blog('checkFlyersAreIdentical : _areIdentical : $_areIdentical');
    //   blogFlyersDifferences(
    //     flyer1: flyer1,
    //     flyer2: flyer2,
    //   );
    // }
    // else {
    //   blog('checkFlyersAreIdentical : _areIdentical : $_areIdentical');
    // }

    return _areIdentical;
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
    if (other is FlyerModel){
      _areIdentical = checkFlyersAreIdentical(
        flyer1: this,
        flyer2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      headline.hashCode^
      trigram.hashCode^
      description.hashCode^
      flyerType.hashCode^
      publishState.hashCode^
      auditState.hashCode^
      keywordsIDs.hashCode^
      zone.hashCode^
      authorID.hashCode^
      bzID.hashCode^
      position.hashCode^
      slides.hashCode^
      specs.hashCode^
      times.hashCode^
      priceTagIsOn.hashCode^
      showsAuthor.hashCode^
      score.hashCode^
      pdfPath.hashCode^
      bzLogoImage.hashCode^
      authorImage.hashCode^
      bzModel.hashCode^
      docSnapshot.hashCode;
// -----------------------------------------------------------------------------
}
