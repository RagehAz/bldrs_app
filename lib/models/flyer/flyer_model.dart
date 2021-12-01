import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/kw/section_class.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class FlyerModel with ChangeNotifier{
  final String id;
  final String title;
  final List<String> trigram;
  // -------------------------
  final FlyerType flyerType;
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
  final List<Spec> specs;
  final String info;
  final List<PublishTime> times;
  final bool priceTagIsOn;

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
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){
    return {
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
      _flyerIDs.add(flyer.id);
    });

    return _flyerIDs;
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

    if(bzModel.showsTeam == true){
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
        id: superFlyer.flyerID,
        title: superFlyer.titleController?.text,
        trigram: TextGen.createTrigram(input: superFlyer.titleController?.text),
        flyerType: superFlyer.flyerType,
        flyerState: superFlyer.flyerState,
        keywordsIDs: KW.getKeywordsIDsFromKeywords(superFlyer.keywords),
        showsAuthor: superFlyer.flyerShowsAuthor,
        zone: superFlyer.zone,
        authorID: superFlyer.authorID,
        bzID: superFlyer.bz.id,
        position: superFlyer.position,
        slides: SlideModel.getSlidesFromMutableSlides(superFlyer.mSlides),
        isBanned: PublishTime.flyerIsBanned(superFlyer.times),
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

    print('id : ${id}');
    print('title : ${title}');
    print('trigram : ${trigram}');
    print('flyerType : ${flyerType}');
    print('flyerState : ${flyerState}');
    print('keywordsIDs : ${keywordsIDs}');
    print('showsAuthor : ${showsAuthor}');
    print('zone : ${zone}');
    print('authorID : ${authorID}');
    print('bzID : ${bzID}');
    print('position : ${position}');
    print('slides : ${slides}');
    print('isBanned : ${isBanned}');
    print('specs : ${specs}');
    print('info : ${info}');
    print('times : ${times}');
    print('priceTagIsOn : ${priceTagIsOn}');

    print('FLYER-PRINT --------------------------------------------------END');
  }
// -----------------------------------------------------------------------------
  static bool flyersContainThisID({String flyerID, List<FlyerModel> flyers}){
    bool _hasTheID = false;

      if (flyerID != null && Mapper.canLoopList(flyers)){

        for (FlyerModel flyer in flyers){

          if (flyer.id == flyerID){
            _hasTheID = true;
            break;
          }

        }

    }

      return _hasTheID;
  }
// -----------------------------------------------------------------------------
  static FlyerModel getFlyerFromFlyersByID({List<FlyerModel> flyers, String flyerID}){
    final FlyerModel _flyer = flyers.singleWhere((tinyFlyer) => tinyFlyer.id == flyerID, orElse: () => null);
    return _flyer;
  }
// -----------------------------------------------------------------------------
  static List<String> getFlyersIDsFromFlyers(List<FlyerModel> flyers){
    final List<String> _flyerIDs = <String>[];

    if (Mapper.canLoopList(flyers)){
      flyers?.forEach((flyer) {
        _flyerIDs.add(flyer.id);
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

      _filteredFlyers = filterFlyersByFlyerType(
        flyers: flyers,
        flyerType: _flyerType,
      );
    }

    return _filteredFlyers;
  }
// -----------------------------------------------------------------------------
  static List<FlyerModel> filterFlyersByFlyerType({List<FlyerModel> flyers, FlyerType flyerType}){
    final List<FlyerModel> _filteredFlyers = <FlyerModel>[];

    if(Mapper.canLoopList(flyers)){

      for (FlyerModel flyer in flyers){
        if (flyer.flyerType == flyerType){
          _filteredFlyers.add(flyer);
        }
      }

    }

    return _filteredFlyers;
  }
// -----------------------------------------------------------------------------
  static FlyerModel dummyFlyer(){
    return FlyerModel(
      id : '2fDlDyF01sw8GEYPJ9GN',
      title: 'Dummy Flyer',
      trigram: TextGen.createTrigram(input: 'Dummy Flyer'),
      authorID: 'Svj0ln7UtoMtHKfZiPhzTSPejr52',
      flyerType : FlyerType.property,
      flyerState : FlyerState.published,
      keywordsIDs : [],
      showsAuthor : true,
      bzID: 'br1',
      position : const GeoPoint(0,0),
      slides : <SlideModel>[
        SlideModel.dummySlide(),
      ],
      isBanned : false,
      specs : <Spec>[],
      info : 'Nothing just dummmy',
      times : <PublishTime>[
        PublishTime(state: FlyerState.published, time: Timers.createDate(year: 1987, month: 06, day: 10)),
      ],
      priceTagIsOn : true,
      zone: ZoneModel.dummyZone(),
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