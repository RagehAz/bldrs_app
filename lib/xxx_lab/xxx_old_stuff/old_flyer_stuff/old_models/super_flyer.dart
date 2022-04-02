// import 'dart:typed_data';
//
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/mutables/flyer_editor.dart';
// import 'package:bldrs/a_models/flyer/mutables/flyer_navigator.dart';
// import 'package:bldrs/a_models/flyer/mutables/flyer_recorder.dart';
// import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
// import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
// import 'package:bldrs/a_models/kw/kw.dart';
// import 'package:bldrs/a_models/kw/specs/spec_model.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/country_model.dart';
// import 'package:bldrs/a_models/zone/zone_model.dart';
// import 'package:bldrs/d_providers/bzz_provider.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/d_providers/keywords_provider.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
// import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// need to add
// /// string mapImageURL
// /// all fields are valid
//
// class SuperFlyer {
//   /// --------------------------------------------------------------------------
//   SuperFlyer({
//     /// navigator
//     @required this.nav,
//
//     /// recorder
//     @required this.rec,
//
//     /// editor
//     @required this.edit,
//
//     /// mutable slides
//     @required this.mSlides,
//
//     /// BzModel
//     @required this.bz,
//
//     /// animation parameters
//     @required this.loading,
//
//     /// slides settings
//     @required this.numberOfSlides,
//     @required this.numberOfStrips,
//
//     /// current slide settings
//     @required this.initialSlideIndex,
//     @required this.currentSlideIndex,
//     @required this.verticalIndex,
//
//     /// flyer identifiers
//     @required this.key,
//     @required this.flyerID,
//     @required this.authorID,
//     @required this.title,
//     @required this.titleController,
//
//     /// flyer data
//     @required this.flyerType,
//     @required this.flyerState,
//     @required this.flyerShowsAuthor,
//
//     /// flyer tags
//     @required this.flyerInfo,
//     @required this.specs,
//     @required this.keywords,
//
//     /// flyer location
//     @required this.zone,
//     @required this.position,
//
//     /// publishing times
//     @required this.times,
//     @required this.priceTagIsOn,
//     @required this.bzCountry,
//     @required this.bzCity,
//     @required this.flyerCountry,
//     @required this.flyerCity,
//
//     /// editor data
//     @required this.infoController,
//     this.screenShots,
//   });
//
//   /// --------------------------------------------------------------------------
//   final FlyerNavigator nav;
//   final FlyerRecorder rec;
//   final FlyerEditor edit;
//   List<MutableSlide> mSlides; // MutableSlide
//   BzModel bz;
//
//   /// animation parameters
//   bool loading; // ??
//
//   /// editor data
//   List<Uint8List> screenShots; // --?
//
//   TextEditingController infoController;
//
//   /// slides settings
//   int numberOfSlides; // MutableFlyer -- ?
//   int numberOfStrips; // MutableFlyer -- ?
//
//   /// current slide settings
//   final int initialSlideIndex; // MutableFlyer -- ?
//   int currentSlideIndex; // MutableFlyer -- ?
//   int verticalIndex; // MutableFlyer -- ?
//
//   /// flyer identifiers
//   final ValueKey<String> key; // MutableFlyer -- ?
//   final String flyerID; // MutableFlyer -- ?
//   String authorID; // tinyAuthor
//   String title;
//   TextEditingController titleController;
//
//   /// flyer data
//   FlyerTypeClass.FlyerType flyerType; // MutableFlyer -- ?
//   FlyerState flyerState; // MutableFlyer -- ?
//   bool flyerShowsAuthor; // MutableFlyer -- ?
//
//   /// flyer tags
//   String flyerInfo; // MutableFlyer -- ?
//   List<SpecModel> specs; // MutableFlyer -- ?
//   List<KW> keywords; // MutableFlyer -- ?
//
//   /// flyer location
//   ZoneModel zone; // MutableFlyer -- ?
//   GeoPoint position; // MutableFlyer -- ?
//
//   /// publishing times
//   List<PublishTime> times; // MutableFlyer -- ?
//   bool priceTagIsOn;
//   CountryModel bzCountry;
//   CityModel bzCity;
//   CountryModel flyerCountry;
//   CityModel flyerCity;
//
//   /// --------------------------------------------------------------------------
//   static const String draftID = 'draft';
//   static const String emptyFlyerBzOnlyFlyerID = 'bzOnly';
// // -----------------------------------------------------------------------------
//   static SuperFlyer createEmptySuperFlyer(
//       {@required double flyerBoxWidth, @required bool goesToEditor}) {
//     bool _editMode = false;
//     if (goesToEditor == true) {
//       _editMode = true;
//     }
//
//     return SuperFlyer(
//       nav: FlyerNavigator(
//         /// animation controller
//         horizontalController: null,
//         verticalController: null,
//         infoScrollController: null,
//
//         /// animation functions
//         onHorizontalSlideSwipe: null,
//         onVerticalPageSwipe: null,
//         onVerticalPageBack: null,
//         onHeaderTap: null,
//         onSlideRightTap: null,
//         onSlideLeftTap: null,
//         onSwipeFlyer: null,
//         onTinyFlyerTap: null,
//
//         /// animation parameters
//         progressBarOpacity: null,
//         swipeDirection: null,
//         bzPageIsOn: null,
//         listenToSwipe: null,
//
//         onSaveInfoScrollOffset: null,
//         getInfoScrollOffset: null,
//       ),
//       rec: FlyerRecorder(
//         /// record functions
//         onViewSlide: null,
//         onAnkhTap: null,
//         onShareTap: null,
//         onFollowTap: null,
//         onCallTap: null,
//
//         /// user based bool triggers
//         ankhIsOn: null,
//         followIsOn: null,
//         onCountersTap: null,
//         onEditReview: null,
//         onSubmitReview: null,
//         reviewController: null,
//         onShowReviewOptions: null,
//       ),
//       edit: FlyerEditor(
//         /// editor functions
//         onAddImages: null,
//         onDeleteSlide: null,
//         onCropImage: null,
//         onResetImage: null,
//         onFitImage: null,
//         onFlyerTypeTap: null,
//         onZoneTap: null,
//         onEditInfoTap: null,
//         onEditKeywordsTap: null,
//         onEditSpecsTap: null,
//         onShowAuthorTap: null,
//         onTriggerEditMode: null,
//         onPublishFlyer: null,
//         onDeleteFlyer: null,
//         onUnPublishFlyer: null,
//         onRepublishFlyer: null,
//
//         /// editor data
//         firstTimer: goesToEditor == true ? true : null,
//         editMode: _editMode,
//         canDelete: true,
//       ),
//       mSlides: null,
//       bz: null,
//
//       loading: false,
//
//       infoController: null,
//
//       /// slides settings
//       numberOfSlides: 0,
//       numberOfStrips: 0,
//
//       /// current slide settings
//       initialSlideIndex: null,
//       currentSlideIndex: null,
//       verticalIndex: 0,
//
//       /// flyer identifiers
//       key: null,
//       flyerID: null,
//       authorID: null,
//       title: null,
//       titleController: null,
//
//       /// flyer data
//       flyerType: null,
//       flyerState: null,
//       flyerShowsAuthor: null,
//
//       /// flyer tags
//       flyerInfo: null,
//       specs: null,
//       keywords: null,
//
//       /// flyer location
//       zone: null,
//       position: null,
//
//       /// publishing times
//       times: null,
//
//       priceTagIsOn: null,
//
//       bzCountry: null,
//       bzCity: null,
//       flyerCity: null,
//       flyerCountry: null,
//     );
//   }
//
// // -----------------------------------------------------------------------------
//   static SuperFlyer createViewSuperFlyerFromFlyerModel({
//     @required BuildContext context,
//     @required FlyerModel flyerModel,
//     @required BzModel bzModel,
//     @required int initialPage,
//     @required Function onHorizontalSlideSwipe,
//     @required Function onVerticalPageSwipe,
//     @required Function onVerticalPageBack,
//     @required Function onHeaderTap,
//     @required Function onSlideRightTap,
//     @required Function onSlideLeftTap,
//     @required Function onSwipeFlyer,
//     @required Function onTinyFlyerTap,
//     @required Function onView,
//     @required Function onAnkhTap,
//     @required Function onShareTap,
//     @required Function onFollowTap,
//     @required Function onCallTap,
//     @required Function onCountersTap,
//     @required Function onEditReview,
//     @required Function onSubmitReview,
//     @required Function onShowReviewOptions,
//     @required Function onSaveInfoScrollOffset,
//     @required Function getInfoScrollOffset,
//     @required double initialInfoScrollOffset,
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//     @required CountryModel flyerCountry,
//     @required CityModel flyerCity,
//   }) {
//     final int _initialPage = initialPage ?? 0;
//
//     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//     final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
//     final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
//
//     final ScrollController _infoScrollController = ScrollController(
//       initialScrollOffset: initialInfoScrollOffset ?? 0,
//     );
//     _infoScrollController.addListener(onSaveInfoScrollOffset);
//
//     return SuperFlyer(
//       nav: FlyerNavigator(
//         /// animation controller
//         horizontalController: PageController(initialPage: _initialPage),
//         verticalController: PageController(),
//         infoScrollController: _infoScrollController,
//
//         /// animation functions
//         onHorizontalSlideSwipe: onHorizontalSlideSwipe,
//         onVerticalPageSwipe: onVerticalPageSwipe,
//         onVerticalPageBack: onVerticalPageBack,
//         onHeaderTap: onHeaderTap,
//         onSlideRightTap: onSlideRightTap,
//         onSlideLeftTap: onSlideLeftTap,
//         onSwipeFlyer: onSwipeFlyer,
//         onTinyFlyerTap: onTinyFlyerTap,
//
//         /// animation parameters
//         progressBarOpacity: 1,
//         swipeDirection: Sliders.SwipeDirection.next,
//         bzPageIsOn: false,
//         listenToSwipe: true,
//
//         onSaveInfoScrollOffset: onSaveInfoScrollOffset,
//         getInfoScrollOffset: getInfoScrollOffset,
//       ),
//       rec: FlyerRecorder(
//         /// record functions
//         onViewSlide: onView,
//         onAnkhTap: onAnkhTap,
//         onShareTap: onShareTap,
//         onFollowTap: onFollowTap,
//         onCallTap: onCallTap,
//         onCountersTap: onCountersTap,
//
//         /// user based bool triggers
//         ankhIsOn: _flyersProvider.getAnkh(flyerModel.id),
//         followIsOn:
//             _bzzProvider.checkFollow(context: context, bzID: flyerModel.bzID),
//         onEditReview: onEditReview,
//         onSubmitReview: onSubmitReview,
//         reviewController: TextEditingController(),
//         onShowReviewOptions: onShowReviewOptions,
//       ),
//       edit: FlyerEditor(
//         /// editor functions
//         onAddImages: null,
//         onDeleteSlide: null,
//         onCropImage: null,
//         onResetImage: null,
//         onFitImage: null,
//         onFlyerTypeTap: null,
//         onZoneTap: null,
//         onEditInfoTap: null,
//         onEditKeywordsTap: null,
//         onEditSpecsTap: null,
//         onShowAuthorTap: null,
//         onTriggerEditMode: null,
//         onPublishFlyer: null,
//         onDeleteFlyer: null,
//         onUnPublishFlyer: null,
//         onRepublishFlyer: null,
//
//         /// editor data
//         firstTimer: null,
//         editMode: false,
//         canDelete: true,
//       ),
//       mSlides: MutableSlide.getViewMutableSlidesFromSlidesModels(flyerModel.slides),
//       bz: bzModel,
//
//       loading: false,
//
//       infoController: null,
//
//       /// slides settings
//       numberOfSlides: flyerModel.slides.length,
//       numberOfStrips: flyerModel.slides.length,
//
//       /// current slide settings
//       initialSlideIndex: _initialPage,
//       currentSlideIndex: _initialPage,
//       verticalIndex: 0,
//
//       /// flyer identifiers
//       key: ValueKey<String>(flyerModel.id),
//       flyerID: flyerModel.id,
//       authorID: flyerModel.authorID,
//       title: flyerModel.title,
//       titleController: null,
//
//       /// flyer data
//       flyerType: flyerModel.flyerType,
//       flyerState: flyerModel.flyerState,
//       flyerShowsAuthor: flyerModel.showsAuthor,
//
//       /// flyer tags
//       flyerInfo: flyerModel.info,
//       specs: flyerModel.specs,
//       keywords: KW.getKeywordsFromKeywordsByIDs(
//           sourceKWs: _keywordsProvider.allKeywords,
//           keywordsIDs: flyerModel.keywordsIDs
//       ),
//
//       /// flyer location
//       zone: flyerModel.zone,
//       position: flyerModel.position,
//
//       /// publishing times
//       times: flyerModel.times,
//       priceTagIsOn: flyerModel.priceTagIsOn,
//
//       bzCountry: bzCountry,
//       bzCity: bzCity,
//
//       flyerCountry: flyerCountry,
//       flyerCity: flyerCity,
//     );
//   }
//
// // -----------------------------------------------------------------------------
//   static SuperFlyer createDraftSuperFlyerFromNothing({
//     @required BuildContext context,
//     @required BzModel bzModel,
//     @required Function onHorizontalSlideSwipe,
//     @required Function onVerticalPageSwipe,
//     @required Function onVerticalPageBack,
//     @required Function onHeaderTap,
//     @required Function onSlideRightTap,
//     @required Function onSlideLeftTap,
//     @required Function onSwipeFlyer,
//     @required Function onTinyFlyerTap,
//     @required Function onView,
//     @required Function onAnkhTap,
//     @required Function onShareTap,
//     @required Function onFollowTap,
//     @required Function onCallTap,
//     @required Function onCountersTap,
//     @required Function onAddImages,
//     @required Function onDeleteSlide,
//     @required Function onCropImage,
//     @required Function onResetImage,
//     @required Function onFitImage,
//     @required Function onFlyerTypeTap,
//     @required Function onZoneTap,
//     @required Function onAboutTap,
//     @required Function onKeywordsTap,
//     @required Function onSpecsTap,
//     @required Function onShowAuthorTap,
//     @required Function onTriggerEditMode,
//     @required Function onPublishFlyer,
//     @required Function onDeleteFlyer,
//     @required Function onUnPublishFlyer,
//     @required Function onRepublishFlyer,
//     @required double initialInfoScrollOffset,
//     @required Function onSaveInfoScrollOffset,
//     @required Function getInfoScrollOffset,
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//     @required CountryModel flyerCountry,
//     @required CityModel flyerCity,
//   }) {
//     blog(
//         'CREATING draft super flyer from nothing for bz  : ${bzModel.name} : id : ${bzModel.id}');
//
//     final ZoneProvider _zoneProvider =
//         Provider.of<ZoneProvider>(context, listen: false);
//
//     final ScrollController _infoScrollController = ScrollController(
//       initialScrollOffset: initialInfoScrollOffset ?? 0,
//     );
//     _infoScrollController.addListener(onSaveInfoScrollOffset);
//
//     return SuperFlyer(
//       nav: FlyerNavigator(
//         /// animation controller
//         horizontalController: PageController(),
//         verticalController: PageController(),
//         infoScrollController: _infoScrollController,
//
//         /// animation functions
//         onHorizontalSlideSwipe: onHorizontalSlideSwipe,
//         onVerticalPageSwipe: onVerticalPageSwipe,
//         onVerticalPageBack: onVerticalPageBack,
//         onHeaderTap: onHeaderTap,
//         onSlideRightTap: onSlideRightTap,
//         onSlideLeftTap: onSlideLeftTap,
//         onSwipeFlyer: onSwipeFlyer,
//         onTinyFlyerTap: onTinyFlyerTap,
//
//         /// animation parameters
//         progressBarOpacity: 1,
//         swipeDirection: Sliders.SwipeDirection.next,
//         bzPageIsOn: false,
//         listenToSwipe: true,
//         onSaveInfoScrollOffset: onSaveInfoScrollOffset,
//         getInfoScrollOffset: getInfoScrollOffset,
//       ),
//       rec: FlyerRecorder(
//         /// record functions
//         onViewSlide: onView,
//         onAnkhTap: onAnkhTap,
//         onShareTap: onShareTap,
//         onFollowTap: onFollowTap,
//         onCallTap: onCallTap,
//         onCountersTap: onCountersTap,
//
//         /// user based bool triggers
//         ankhIsOn: false,
//         followIsOn: false,
//         onEditReview: null,
//         onSubmitReview: null,
//         reviewController: null,
//         onShowReviewOptions: null,
//       ),
//       edit: FlyerEditor(
//         /// editor functions
//         onAddImages: onAddImages,
//         onDeleteSlide: onDeleteSlide,
//         onCropImage: onCropImage,
//         onResetImage: onResetImage,
//         onFitImage: onFitImage,
//         onFlyerTypeTap: onFlyerTypeTap,
//         onZoneTap: onZoneTap,
//         onEditInfoTap: onAboutTap,
//         onEditKeywordsTap: onKeywordsTap,
//         onEditSpecsTap: onSpecsTap,
//         onShowAuthorTap: onShowAuthorTap,
//         onTriggerEditMode: onTriggerEditMode,
//         onPublishFlyer: onPublishFlyer,
//         onDeleteFlyer: onDeleteFlyer,
//         onUnPublishFlyer: onUnPublishFlyer,
//         onRepublishFlyer: onRepublishFlyer,
//
//         /// editor data
//         firstTimer: true,
//         editMode: true,
//         canDelete: true,
//       ),
//       mSlides: <MutableSlide>[],
//       bz: bzModel,
//
//       loading: false,
//
//       /// editor data
//       infoController: TextEditingController(),
//       screenShots: <Uint8List>[],
//
//       /// slides settings
//       numberOfSlides: 0,
//       numberOfStrips: 0,
//
//       /// current slide settings
//       initialSlideIndex: 0,
//       currentSlideIndex: 0,
//       verticalIndex: 0,
//
//       /// flyer identifiers
//       key: ValueKey<String>(
//           '${bzModel.id} : ${bzModel.flyersIDs.length + 1} : ${FireAuthOps.superUserID()}'),
//       flyerID: SuperFlyer.draftID,
//       authorID: FireAuthOps.superUserID(),
//       title: null,
//       titleController: TextEditingController(),
//
//       /// flyer data
//       flyerType: FlyerTypeClass.concludeFlyerType(bzModel.bzTypes),
//       flyerState: FlyerState.draft,
//       flyerShowsAuthor: FlyerModel.canFlyerShowAuthor(bzModel: bzModel),
//
//       /// flyer tags
//       flyerInfo: null,
//       specs: <SpecModel>[],
//       keywords: <KW>[],
//
//       /// flyer location
//       zone: _zoneProvider.currentZone,
//       position: null,
//
//       /// publishing times
//       times: <PublishTime>[
//         PublishTime(state: FlyerState.draft, time: DateTime.now()),
//       ],
//       priceTagIsOn: false,
//
//       bzCountry: bzCountry,
//       bzCity: bzCity,
//
//       flyerCountry: flyerCountry,
//       flyerCity: flyerCity,
//     );
//   }
//
// // -----------------------------------------------------------------------------
//   static Future<SuperFlyer> createDraftSuperFlyerFromFlyer({
//     @required BuildContext context,
//     @required BzModel bzModel,
//     @required FlyerModel flyerModel,
//     @required Function onHorizontalSlideSwipe,
//     @required Function onVerticalPageSwipe,
//     @required Function onVerticalPageBack,
//     @required Function onHeaderTap,
//     @required Function onSlideRightTap,
//     @required Function onSlideLeftTap,
//     @required Function onSwipeFlyer,
//     @required Function onTinyFlyerTap,
//     @required Function onView,
//     @required Function onAnkhTap,
//     @required Function onShareTap,
//     @required Function onFollowTap,
//     @required Function onCallTap,
//     @required Function onCountersTap,
//     @required Function onAddImages,
//     @required Function onDeleteSlide,
//     @required Function onCropImage,
//     @required Function onResetImage,
//     @required Function onFitImage,
//     @required Function onFlyerTypeTap,
//     @required Function onZoneTap,
//     @required Function onAboutTap,
//     @required Function onKeywordsTap,
//     @required Function onSpecsTap,
//     @required Function onShowAuthorTap,
//     @required Function onTriggerEditMode,
//     @required Function onPublishFlyer,
//     @required Function onDeleteFlyer,
//     @required Function onUnPublishFlyer,
//     @required Function onRepublishFlyer,
//     @required double initialInfoScrollOffset,
//     @required Function onSaveInfoScrollOffset,
//     @required Function getInfoScrollOffset,
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//     @required CountryModel flyerCountry,
//     @required CityModel flyerCity,
//   }) async {
//     blog(
//         'CREATING draft super flyer from FLYER : ${flyerModel.id} for bz  : ${bzModel.name} : id : ${bzModel.id}');
//
//     final KeywordsProvider _keywordsProvider =
//         Provider.of<KeywordsProvider>(context, listen: false);
//
//     final ScrollController _infoScrollController = ScrollController(
//       initialScrollOffset: initialInfoScrollOffset ?? 0,
//     );
//     _infoScrollController.addListener(onSaveInfoScrollOffset);
//
//     return SuperFlyer(
//       nav: FlyerNavigator(
//         /// animation controller
//         horizontalController: PageController(),
//         verticalController: PageController(),
//         infoScrollController: _infoScrollController,
//
//         /// animation functions
//         onHorizontalSlideSwipe: onHorizontalSlideSwipe,
//         onVerticalPageSwipe: onVerticalPageSwipe,
//         onVerticalPageBack: onVerticalPageBack,
//         onHeaderTap: onHeaderTap,
//         onSlideRightTap: onSlideRightTap,
//         onSlideLeftTap: onSlideLeftTap,
//         onSwipeFlyer: onSwipeFlyer,
//         onTinyFlyerTap: onTinyFlyerTap,
//
//         /// animation parameters
//         progressBarOpacity: 1,
//         swipeDirection: Sliders.SwipeDirection.next,
//         bzPageIsOn: false,
//         listenToSwipe: true,
//         onSaveInfoScrollOffset: onSaveInfoScrollOffset,
//         getInfoScrollOffset: getInfoScrollOffset,
//       ),
//       rec: FlyerRecorder(
//         /// record functions
//         onViewSlide: onView,
//         onAnkhTap: onAnkhTap,
//         onShareTap: onShareTap,
//         onFollowTap: onFollowTap,
//         onCallTap: onCallTap,
//         onCountersTap: onCountersTap,
//
//         /// user based bool triggers
//         ankhIsOn: false,
//         followIsOn: false,
//         onEditReview: null,
//         onSubmitReview: null,
//         reviewController: null,
//         onShowReviewOptions: null,
//       ),
//       edit: FlyerEditor(
//         /// editor functions
//         onAddImages: onAddImages,
//         onDeleteSlide: onDeleteSlide,
//         onCropImage: onCropImage,
//         onResetImage: onResetImage,
//         onFitImage: onFitImage,
//         onFlyerTypeTap: onFlyerTypeTap,
//         onZoneTap: onZoneTap,
//         onEditInfoTap: onAboutTap,
//         onEditKeywordsTap: onKeywordsTap,
//         onEditSpecsTap: onSpecsTap,
//         onShowAuthorTap: onShowAuthorTap,
//         onTriggerEditMode: onTriggerEditMode,
//         onPublishFlyer: onPublishFlyer,
//         onDeleteFlyer: onDeleteFlyer,
//         onUnPublishFlyer: onUnPublishFlyer,
//         onRepublishFlyer: onRepublishFlyer,
//
//         /// editor data
//         firstTimer: false,
//         editMode: false,
//         canDelete: true,
//       ),
//       mSlides: await MutableSlide.getDraftMutableSlidesFromSlidesModels(
//           flyerModel.slides),
//       bz: bzModel,
//       loading: false,
//
//       /// editor data
//       infoController: TextEditingController(text: flyerModel.info),
//       // screenShots: await Imagers.getScreenShotsFromFiles(_assetsFiles),
//
//       /// slides settings
//       numberOfSlides: flyerModel.slides.length,
//       numberOfStrips: flyerModel.slides.length,
//
//       /// current slide settings
//       initialSlideIndex: 0,
//       currentSlideIndex: 0,
//       verticalIndex: 0,
//
//       /// flyer identifiers
//       key: ValueKey<String>(
//           '${SuperFlyer.draftID} : ${bzModel.id} : ${bzModel.flyersIDs.length + 1} : ${FireAuthOps.superUserID()}'),
//       flyerID: flyerModel.id,
//       authorID: FireAuthOps.superUserID(),
//       title: flyerModel.title,
//       titleController: TextEditingController(text: flyerModel.title),
//
//       /// flyer data
//       flyerType: flyerModel.flyerType,
//       flyerState: flyerModel.flyerState,
//       flyerShowsAuthor: flyerModel.showsAuthor,
//
//       /// flyer tags
//       flyerInfo: flyerModel.info,
//       specs: flyerModel.specs,
//       keywords: KW.getKeywordsFromKeywordsByIDs(
//           sourceKWs: _keywordsProvider.allKeywords,
//           keywordsIDs: flyerModel.keywordsIDs
//       ),
//
//       /// flyer location
//       zone: flyerModel.zone,
//       position: flyerModel.position,
//
//       /// publishing times
//       times: flyerModel.times,
//       priceTagIsOn: flyerModel.priceTagIsOn,
//
//       bzCountry: bzCountry,
//       bzCity: bzCity,
//
//       flyerCountry: flyerCountry,
//       flyerCity: flyerCity,
//     );
//   }
//
// // -----------------------------------------------------------------------------
//   static SuperFlyer getSuperFlyerFromBzModelOnly({
//     @required BzModel bzModel,
//     @required Function onHeaderTap,
//     @required CountryModel bzCountry,
//     @required CityModel bzCity,
//   }) {
//     return SuperFlyer(
//       nav: FlyerNavigator(
//         /// animation controller
//         horizontalController: PageController(),
//         verticalController: PageController(),
//         infoScrollController: ScrollController(),
//
//         /// animation functions
//         onHorizontalSlideSwipe: null,
//         onVerticalPageSwipe: null,
//         onVerticalPageBack: null,
//         onHeaderTap: onHeaderTap,
//         onSlideRightTap: null,
//         onSlideLeftTap: null,
//         onSwipeFlyer: null,
//         onTinyFlyerTap: null,
//
//         /// animation parameters
//         progressBarOpacity: 1,
//         swipeDirection: Sliders.SwipeDirection.next,
//         bzPageIsOn: false,
//         listenToSwipe: true,
//         getInfoScrollOffset: null,
//         onSaveInfoScrollOffset: null,
//       ),
//       rec: FlyerRecorder(
//         /// record functions
//         onViewSlide: null,
//         onAnkhTap: null,
//         onShareTap: null,
//         onFollowTap: null,
//         onCallTap: null,
//         onCountersTap: null,
//
//         /// user based bool triggers
//         ankhIsOn: null,
//         followIsOn: false,
//         onEditReview: null,
//         onSubmitReview: null,
//         reviewController: null,
//         onShowReviewOptions: null,
//       ),
//       edit: FlyerEditor(
//         /// editor functions
//         onAddImages: null,
//         onDeleteSlide: null,
//         onCropImage: null,
//         onResetImage: null,
//         onFitImage: null,
//         onFlyerTypeTap: null,
//         onZoneTap: null,
//         onEditInfoTap: null,
//         onEditKeywordsTap: null,
//         onEditSpecsTap: null,
//         onShowAuthorTap: null,
//         onTriggerEditMode: null,
//         onPublishFlyer: null,
//         onDeleteFlyer: null,
//         onUnPublishFlyer: null,
//         onRepublishFlyer: null,
//
//         /// editor data
//         firstTimer: null,
//         editMode: false,
//         canDelete: true,
//       ),
//       mSlides: null,
//       bz: bzModel,
//
//       loading: false,
//
//       /// editor data
//       infoController: null,
//
//       /// slides settings
//       numberOfSlides: 0,
//       numberOfStrips: 0,
//
//       /// current slide settings
//       initialSlideIndex: null,
//       currentSlideIndex: null,
//       verticalIndex: null,
//
//       /// flyer identifiers
//       key: null,
//       flyerID: SuperFlyer.emptyFlyerBzOnlyFlyerID,
//       authorID: FireAuthOps.superUserID(),
//       title: null,
//       titleController: null,
//
//       /// flyer data
//       flyerType: null,
//       flyerState: null,
//       flyerShowsAuthor: null,
//
//       /// flyer tags
//       flyerInfo: null,
//       specs: null,
//       keywords: null,
//
//       /// flyer location
//       zone: null,
//       position: null,
//
//       /// publishing times
//       times: null,
//
//       priceTagIsOn: null,
//
//       bzCountry: bzCountry,
//       bzCity: bzCity,
//
//       flyerCountry: null,
//       flyerCity: null,
//     );
//   }
//
// // // -----------------------------------------------------------------------------
// //   static List<ValueKey> getKeysOfDrafts(List<DraftFlyerModel> drafts){
// //     List<ValueKey> _keys = [];
// //
// //     if(drafts != null){
// //       drafts.forEach((draft) {
// //         _keys.add(draft.key);
// //       });
// //
// //     }
// //
// //     return _keys;
// //   }
// // // -----------------------------------------------------------------------------
//
// }

///

/*

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


 */