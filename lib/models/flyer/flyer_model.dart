import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String flyerID;
  // -------------------------
  final FlyerType flyerType;
  final FlyerState flyerState;
  final List<String> keywordsIDs;
  final bool flyerShowsAuthor;
  final Zone flyerZone;
  // -------------------------
  final String authorID;
  final String bzID;
  // -------------------------
  final GeoPoint flyerPosition;
  // -------------------------
  final List<SlideModel> slides; // TASK : only 10 max slides per flyer
  // -------------------------
  final bool flyerIsBanned;
  final List<Spec> specs;
  final String info;
  final List<PublishTime> times;
  final bool priceTagIsOn;

  FlyerModel({
    this.flyerID,
    // -------------------------
    this.flyerType,
    this.flyerState = FlyerState.draft,
    this.keywordsIDs,
    this.flyerShowsAuthor = false,
    this.flyerZone,
    // -------------------------
    this.authorID,
    this.bzID,
    // -------------------------
    this.flyerPosition,
    // -------------------------
    this.slides,
    // -------------------------
    this.flyerIsBanned,
    this.specs,
    @required this.info,
    this.times,
    @required this.priceTagIsOn,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
      'flyerID' : flyerID,
      // -------------------------
      'flyerType' : FlyerTypeClass.cipherFlyerType(flyerType),
      'flyerState' : cipherFlyerState(flyerState),
      'keywordsIDs' : keywordsIDs,
      'flyerShowsAuthor' : flyerShowsAuthor,
      'flyerZone' : flyerZone.toMap(),
      // -------------------------
      'authorID' : authorID,
      'bzID' : bzID,
      // -------------------------
      'flyerPosition' : Atlas.cipherGeoPoint(point: flyerPosition, toJSON: toJSON),
      // -------------------------
      'slides' : SlideModel.cipherSlidesModels(slides),
      // -------------------------
      'flyerIsBanned' : flyerIsBanned,
      'specs' : Spec.cipherSpecs(specs),
      'info' : info,
      'priceTagIsOn' : priceTagIsOn,
      'times' : PublishTime.cipherPublishTimesToMap(times: times, toJSON: toJSON),
    };
  }
// -----------------------------------------------------------------------------
  static FlyerModel decipherFlyer({@required dynamic map, @required bool fromJSON}){
    FlyerModel _flyerModel;
    if (map != null){
      _flyerModel = FlyerModel(
        flyerID: map['flyerID'],
        // -------------------------
        flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
        flyerState: FlyerModel.decipherFlyerState(map['flyerState']),
        keywordsIDs: Mapper.getStringsFromDynamics(dynamics: map['keywordsIDs']),
        flyerShowsAuthor: map['flyerShowsAuthor'],
        flyerZone: Zone.decipherZoneMap(map['flyerZone']),
        // -------------------------
        authorID: map['authorID'],
        bzID: map['bzID'],
        // -------------------------
        flyerPosition: Atlas.decipherGeoPoint(point: map['flyerPosition'], fromJSON: fromJSON),
        // -------------------------
        slides: SlideModel.decipherSlidesMaps(map['slides']),
        // -------------------------
        flyerIsBanned: map['flyerIsBanned'],
        specs: Spec.decipherSpecs(map['specs']),
        info: map['info'],
        priceTagIsOn: map['priceTagIsOn'],
        times: PublishTime.decipherPublishTimesFromMap(map: map['times'], fromJSON: fromJSON),
      );

    }
    return _flyerModel;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> cipherFlyers({@required List<FlyerModel> flyers, @required bool toJSON}){
    final List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (Mapper.canLoopList(flyers)){

      for (FlyerModel flyer in flyers){

        final Map<String, Object> _flyerMap = flyer.toMap(toJSON: toJSON);

        _maps.add(_flyerMap);

      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<FlyerModel> decipherFlyers({@required List<dynamic> maps, @required bool fromJSON}){
    final List<FlyerModel> _flyersList = <FlyerModel>[];

    if (Mapper.canLoopList(maps)){

      maps?.forEach((map) {
        _flyersList.add(decipherFlyer(
          map: map,
          fromJSON: fromJSON,
        ));
      });


    }

    return _flyersList;
  }
// -----------------------------------------------------------------------------
  FlyerModel clone(){
    return new FlyerModel(
      flyerID: flyerID,
      flyerType: flyerType,
      flyerState: flyerState,
      keywordsIDs: Mapper.cloneListOfStrings(keywordsIDs),
      flyerShowsAuthor: flyerShowsAuthor,
      flyerZone: flyerZone,
      authorID: authorID,
      bzID: bzID,
      flyerPosition: flyerPosition,
      slides: SlideModel.cloneSlides(slides),
      flyerIsBanned: flyerIsBanned,
      specs: Spec.cloneSpecs(specs),
      info: info,
      priceTagIsOn: priceTagIsOn,
      times: PublishTime.cloneTimes(times),
    );
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceSlides(FlyerModel flyer, List<SlideModel> updatedSlides){
    return
        FlyerModel(
          flyerID: flyer.flyerID,
          flyerType: flyer.flyerType,
          flyerState: flyer.flyerState,
          keywordsIDs: flyer.keywordsIDs,
          flyerShowsAuthor: flyer.flyerShowsAuthor,
          flyerZone: flyer.flyerZone,
          authorID: flyer.authorID,
          bzID: flyer.bzID,
          flyerPosition: flyer.flyerPosition,
          slides: updatedSlides,
          flyerIsBanned: flyer.flyerIsBanned,
          specs: flyer.specs,
          info: flyer.info,
          priceTagIsOn: flyer.priceTagIsOn,
          times: flyer.times,
    );
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  static List<String> getListOfFlyerIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    flyers.forEach((flyer) {
      _flyerIDs.add(flyer.flyerID);
    });

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
  static FlyerModel replaceFlyerSlidesWithNewSlides(FlyerModel inputFlyerModel, List<SlideModel> updatedSlides){
    return FlyerModel(
      flyerID: inputFlyerModel.flyerID,
      flyerType: inputFlyerModel.flyerType,
      flyerZone: inputFlyerModel.flyerZone,
      authorID: inputFlyerModel.authorID,
      bzID: inputFlyerModel.bzID,
      slides: updatedSlides,
      flyerShowsAuthor: inputFlyerModel.flyerShowsAuthor,
      flyerState: inputFlyerModel.flyerState,
      keywordsIDs: inputFlyerModel.keywordsIDs,
      flyerPosition: inputFlyerModel.flyerPosition,
      flyerIsBanned: inputFlyerModel.flyerIsBanned,
      specs: inputFlyerModel.specs,
      info: inputFlyerModel.info,
      priceTagIsOn: inputFlyerModel.priceTagIsOn,
      times: inputFlyerModel.times,
    );
  }
// -----------------------------------------------------------------------------
  static const List<FlyerState> flyerStatesList = const <FlyerState>[
    FlyerState.published,
    FlyerState.draft,
    FlyerState.deleted,
    FlyerState.unpublished,
    FlyerState.banned,
    FlyerState.verified,
    FlyerState.suspended,
  ];
// -----------------------------------------------------------------------------
  /// TASK : why ?
  static int getNumberOfFlyersFromBzzModels(List<BzModel> bzzModels){
    int _totalFlyers = 0;
    bzzModels.forEach((bzModel) {
      _totalFlyers = _totalFlyers + (bzModel.flyersIDs.length);
    });
    return _totalFlyers;
  }
// -----------------------------------------------------------------------------
  static int getTotalSaves(FlyerModel flyer){
    int _totalSaves = 0;

    if (flyer != null && Mapper.canLoopList(flyer.slides)){

      flyer.slides.forEach((slide) {
        _totalSaves = _totalSaves + slide.savesCount;
      });

    }
    return _totalSaves;
  }
// -----------------------------------------------------------------------------
  static int getTotalShares(FlyerModel flyer){
    int _totalShares = 0;

    if (flyer != null && Mapper.canLoopList(flyer?.slides)){

      flyer.slides.forEach((slide) {
        _totalShares = _totalShares + slide.sharesCount;
      });

    }
    return _totalShares;
  }
// -----------------------------------------------------------------------------
  static int getTotalViews(FlyerModel flyer){
    int _totalViews = 0;

    if (flyer != null &&Mapper.canLoopList(flyer?.slides)){

      flyer.slides.forEach((slide) {
        _totalViews = _totalViews + slide.viewsCount;
      });

    }
    return _totalViews;
  }
// -----------------------------------------------------------------------------
  static bool canFlyerShowAuthor({BzModel bzModel}){
    bool _canShow = true;

    if(bzModel.bzShowsTeam == true){
      _canShow = true;
    }
    else {
      _canShow = false;
    }
    return _canShow;
  }
// -----------------------------------------------------------------------------
  static List<TextEditingController> createHeadlinesControllersForExistingFlyer(FlyerModel flyerModel){
  final List<TextEditingController> _controllers = <TextEditingController>[];

  flyerModel.slides.forEach((slide) {
    TextEditingController _controller = new TextEditingController(text: slide.headline);
    _controllers.add(_controller);
  });

  return _controllers;
}
// -----------------------------------------------------------------------------
  static List<TextEditingController> createDescriptionsControllersForExistingFlyer(FlyerModel flyerModel){
    final List<TextEditingController> _controllers = <TextEditingController>[];

    flyerModel.slides.forEach((slide) {
      TextEditingController _controller = new TextEditingController(text: slide.description);
      _controllers.add(_controller);
    });

    return _controllers;
  }
// -----------------------------------------------------------------------------
  static FlyerModel getFlyerModelFromSnapshot(DocumentSnapshot doc){
    final Object _map = doc.data();
    final FlyerModel _flyerModel = FlyerModel.decipherFlyer(
      map: _map,
      fromJSON: false,
    );
    return _flyerModel;
  }

// -----------------------------------------------------------------------------
  static FlyerModel getFlyerModelFromSuperFlyer(SuperFlyer superFlyer){
    FlyerModel _flyer;

    if (superFlyer != null){
      _flyer = FlyerModel(
        flyerID: superFlyer.flyerID,
        flyerType: superFlyer.flyerType,
        flyerState: superFlyer.flyerState,
        keywordsIDs: Keyword.getKeywordsIDsFromKeywords(superFlyer.keywords),
        flyerShowsAuthor: superFlyer.flyerShowsAuthor,
        flyerZone: superFlyer.flyerZone,
        authorID: superFlyer.authorID,
        bzID: superFlyer.bz.bzID,
        flyerPosition: superFlyer.position,
        slides: SlideModel.getSlidesFromMutableSlides(superFlyer.mSlides),
        flyerIsBanned: PublishTime.flyerIsBanned(superFlyer.times),
        specs: superFlyer.specs,
        info: superFlyer?.infoController?.text,
        priceTagIsOn : superFlyer?.priceTagIsOn,
        times: superFlyer.times,
      );
    }

    return _flyer;
  }
// -----------------------------------------------------------------------------
  void printFlyer(){
    print('FLYER-PRINT --------------------------------------------------START');

    print('FLYER_PRINT : flyerID : ${flyerID}');
    print('FLYER_PRINT : flyerType : ${flyerType}');
    print('FLYER_PRINT : flyerState : ${flyerState}');
    print('FLYER_PRINT : keywordsIDs : ${keywordsIDs}');
    print('FLYER_PRINT : flyerShowsAuthor : ${flyerShowsAuthor}');
    print('FLYER_PRINT : flyerZone : ${flyerZone}');
    print('FLYER_PRINT : authorID : ${authorID}');
    print('FLYER_PRINT : bzID : ${bzID}');
    print('FLYER_PRINT : flyerPosition : ${flyerPosition}');
    print('FLYER_PRINT : slides : ${slides}');
    print('FLYER_PRINT : flyerIsBanned : ${flyerIsBanned}');
    print('FLYER_PRINT : specs : ${specs}');
    print('FLYER_PRINT : info : ${info}');
    print('FLYER_PRINT : times : ${times}');
    print('FLYER_PRINT : priceTagIsOn : ${priceTagIsOn}');

    print('FLYER-PRINT --------------------------------------------------END');
  }
// -----------------------------------------------------------------------------
  static bool flyersContainThisID({String flyerID, List<FlyerModel> flyers}){
    bool _hasTheID = false;

      if (flyerID != null && Mapper.canLoopList(flyers)){

        for (FlyerModel flyer in flyers){

          if (flyer.flyerID == flyerID){
            _hasTheID = true;
            break;
          }

        }

    }

      return _hasTheID;
  }
// -----------------------------------------------------------------------------
  /// TASK : temp : delete me after ur done
  static String fixFlyerStateFromIntToString (int x){
    switch (x){
      case 1 :   return  'published'  ;   break;  // 1
      case 2 :   return  'draft'      ;   break;  // 2
      case 3 :   return  'deleted'    ;   break;  // 3
      case 4 :   return  'unpublished';   break;  // 4
      case 5 :   return  'banned'     ;   break;  // 5
      case 6 :   return  'verified'   ;   break;  // 6
      case 7 :   return  'suspended'  ;   break;  // 7
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static FlyerModel getFlyerFromFlyersByID({List<FlyerModel> flyers, String flyerID}){
    final FlyerModel _flyer = flyers.singleWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID, orElse: () => null);
    return _flyer;
  }
// -----------------------------------------------------------------------------
  static List<String> getFlyersIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    if (Mapper.canLoopList(flyers)){
      flyers?.forEach((flyer) {
        _flyerIDs.add(flyer.flyerID);
      });

    }

    return _flyerIDs;
  }
// -----------------------------------------------------------------------------
    static List<FlyerModel> filterFlyersBySection({List<FlyerModel> flyers, Section section}){
    List<FlyerModel> _filteredFlyers = <FlyerModel>[];

    if (section == Section.All){
      _filteredFlyers = flyers;
    }

    else {

      final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

      for (FlyerModel flyer in flyers){
        if (flyer.flyerType == _flyerType){
          _filteredFlyers.add(flyer);
        }
      }

    }

    return _filteredFlyers;
  }
// -----------------------------------------------------------------------------
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      flyerID : '2fDlDyF01sw8GEYPJ9GN',
      authorID: 'r1dqipDtBmRzK6HzL8Ug2vmcYVl1',
      flyerType : FlyerType.rentalProperty,
      flyerState : FlyerState.published,
      keywordsIDs : [],
      flyerShowsAuthor : true,
      bzID: 'br1',
      flyerPosition : GeoPoint(0,0),
      slides : <SlideModel>[
        SlideModel.dummySlide(),
      ],
      flyerIsBanned : false,
      specs : <Spec>[],
      info : 'Nothing just dummmy',
      times : <PublishTime>[
        PublishTime(state: FlyerState.published, time: Timers.createDate(year: 1987, month: 06, day: 10)),
      ],
      priceTagIsOn : true,
      flyerZone: Zone(
        cityID: 'Cairo',
        countryID: 'egy',
        districtID: '13',
      ),
    );
  }
// -----------------------------------------------------------------------------
  static List<FlyerModel> dummyFlyers(){
    return <FlyerModel>[
      dummyFlyer(),
    ];
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
enum FlyerState{
  published,
  draft,
  deleted,
  unpublished,
  banned,
  verified,
  suspended,
}
// -----------------------------------------------------------------------------

/*


ZEBALA

// -----------------------------------------------------------------------------
  void toggleAnkh(){
    ankhIsOn = !ankhIsOn;
    notifyListeners();
  }


 */