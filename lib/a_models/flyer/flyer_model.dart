import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
/// ---------------------
enum FlyerState{
  published,
  draft,
  deleted,
  unpublished,
  banned,
  verified,
  suspended,
}
/// ---------------------
class FlyerModel {
  /// --------------------------------------------------------------------------
  FlyerModel({
    @required this.id,
    @required this.title,
    @required this.trigram,
    // -------------------------
    @required this.flyerType,
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
    @required this.isBanned,
    @required this.specs,
    @required this.info,
    @required this.times,
    @required this.priceTagIsOn,
    // -------------------------
    this.flyerState = FlyerState.draft,
    this.showsAuthor = false,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String title;
  final List<String> trigram;
  // -------------------------
  final FlyerTypeClass.FlyerType flyerType;
  final FlyerState flyerState;
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
  final bool isBanned;
  final List<SpecModel> specs;
  final String info;
  final List<PublishTime> times;
  final bool priceTagIsOn;
  final DocumentSnapshot docSnapshot;
// -----------------------------------------------------------------------------

  /// FLYER CYPHERS

// ------------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }){
    return <String, dynamic>{
      'id' : id,
      'title' : slides[0].headline,//title,
      'trigram' : TextGen.createTrigram(input: slides[0].headline), //trigram,
      // -------------------------
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'flyerState' : cipherFlyerState(flyerState),
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
      'isBanned' : isBanned,
      'specs' : SpecModel.cipherSpecs(specs),
      'info' : info,
      'priceTagIsOn' : priceTagIsOn,
      'times' : PublishTime.cipherPublishTimesToMap(times: times, toJSON: toJSON),
    };
  }
// ------------------------------------------
  static List<Map<String, Object>> cipherFlyers({
    @required List<FlyerModel> flyers,
    @required bool toJSON,
  }){
    final List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (Mapper.canLoopList(flyers)){

      for (final FlyerModel flyer in flyers){

        final Map<String, Object> _flyerMap = flyer.toMap(toJSON: toJSON);

        _maps.add(_flyerMap);

      }

    }

    return _maps;
  }
// ------------------------------------------
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
        flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
        flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
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
        isBanned: map['isBanned'],
        specs: SpecModel.decipherSpecs(map['specs']),
        info: map['info'],
        priceTagIsOn: map['priceTagIsOn'],
        times: PublishTime.decipherPublishTimesFromMap(map: map['times'], fromJSON: fromJSON),

        docSnapshot: map['docSnapshot'],
      );

    }
    return _flyerModel;
  }
// ------------------------------------------
  static List<FlyerModel> decipherFlyers({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<FlyerModel> _flyersList = <FlyerModel>[];

    if (Mapper.canLoopList(maps)){

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
  FlyerModel clone(){
    return FlyerModel(
      id: id,
      title: title,
      trigram: Mapper.cloneListOfStrings(trigram),
      flyerType: flyerType,
      flyerState: flyerState,
      keywordsIDs: Mapper.cloneListOfStrings(keywordsIDs),
      showsAuthor: showsAuthor,
      zone: zone,
      authorID: authorID,
      bzID: bzID,
      position: position,
      slides: SlideModel.cloneSlides(slides),
      isBanned: isBanned,
      specs: SpecModel.cloneSpecs(specs),
      info: info,
      priceTagIsOn: priceTagIsOn,
      times: PublishTime.cloneTimes(times),
    );
  }
// -----------------------------------------------------------------------------

  /// FLYER INITIALIZERS

// ------------------------------------------
  static FlyerModel getFlyerModelFromSnapshot(DocumentSnapshot<Object> doc){
    final Object _map = doc.data();
    final FlyerModel _flyerModel = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: false,
    );
    return _flyerModel;
  }
// ------------------------------------------
  static List<TextEditingController> createHeadlinesControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (flyerModel != null && Mapper.canLoopList(flyerModel.slides)){

      for (final SlideModel slide in flyerModel.slides){
        final TextEditingController _controller = TextEditingController(text: slide.headline);
        _controllers.add(_controller);
      }

    }

    return _controllers;
  }
// ------------------------------------------
  static List<TextEditingController> createDescriptionsControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    if (flyerModel != null && Mapper.canLoopList(flyerModel.slides)){

      for (final SlideModel slide in flyerModel.slides){
        final TextEditingController _controller = TextEditingController(text: slide.description);
        _controllers.add(_controller);
      }

    }

    return _controllers;
  }
// -----------------------------------------------------------------------------

  /// FLYER STATE

// ------------------------------------------
  static String cipherFlyerState (FlyerState x){
    switch (x){
      case FlyerState.published     :     return  'published'   ;  break;
      case FlyerState.draft         :     return  'draft'       ;  break;
      case FlyerState.deleted       :     return  'deleted'     ;  break;
      case FlyerState.unpublished   :     return  'unpublished' ;  break;
      case FlyerState.banned        :     return  'banned'      ;  break;
      case FlyerState.verified      :     return  'verified'    ;  break;
      case FlyerState.suspended     :     return  'suspended'   ;  break;
      default : return null;
    }
  }
// ------------------------------------------
  static FlyerState decipherFlyerState (String x){
    switch (x){
      case 'published'   :   return  FlyerState.published;     break;  // 1
      case 'draft'       :   return  FlyerState.draft;         break;  // 2
      case 'deleted'     :   return  FlyerState.deleted;       break;  // 3
      case 'unpublished' :   return  FlyerState.unpublished;   break;  // 4
      case 'banned'      :   return  FlyerState.banned;        break;  // 5
      case 'verified'    :   return  FlyerState.verified;      break;  // 6
      case 'suspended'   :   return  FlyerState.suspended;     break;  // 7
      default : return   null;
    }
  }
// ------------------------------------------
  static const List<FlyerState> flyerStatesList = <FlyerState>[
    FlyerState.published,
    FlyerState.draft,
    FlyerState.deleted,
    FlyerState.unpublished,
    FlyerState.banned,
    FlyerState.verified,
    FlyerState.suspended,
  ];
// -----------------------------------------------------------------------------

  /// FLYER BLOGGING

// ------------------------------------------
  void blogFlyer({String methodName}){

    if (methodName != null){
      blog(methodName);
    }

    blog('FLYER-PRINT --------------------------------------------------START');

    blog('id : $id');
    blog('title : $title');
    blog('trigram : $trigram');
    blog('flyerType : $flyerType');
    blog('flyerState : $flyerState');
    blog('keywordsIDs : $keywordsIDs');
    blog('showsAuthor : $showsAuthor');
    blog('zone : $zone');
    blog('authorID : $authorID');
    blog('bzID : $bzID');
    blog('position : $position');
    blog('slides : $slides');
    blog('isBanned : $isBanned');
    blog('specs : $specs');
    blog('info : $info');
    blog('times : $times');
    blog('priceTagIsOn : $priceTagIsOn');

    blog('FLYER-PRINT --------------------------------------------------END');
  }
// ------------------------------------------
  static void blogFlyers(List<FlyerModel> flyers){

    if (Mapper.canLoopList(flyers) == true){

      for (final FlyerModel flyer in flyers){

        flyer?.blogFlyer();

      }

    }

  }
// -----------------------------------------------------------------------------

  /// FLYER DUMMIES

// ------------------------------------------
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      id : '2fDlDyF01sw8GEYPJ9GN',
      title: 'Dummy Flyer',
      trigram: TextGen.createTrigram(input: 'Dummy Flyer'),
      authorID: superUserID(),
      flyerType : FlyerTypeClass.FlyerType.property,
      flyerState : FlyerState.published,
      keywordsIDs : <String>[],
      showsAuthor : true,
      bzID: 'br1',
      position : const GeoPoint(0,0),
      slides : <SlideModel>[
        SlideModel.dummySlide(),
      ],
      isBanned : false,
      specs : <SpecModel>[],
      info : 'Nothing just dummmy',
      times : <PublishTime>[
        PublishTime(state: FlyerState.published, time: Timers.createDate(year: 1987, month: 06, day: 10)),
      ],
      priceTagIsOn : true,
      zone: ZoneModel.dummyZone(),
    );
  }
// ------------------------------------------
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
  static int getTotalSaves(FlyerModel flyer){
    int _totalSaves = 0;

    if (flyer != null && Mapper.canLoopList(flyer.slides)){

      for (final SlideModel slide in flyer.slides){
        _totalSaves = _totalSaves + slide.savesCount;
      }

    }
    return _totalSaves;
  }
// ------------------------------------------
  static int getTotalShares(FlyerModel flyer){
    int _totalShares = 0;

    if (flyer != null && Mapper.canLoopList(flyer?.slides)){

      for (final SlideModel slide in flyer.slides){
        _totalShares = _totalShares + slide.sharesCount;
      }

    }
    return _totalShares;
  }
// ------------------------------------------
  static int getTotalViews(FlyerModel flyer){
    int _totalViews = 0;

    if (flyer != null &&Mapper.canLoopList(flyer?.slides)){

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
  static FlyerModel getFlyerFromFlyersByID({
    @required List<FlyerModel> flyers,
    @required String flyerID
  }){
    final FlyerModel _flyer = flyers.singleWhere((FlyerModel tinyFlyer) => tinyFlyer.id == flyerID, orElse: () => null);
    return _flyer;
  }
// ------------------------------------------
  static List<String> getFlyersIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    if (Mapper.canLoopList(flyers)){

      for (final FlyerModel flyer in flyers){
        _flyerIDs.add(flyer.id);
      }

    }

    return _flyerIDs;
  }
// ------------------------------------------
  static List<FlyerModel> filterFlyersByFlyerType({
    @required List<FlyerModel> flyers,
    @required FlyerTypeClass.FlyerType flyerType,
  }){
    List<FlyerModel> _filteredFlyers = <FlyerModel>[];

    if(Mapper.canLoopList(flyers)){

      if (flyerType == FlyerTypeClass.FlyerType.all){
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
  static List<FlyerModel> getFlyersFromFlyersByAuthorID({
    @required List<FlyerModel> flyers,
    @required String authorID,
  }){

    final List<FlyerModel> _authorFlyers = <FlyerModel>[];

    if (Mapper.canLoopList(flyers) == true && authorID != null){

      for (final FlyerModel flyer in flyers){

        if (flyer?.authorID == authorID){
          _authorFlyers.add(flyer);
        }

      }

    }

    return _authorFlyers;
  }
// ------------------------------------------
  static bool flyersContainThisID({
    @required String flyerID,
    @required List<FlyerModel> flyers
  }){
    bool _hasTheID = false;

    if (flyerID != null && Mapper.canLoopList(flyers)){

      for (final FlyerModel flyer in flyers){

        if (flyer.id == flyerID){
          _hasTheID = true;
          break;
        }

      }

    }

    return _hasTheID;
  }
// -----------------------------------------------------------------------------

  /// FLYER EDITORS

// ------------------------------------------
  static FlyerModel replaceSlides({
    @required FlyerModel flyer,
    @required List<SlideModel> updatedSlides,
  }){
    return
      FlyerModel(
        id: flyer.id,
        title: flyer.title,
        trigram: flyer.trigram,
        flyerType: flyer.flyerType,
        flyerState: flyer.flyerState,
        keywordsIDs: flyer.keywordsIDs,
        showsAuthor: flyer.showsAuthor,
        zone: flyer.zone,
        authorID: flyer.authorID,
        bzID: flyer.bzID,
        position: flyer.position,
        slides: updatedSlides,
        isBanned: flyer.isBanned,
        specs: flyer.specs,
        info: flyer.info,
        priceTagIsOn: flyer.priceTagIsOn,
        times: flyer.times,
      );
  }
// -----------------------------------------------------------------------------

  /// FLYER CHECKERS

// ------------------------------------------
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
}
/// ---------------------
