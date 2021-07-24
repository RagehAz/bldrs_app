import 'dart:io';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DraftFlyerModel{
  List<TextEditingController> headlinesControllers;
  List<Asset> assetsSources;
  List<File> assetsFiles;
  List<BoxFit> boxesFits;
  final ValueKey key;
  FlyerState state;
  List<bool> visibilities;
  int numberOfSlides;
  int numberOfStrips;
  SwipeDirection swipeDirection;
  bool listenToSwipe;
  int currentSlideIndex;

  bool firstTimer;
  String flyerID;
  String authorID;
  FlyerType flyerType;
  FlyerState flyerState;
  List<Keyword> keywords;
  bool showAuthor;
  Zone flyerZone;
  DateTime timeStamp;
  GeoPoint position;
  String mapImageURL;
  List<SlideModel> slides;
  BzModel bzModel;
  TextEditingController infoController;

  bool editMode;

  DraftFlyerModel({
    @required this.headlinesControllers,
    @required this.assetsSources,
    @required this.assetsFiles,
    @required this.boxesFits,
    @required this.key,
    @required this.state,
    @required this.visibilities,
    @required this.numberOfSlides,
    @required this.numberOfStrips,
    @required this.swipeDirection,
    @required this.listenToSwipe,
    @required this.currentSlideIndex,

    @required this.firstTimer,
    @required this.flyerID,
    @required this.authorID,
    @required this.flyerType,
    @required this.flyerState,
    @required this.keywords,
    @required this.showAuthor,
    @required this.flyerZone,
    @required this.timeStamp,
    @required this.position,
    @required this.mapImageURL,
    @required this.slides,
    @required this.bzModel,
    @required this.infoController,

    @required this.editMode,
  });
// -----------------------------------------------------------------------------
  static String draftID = 'draft';
// -----------------------------------------------------------------------------
  static List<ValueKey> getKeysOfDrafts(List<DraftFlyerModel> drafts){
    List<ValueKey> _keys = new List();

    if(drafts != null){
      drafts.forEach((draft) {
        _keys.add(draft.key);
      });

    }

    return _keys;
  }
// -----------------------------------------------------------------------------
  static DraftFlyerModel createNewDraftFlyer({BuildContext context, @required BzModel bzModel}){

    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);

    DraftFlyerModel _draft = DraftFlyerModel(
      assetsSources: new List(),
      assetsFiles: new List(),
      boxesFits: new List(),
      headlinesControllers: new List(),
      key: ValueKey(7),
      state: FlyerState.Draft,
      visibilities: new List(),
      numberOfSlides: 0,
      numberOfStrips: 0,
      swipeDirection: SwipeDirection.next,
      listenToSwipe: true,
      currentSlideIndex: 0,

      firstTimer: true,
      flyerID: 'draft',
      authorID: superUserID(),
      flyerType: FlyerTypeClass.concludeFlyerType(bzModel.bzType),
      flyerState: FlyerState.Draft,
      keywords: new List(),
      showAuthor: true,
      flyerZone: _countryPro.currentZone,
      timeStamp: DateTime.now(),
      position: null,
      mapImageURL: null,
      slides: new List(),
      bzModel: bzModel,
      infoController: new TextEditingController(),

      editMode: true,
    );
    return _draft;
  }
// -----------------------------------------------------------------------------
//   static DraftFlyerModel createDraftFromFlyer({@required FlyerModel flyer, @required BzModel bzModel}){
//     DraftFlyerModel _draft = DraftFlyerModel(
//       assetsSources: new List(),
//       assetsFiles: new List(),
//       boxesFits: new List(),
//       headlinesControllers: new List(),
//       key: ValueKey(7),
//       state: FlyerState.Draft,
//       visibilities: new List(),
//       numberOfSlides: 0,
//       numberOfStrips: 0,
//       swipeDirection: SwipeDirection.next,
//       listenToSwipe: true,
//       currentSlideIndex: 0,
//
//       flyerID: FinalFlyer.draftID,
//       authorID: superUserID(),
//       flyerType: FlyerTypeClass.concludeFlyerType(bzModel.bzType),
//       flyerState: FlyerState.Draft,
//       keywords: new List(),
//       showAuthor: true,
//       flyerZone: _countryPro.currentZone,
//       timeStamp: DateTime.now(),
//       position: null,
//       mapImageURL: null,
//       slides: new List(),
//     );
//
//     return _draft;
//   }

  // List<TextEditingController> _createHeadlinesForExistingFlyer(){
  //   List<TextEditingController> _controllers = new List();
  //
  //   _flyer.slides.forEach((slide) {
  //     TextEditingController _controller = new TextEditingController();
  //     _controller.text = slide.headline;
  //     _controllers.add(_controller);
  //   });
  //
  //   return _controllers;
  // }
// -----------------------------------------------------------------------------
//   List<bool> _createSlidesVisibilityList(){
//     int _listLength = widget.draftFlyer.assetsFiles.length;
//     List<bool> _visibilityList = new List();
//
//     for (int i = 0; i<_listLength; i++){
//       _visibilityList.add(true);
//     }
//
//     return _visibilityList;
//   }

}
