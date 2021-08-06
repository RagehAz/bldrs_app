import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/nano_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:bldrs/models/flyer/mutables/flyer_navigator.dart';
import 'package:bldrs/models/flyer/mutables/flyer_recorder.dart';
import 'package:bldrs/models/flyer/mutables/flyer_editor.dart';

/// need to add
/// string mapImageURL
/// all fields are valid

class SuperFlyer{

  final FlyerNavigator nav;
  final FlyerRecorder rec;
  final FlyerEditor edit;
  List<MutableSlide> mSlides; // MutableSlide


  /// animation parameters
  bool loading; // ??


  /// editor data
  List<ScreenshotController> screenshotsControllers; // MutableSlide
  List<Uint8List> screenShots; // --?

  TextEditingController infoController;

  /// slides settings
  int numberOfSlides; // MutableFlyer -- ?
  int numberOfStrips; // MutableFlyer -- ?

  /// current slide settings
  final int initialSlideIndex; // MutableFlyer -- ?
  int currentSlideIndex; // MutableFlyer -- ?
  int verticalIndex; // MutableFlyer -- ?

  /// bz data
  final BzType bzType; // bzModel
  final BzForm bzForm; // bzModel
  final DateTime bldrBirth; // bzModel
  final BzAccountType accountType; // bzModel
  final String bzURL; // bzModel
  final String bzName; // bzModel
  final dynamic bzLogo; // bzModel
  final String bzScope; // bzModel
  final Zone bzZone; // bzModel
  final String bzAbout; // bzModel
  final GeoPoint bzPosition; // bzModel
  final List<ContactModel> bzContacts; // bzModel
  final List<AuthorModel> bzAuthors; // bzModel
  final bool bzShowsTeam; // bzModel
  final bool bzIsVerified; // bzModel
  final bool bzAccountIsDeactivated; // bzModel
  final bool bzAccountIsBanned; // bzModel
  final List<NanoFlyer> bzNanoFlyers; // bzModel

  /// bz records
  int bzTotalFollowers; // bzModel
  int bzTotalFlyers; // bzModel
  int bzTotalSaves; // bzModel
  int bzTotalShares; // bzModel
  int bzTotalSlides; // bzModel
  int bzTotalViews; // bzModel
  int bzTotalCalls; // bzModel

  /// flyer identifiers
  final ValueKey key; // MutableFlyer -- ?
  final String flyerID; // MutableFlyer -- ?
  final String bzID; // bzModel
  String authorID; // tinyAuthor
  final String flyerURL; // MutableFlyer -- ?

  /// flyer data
  FlyerType flyerType; // MutableFlyer -- ?
  FlyerState flyerState; // MutableFlyer -- ?
  TinyUser flyerTinyAuthor; // tinyAuthor
  bool flyerShowsAuthor; // MutableFlyer -- ?

  /// flyer tags
  String flyerInfo; // MutableFlyer -- ?
  List<Spec> specs; // MutableFlyer -- ?
  List<dynamic> keywords; // MutableFlyer -- ?

  /// flyer location
  Zone flyerZone; // MutableFlyer -- ?
  GeoPoint position; // MutableFlyer -- ?

  /// publishing times
  List<PublishTime> flyerTimes; // MutableFlyer -- ?


  /// --------------------------------------------------------------------------
  SuperFlyer({

    /// navigator
    @required this.nav,
    /// recorder
    @required this.rec,
    /// editor
    @required this.edit,
    /// mutable slides
    @required this.mSlides,


    /// animation parameters
    @required this.loading,

    /// editor data
    @required this.infoController,
    @required this.screenshotsControllers,
    this.screenShots,

    /// slides settings
    @required this.numberOfSlides,
    @required this.numberOfStrips,

    /// current slide settings
    @required this.initialSlideIndex,
    @required this.currentSlideIndex,
    @required this.verticalIndex,

    /// bz data
    @required this.bzType,
    @required this.bzForm,
    @required this.bldrBirth,
    @required this.accountType,
    @required this.bzURL,
    @required this.bzName,
    @required this.bzLogo,
    @required this.bzScope,
    @required this.bzZone,
    @required this.bzAbout,
    @required this.bzPosition,
    @required this.bzContacts,
    @required this.bzAuthors,
    @required this.bzShowsTeam,
    @required this.bzIsVerified,
    @required this.bzAccountIsDeactivated,
    @required this.bzAccountIsBanned,
    @required this.bzNanoFlyers,

    /// bz records
    @required this.bzTotalFollowers,
    @required this.bzTotalFlyers,
    @required this.bzTotalSaves,
    @required this.bzTotalShares,
    @required this.bzTotalSlides,
    @required this.bzTotalViews,
    @required this.bzTotalCalls,

    /// flyer identifiers
    @required this.key,
    @required this.flyerID,
    @required this.bzID,
    @required this.authorID,
    @required this.flyerURL,

    /// flyer data
    @required this.flyerType,
    @required this.flyerState,
    @required this.flyerTinyAuthor,
    @required this.flyerShowsAuthor,

    /// flyer tags
    @required this.flyerInfo,
    @required this.specs,
    @required this.keywords,

    /// flyer location
    @required this.flyerZone,
    @required this.position,

    /// publishing times
    @required this.flyerTimes,

  });
// -----------------------------------------------------------------------------
  static String draftID = 'draft';
  static String emptyFlyerBzOnlyFlyerID = 'bzOnly';
// -----------------------------------------------------------------------------
  static SuperFlyer createEmptySuperFlyer({@required double flyerZoneWidth, @required goesToEditor}){

    return
        SuperFlyer(

          nav: FlyerNavigator(
            /// animation controller
            horizontalController: null,
            verticalController: null,
            infoScrollController: null,
            /// animation functions
            onHorizontalSlideSwipe: null,
            onVerticalPageSwipe: null,
            onVerticalPageBack: null,
            onHeaderTap: null,
            onSlideRightTap: null,
            onSlideLeftTap: null,
            onSwipeFlyer: null,
            onTinyFlyerTap: null,
            /// animation parameters
            progressBarOpacity: null,
            swipeDirection: null,
            bzPageIsOn: null,
            listenToSwipe: null,
          ),
          rec: FlyerRecorder(
            /// record functions
            onViewSlide: null,
            onAnkhTap: null,
            onShareTap: null,
            onFollowTap: null,
            onCallTap: null,
            /// user based bool triggers
            ankhIsOn: null,
            followIsOn: null,
          ),
          edit: FlyerEditor(
            /// editor functions
            onAddImages: null,
            onDeleteSlide: null,
            onCropImage: null,
            onResetImage: null,
            onFitImage: null,
            onFlyerTypeTap: null,
            onZoneTap: null,
            onEditInfoTap: null,
            onEditKeywordsTap: null,
            onShowAuthorTap: null,
            onTriggerEditMode: null,
            onPublishFlyer: null,
            onDeleteFlyer: null,
            onUnPublishFlyer: null,
            onRepublishFlyer: null,
            /// editor data
            firstTimer: goesToEditor == true ? true : null,
            editMode: goesToEditor == true ? true : false,
            canDelete: true,
          ),
          mSlides: null,

          loading: false,



          infoController: null,
          screenshotsControllers: null,
          screenShots: null,

          /// slides settings
          numberOfSlides: 0,
          numberOfStrips: 0,

          /// current slide settings
          initialSlideIndex: null,
          currentSlideIndex: null,
          verticalIndex: 0,

          /// bz data
          bzType: null,
          bzForm: null,
          bldrBirth: null,
          accountType: null,
          bzURL: null,
          bzName: null,
          bzLogo: null,
          bzScope: null,
          bzZone: null,
          bzAbout: null,
          bzPosition: null,
          bzContacts: null,
          bzAuthors: null,
          bzShowsTeam: null,
          bzIsVerified: null,
          bzAccountIsDeactivated: null,
          bzAccountIsBanned: null,
          bzNanoFlyers: null,

          /// bz records
          bzTotalFollowers: null,
          bzTotalFlyers: null,
          bzTotalSaves: null,
          bzTotalShares: null,
          bzTotalSlides: null,
          bzTotalViews: null,
          bzTotalCalls: null,

          /// flyer identifiers
          key: null,
          flyerID: null,
          bzID: null,
          authorID: null,
          flyerURL: null,

          /// flyer data
          flyerType: null,
          flyerState: null,
          flyerTinyAuthor: null,
          flyerShowsAuthor: null,

          /// flyer tags
          flyerInfo: null,
          specs: null,
          keywords: null,

          /// flyer location
          flyerZone: null,
          position: null,

          /// publishing times
          flyerTimes: null,

        );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createViewSuperFlyerFromFlyerModel({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required int initialPage,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
    @required Function onTinyFlyerTap,
    @required Function onView,
    @required Function onAnkhTap,
    @required Function onShareTap,
    @required Function onFollowTap,
    @required Function onCallTap,
  }){

    int _initialPage = initialPage == null ? 0 : initialPage;

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

    return
      SuperFlyer(

        nav: FlyerNavigator(
        /// animation controller
        horizontalController: PageController(initialPage: _initialPage, viewportFraction: 1, keepPage: true),
        verticalController: PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
        infoScrollController: ScrollController(keepScrollOffset: true,),
        /// animation functions
        onHorizontalSlideSwipe: onHorizontalSlideSwipe,
        onVerticalPageSwipe: onVerticalPageSwipe,
        onVerticalPageBack: onVerticalPageBack,
        onHeaderTap: onHeaderTap,
        onSlideRightTap: onSlideRightTap,
        onSlideLeftTap: onSlideLeftTap,
        onSwipeFlyer: onSwipeFlyer,
        onTinyFlyerTap: onTinyFlyerTap,
        /// animation parameters
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,
        ),
        rec: FlyerRecorder(
          /// record functions
          onViewSlide: onView,
          onAnkhTap: onAnkhTap,
          onShareTap: onShareTap,
          onFollowTap: onFollowTap,
          onCallTap: onCallTap,
          /// user based bool triggers
          ankhIsOn: _prof.checkAnkh(flyerModel.flyerID),
          followIsOn: _prof.checkFollow(flyerModel.tinyBz.bzID),
        ),
        edit: FlyerEditor(
          /// editor functions
          onAddImages: null,
          onDeleteSlide: null,
          onCropImage: null,
          onResetImage: null,
          onFitImage: null,
          onFlyerTypeTap: null,
          onZoneTap: null,
          onEditInfoTap: null,
          onEditKeywordsTap: null,
          onShowAuthorTap: null,
          onTriggerEditMode: null,
          onPublishFlyer: null,
          onDeleteFlyer: null,
          onUnPublishFlyer: null,
          onRepublishFlyer: null,
          /// editor data
          firstTimer: null,
          editMode: false,
          canDelete: true,
        ),
        mSlides: MutableSlide.getViewMutableSlidesFromSlidesModels(flyerModel.slides),


        loading: false,

        infoController: null,
        screenshotsControllers: null,
        screenShots: null,

        /// slides settings
        numberOfSlides: flyerModel.slides.length,
        numberOfStrips: flyerModel.slides.length,

        /// current slide settings
        initialSlideIndex: _initialPage,
        currentSlideIndex: _initialPage,
        verticalIndex: 0,

        /// bz data
        bzType: flyerModel.tinyBz.bzType,
        bzForm: null,
        bldrBirth: null,
        accountType: null,
        bzURL: null,
        bzName: flyerModel.tinyBz.bzName,
        bzLogo: flyerModel.tinyBz.bzLogo,
        bzScope: null,
        bzZone: flyerModel.tinyBz.bzZone,
        bzAbout: null,
        bzPosition: null,
        bzContacts: null,
        bzAuthors: null,
        bzShowsTeam: null,
        bzIsVerified: null,
        bzAccountIsDeactivated: null,
        bzAccountIsBanned: null,
        bzNanoFlyers: null,

        /// bz records
        bzTotalFollowers: flyerModel.tinyBz.bzTotalFollowers,
        bzTotalFlyers: flyerModel.tinyBz.bzTotalFlyers,
        bzTotalSaves: null,
        bzTotalShares: null,
        bzTotalSlides: null,
        bzTotalViews: null,
        bzTotalCalls: null,

        /// flyer identifiers
        key: ValueKey(flyerModel.flyerID),
        flyerID: flyerModel.flyerID,
        bzID: flyerModel.tinyBz.bzID,
        authorID: flyerModel.tinyAuthor.userID,
        flyerURL: flyerModel.flyerURL,

        /// flyer data
        flyerType: flyerModel.flyerType,
        flyerState: flyerModel.flyerState,
        flyerTinyAuthor: flyerModel.tinyAuthor,
        flyerShowsAuthor: flyerModel.flyerShowsAuthor,

        /// flyer tags
        flyerInfo: flyerModel.info,
        specs: flyerModel.specs,
        keywords: flyerModel.keywords,

        /// flyer location
        flyerZone: flyerModel.flyerZone,
        position: flyerModel.flyerPosition,

        /// publishing times
        flyerTimes: <PublishTime>[
          PublishTime(state: FlyerState.Published, timeStamp: flyerModel.publishTime),
          PublishTime(state: FlyerState.Deleted, timeStamp: flyerModel.deletionTime),
        ],

      );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createViewSuperFlyerFromTinyFlyer({
    @required BuildContext context,
    @required TinyFlyer tinyFlyer,
    @required Function onHeaderTap,
    @required Function onTinyFlyerTap,
    @required Function onAnkhTap,
  }){

    print('CREATING view super flyer from tiny flyer : ${tinyFlyer.flyerID} : ${tinyFlyer?.flyerType} : : ${tinyFlyer?.tinyBz?.bzName}');

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

    return
      SuperFlyer(

        nav: FlyerNavigator(
          /// animation controller
          horizontalController: null,
          verticalController: null,
          infoScrollController: null,
          /// animation functions
          onHorizontalSlideSwipe: null,
          onVerticalPageSwipe: null,
          onVerticalPageBack: null,
          onHeaderTap: onHeaderTap,
          onSlideRightTap: null,
          onSlideLeftTap: null,
          onSwipeFlyer: null,
          onTinyFlyerTap: onTinyFlyerTap,
          /// animation parameters
          progressBarOpacity: 1,
          swipeDirection: SwipeDirection.next,
          bzPageIsOn: false,
          listenToSwipe: false,
        ),
        rec: FlyerRecorder(
          /// record functions
          onViewSlide: null,
          onAnkhTap: onAnkhTap,
          onShareTap: null,
          onFollowTap: null,
          onCallTap: null,
          /// user based bool triggers
          ankhIsOn: _prof.checkAnkh(tinyFlyer.flyerID),
          followIsOn: _prof.checkFollow(tinyFlyer.tinyBz.bzID),
        ),
        edit: FlyerEditor(
          /// editor functions
          onAddImages: null,
          onDeleteSlide: null,
          onCropImage: null,
          onResetImage: null,
          onFitImage: null,
          onFlyerTypeTap: null,
          onZoneTap: null,
          onEditInfoTap: null,
          onEditKeywordsTap: null,
          onShowAuthorTap: null,
          onTriggerEditMode: null,
          onPublishFlyer: null,
          onDeleteFlyer: null,
          onUnPublishFlyer: null,
          onRepublishFlyer: null,
          /// editor data
          firstTimer: false,
          editMode: false,
          canDelete: true,
        ),
        mSlides: <MutableSlide>[MutableSlide(
            slideIndex: tinyFlyer.slideIndex,
            picURL: tinyFlyer.slidePic,
            picFile: null,
            picAsset: null,
            headline: null, /// TASK : should reconsider slide headlines in tinyFlyers
            headlineController: null,
            description: null,
            descriptionController: null,
            picFit: tinyFlyer.picFit,
            savesCount: null,
            sharesCount: null,
            viewsCount: null,
            imageSize: null,
            midColor: tinyFlyer.midColor,
            opacity: 1,
          ),],
        loading: false,



        /// editor data
        infoController: null,
        screenshotsControllers: null,
        screenShots: null,

        /// slides settings
        numberOfSlides: 1,
        numberOfStrips: 1,

        /// current slide settings
        initialSlideIndex: 0,
        currentSlideIndex: 0,
        verticalIndex: 0,

        /// bz data
        bzType: tinyFlyer?.tinyBz?.bzType,
        bzForm: null,
        bldrBirth: null,
        accountType: null,
        bzURL: null,
        bzName: tinyFlyer.tinyBz.bzName,
        bzLogo: tinyFlyer.tinyBz.bzLogo,
        bzScope: null,
        bzZone: tinyFlyer.tinyBz.bzZone,
        bzAbout: null,
        bzPosition: null,
        bzContacts: null,
        bzAuthors: null,
        bzShowsTeam: null,
        bzIsVerified: null,
        bzAccountIsDeactivated: null,
        bzAccountIsBanned: null,
        bzNanoFlyers: null,

        /// bz records
        bzTotalFollowers: tinyFlyer.tinyBz.bzTotalFollowers,
        bzTotalFlyers: tinyFlyer.tinyBz.bzTotalFlyers,
        bzTotalSaves: null,
        bzTotalShares: null,
        bzTotalSlides: null,
        bzTotalViews: null,
        bzTotalCalls: null,

        /// flyer identifiers
        key: ValueKey(tinyFlyer.flyerID),
        flyerID: tinyFlyer.flyerID,
        bzID: tinyFlyer.tinyBz.bzID,
        authorID: tinyFlyer.authorID,
        flyerURL: null,

        /// flyer data
        flyerType: tinyFlyer.flyerType,
        flyerState: null,
        flyerTinyAuthor: null,
        flyerShowsAuthor: null,

        /// flyer tags
        flyerInfo: null,
        specs: null,
        keywords: tinyFlyer.keywords,

        /// flyer location
        flyerZone: tinyFlyer.flyerZone,
        position: null,

        /// publishing times
        flyerTimes: null,

      );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createDraftSuperFlyerFromNothing({
    @required BuildContext context,
    @required BzModel bzModel,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
    @required Function onTinyFlyerTap,
    @required Function onView,
    @required Function onAnkhTap,
    @required Function onShareTap,
    @required Function onFollowTap,
    @required Function onCallTap,
    @required Function onAddImages,
    @required Function onDeleteSlide,
    @required Function onCropImage,
    @required Function onResetImage,
    @required Function onFitImage,
    @required Function onFlyerTypeTap,
    @required Function onZoneTap,
    @required Function onAboutTap,
    @required Function onKeywordsTap,
    @required Function onShowAuthorTap,
    @required Function onTriggerEditMode,
    @required Function onPublishFlyer,
    @required Function onDeleteFlyer,
    @required Function onUnPublishFlyer,
    @required Function onRepublishFlyer,
  }){

    print('CREATING draft super flyer from nothing for bz  : ${bzModel.bzName} : id : ${bzModel.bzID}');

    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);

    return
      SuperFlyer(

        nav: FlyerNavigator(
          /// animation controller
          horizontalController: PageController(initialPage: 0, viewportFraction: 1, keepPage: true),
          verticalController: PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
          infoScrollController: ScrollController(keepScrollOffset: true,),
          /// animation functions
          onHorizontalSlideSwipe: onHorizontalSlideSwipe,
          onVerticalPageSwipe: onVerticalPageSwipe,
          onVerticalPageBack: onVerticalPageBack,
          onHeaderTap: onHeaderTap,
          onSlideRightTap: onSlideRightTap,
          onSlideLeftTap: onSlideLeftTap,
          onSwipeFlyer: onSwipeFlyer,
          onTinyFlyerTap: onTinyFlyerTap,
          /// animation parameters
          progressBarOpacity: 1,
          swipeDirection: SwipeDirection.next,
          bzPageIsOn: false,
          listenToSwipe: true,

        ),
        rec: FlyerRecorder(
          /// record functions
          onViewSlide: onView,
          onAnkhTap: onAnkhTap,
          onShareTap: onShareTap,
          onFollowTap: onFollowTap,
          onCallTap: onCallTap,
          /// user based bool triggers
          ankhIsOn: false,
          followIsOn: false,
        ),
        edit: FlyerEditor(
          /// editor functions
          onAddImages: onAddImages,
          onDeleteSlide: onDeleteSlide,
          onCropImage: onCropImage,
          onResetImage: onResetImage,
          onFitImage: onFitImage,
          onFlyerTypeTap: onFlyerTypeTap,
          onZoneTap: onZoneTap,
          onEditInfoTap: onAboutTap,
          onEditKeywordsTap: onKeywordsTap,
          onShowAuthorTap: onShowAuthorTap,
          onTriggerEditMode: onTriggerEditMode,
          onPublishFlyer: onPublishFlyer,
          onDeleteFlyer: onDeleteFlyer,
          onUnPublishFlyer: onUnPublishFlyer,
          onRepublishFlyer: onRepublishFlyer,
          /// editor data
          firstTimer: true,
          editMode: true,
          canDelete: true,
        ),
        mSlides: new List(),

        loading: false,

        /// editor data
        infoController: new TextEditingController(),
        screenshotsControllers: new List(),
        screenShots: new List(),

        /// slides settings
        numberOfSlides: 0,
        numberOfStrips: 0,

        /// current slide settings
        initialSlideIndex: 0,
        currentSlideIndex: 0,
        verticalIndex: 0,

        /// bz data
        bzType: bzModel.bzType,
        bzForm: bzModel.bzForm,
        bldrBirth: bzModel.bldrBirth,
        accountType: bzModel.accountType,
        bzURL: bzModel.bzURL,
        bzName: bzModel.bzName,
        bzLogo: bzModel.bzLogo,
        bzScope: bzModel.bzScope,
        bzZone: bzModel.bzZone,
        bzAbout: bzModel.bzAbout,
        bzPosition: bzModel.bzPosition,
        bzContacts: bzModel.bzContacts,
        bzAuthors: bzModel.bzAuthors,
        bzShowsTeam: bzModel.bzShowsTeam,
        bzIsVerified: bzModel.bzIsVerified,
        bzAccountIsDeactivated: bzModel.bzAccountIsDeactivated,
        bzAccountIsBanned: bzModel.bzAccountIsBanned,
        bzNanoFlyers: bzModel.nanoFlyers,

        /// bz records
        bzTotalFollowers: bzModel.bzTotalFollowers,
        bzTotalFlyers: bzModel.nanoFlyers.length,
        bzTotalSaves: bzModel.bzTotalSaves,
        bzTotalShares: bzModel.bzTotalShares,
        bzTotalSlides: bzModel.bzTotalSlides,
        bzTotalViews: bzModel.bzTotalViews,
        bzTotalCalls: bzModel.bzTotalCalls,

        /// flyer identifiers
        key: ValueKey('${bzModel.bzID} : ${bzModel.nanoFlyers.length + 1} : ${superUserID()}'),
        flyerID: SuperFlyer.draftID,
        bzID: bzModel.bzID,
        authorID: superUserID(),
        flyerURL: null,

        /// flyer data
        flyerType: FlyerTypeClass.concludeFlyerType(bzModel.bzType),
        flyerState: FlyerState.Draft,
        flyerTinyAuthor: TinyUser.getTinyAuthorFromBzModel(bzModel: bzModel, authorID: superUserID()),
        flyerShowsAuthor: FlyerModel.canFlyerShowAuthor(bzModel: bzModel),

        /// flyer tags
        flyerInfo: null,
        specs: new List(),
        keywords: new List(),

        /// flyer location
        flyerZone: _countryPro.currentZone,
        position: null,

        /// publishing times
        flyerTimes: <PublishTime>[
          PublishTime(state: FlyerState.Draft, timeStamp: DateTime.now()),
        ],

      );

  }
// -----------------------------------------------------------------------------
  static Future<SuperFlyer> createDraftSuperFlyerFromFlyer({
    @required BuildContext context,
    @required BzModel bzModel,
    @required FlyerModel flyerModel,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
    @required Function onTinyFlyerTap,
    @required Function onView,
    @required Function onAnkhTap,
    @required Function onShareTap,
    @required Function onFollowTap,
    @required Function onCallTap,
    @required Function onAddImages,
    @required Function onDeleteSlide,
    @required Function onCropImage,
    @required Function onResetImage,
    @required Function onFitImage,
    @required Function onFlyerTypeTap,
    @required Function onZoneTap,
    @required Function onAboutTap,
    @required Function onKeywordsTap,
    @required Function onShowAuthorTap,
    @required Function onTriggerEditMode,
    @required Function onPublishFlyer,
    @required Function onDeleteFlyer,
    @required Function onUnPublishFlyer,
    @required Function onRepublishFlyer,
  }) async {

    print('CREATING draft super flyer from FLYER : ${flyerModel.flyerID} for bz  : ${bzModel.bzName} : id : ${bzModel.bzID}');


    return
      SuperFlyer(

        nav: FlyerNavigator(
          /// animation controller
          horizontalController: PageController(initialPage: 0, viewportFraction: 1, keepPage: true),
          verticalController: PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
          infoScrollController: ScrollController(keepScrollOffset: true,),
          /// animation functions
          onHorizontalSlideSwipe: onHorizontalSlideSwipe,
          onVerticalPageSwipe: onVerticalPageSwipe,
          onVerticalPageBack: onVerticalPageBack,
          onHeaderTap: onHeaderTap,
          onSlideRightTap: onSlideRightTap,
          onSlideLeftTap: onSlideLeftTap,
          onSwipeFlyer: onSwipeFlyer,
          onTinyFlyerTap: onTinyFlyerTap,
          /// animation parameters
          progressBarOpacity: 1,
          swipeDirection: SwipeDirection.next,
          bzPageIsOn: false,
          listenToSwipe: true,
        ),
        rec: FlyerRecorder(
          /// record functions
          onViewSlide: onView,
          onAnkhTap: onAnkhTap,
          onShareTap: onShareTap,
          onFollowTap: onFollowTap,
          onCallTap: onCallTap,
          /// user based bool triggers
          ankhIsOn: false,
          followIsOn: false,
        ),
        edit: FlyerEditor(
          /// editor functions
          onAddImages: onAddImages,
          onDeleteSlide: onDeleteSlide,
          onCropImage: onCropImage,
          onResetImage: onResetImage,
          onFitImage: onFitImage,
          onFlyerTypeTap: onFlyerTypeTap,
          onZoneTap: onZoneTap,
          onEditInfoTap: onAboutTap,
          onEditKeywordsTap: onKeywordsTap,
          onShowAuthorTap: onShowAuthorTap,
          onTriggerEditMode: onTriggerEditMode,
          onPublishFlyer: onPublishFlyer,
          onDeleteFlyer: onDeleteFlyer,
          onUnPublishFlyer: onUnPublishFlyer,
          onRepublishFlyer: onRepublishFlyer,
          /// editor data
          firstTimer: false,
          editMode: false,
          canDelete: true,
        ),
        mSlides: await MutableSlide.getDraftMutableSlidesFromSlidesModels(flyerModel.slides),

        loading: false,




        /// editor data
        infoController: new TextEditingController(text: flyerModel.info),
        screenshotsControllers: FlyerModel.createScreenShotsControllersForExistingFlyer(flyerModel),
        // screenShots: await Imagers.getScreenShotsFromFiles(_assetsFiles),

        /// slides settings
        numberOfSlides: flyerModel.slides.length,
        numberOfStrips: flyerModel.slides.length,

        /// current slide settings
        initialSlideIndex: 0,
        currentSlideIndex: 0,
        verticalIndex: 0,

        /// bz data
        bzType: bzModel.bzType,
        bzForm: bzModel.bzForm,
        bldrBirth: bzModel.bldrBirth,
        accountType: bzModel.accountType,
        bzURL: bzModel.bzURL,
        bzName: bzModel.bzName,
        bzLogo: bzModel.bzLogo,
        bzScope: bzModel.bzScope,
        bzZone: bzModel.bzZone,
        bzAbout: bzModel.bzAbout,
        bzPosition: bzModel.bzPosition,
        bzContacts: bzModel.bzContacts,
        bzAuthors: bzModel.bzAuthors,
        bzShowsTeam: bzModel.bzShowsTeam,
        bzIsVerified: bzModel.bzIsVerified,
        bzAccountIsDeactivated: bzModel.bzAccountIsDeactivated,
        bzAccountIsBanned: bzModel.bzAccountIsBanned,
        bzNanoFlyers: bzModel.nanoFlyers,

        /// bz records
        bzTotalFollowers: bzModel.bzTotalFollowers,
        bzTotalFlyers: bzModel.nanoFlyers.length,
        bzTotalSaves: bzModel.bzTotalSaves,
        bzTotalShares: bzModel.bzTotalShares,
        bzTotalSlides: bzModel.bzTotalSlides,
        bzTotalViews: bzModel.bzTotalViews,
        bzTotalCalls: bzModel.bzTotalCalls,

        /// flyer identifiers
        key: ValueKey('${SuperFlyer.draftID} : ${bzModel.bzID} : ${bzModel.nanoFlyers.length + 1} : ${superUserID()}'),
        flyerID: flyerModel.flyerID,
        bzID: bzModel.bzID,
        authorID: superUserID(),
        flyerURL: flyerModel.flyerURL,

        /// flyer data
        flyerType: flyerModel.flyerType,
        flyerState: flyerModel.flyerState,
        flyerTinyAuthor: flyerModel.tinyAuthor,
        flyerShowsAuthor: flyerModel.flyerShowsAuthor,

        /// flyer tags
        flyerInfo: flyerModel.info,
        specs: flyerModel.specs,
        keywords: flyerModel.keywords,

        /// flyer location
        flyerZone: flyerModel.flyerZone,
        position: flyerModel.flyerPosition,

        /// publishing times
        flyerTimes: <PublishTime>[
          PublishTime(state: FlyerState.Published, timeStamp: flyerModel.publishTime),
          PublishTime(state: FlyerState.Deleted, timeStamp: flyerModel.deletionTime),
          PublishTime(state: FlyerState.Draft, timeStamp: DateTime.now()),
        ],

      );

  }
// -----------------------------------------------------------------------------
static TinyBz getTinyBzFromSuperFlyer(SuperFlyer superFlyer){
    return
        TinyBz(
            bzID: superFlyer.bzID,
            bzLogo: superFlyer.bzLogo,
            bzName: superFlyer.bzName,
            bzType: superFlyer.bzType,
            bzZone: superFlyer.bzZone,
            bzTotalFollowers: superFlyer.bzTotalFollowers,
            bzTotalFlyers: superFlyer.bzTotalFlyers,
        );
}
// -----------------------------------------------------------------------------
static SuperFlyer getSuperFlyerFromBzModelOnly({
  BzModel bzModel,
  @required onHeaderTap,
}){
    return
      SuperFlyer(
        nav: FlyerNavigator(
          /// animation controller
          horizontalController: PageController(initialPage: 0, viewportFraction: 1, keepPage: true),
          verticalController: PageController(initialPage: 0, keepPage: true, viewportFraction: 1),
          infoScrollController: ScrollController(keepScrollOffset: true,),
          /// animation functions
          onHorizontalSlideSwipe: null,
          onVerticalPageSwipe: null,
          onVerticalPageBack: null,
          onHeaderTap: onHeaderTap,
          onSlideRightTap: null,
          onSlideLeftTap: null,
          onSwipeFlyer: null,
          onTinyFlyerTap: null,
          /// animation parameters
          progressBarOpacity: 1,
          swipeDirection: SwipeDirection.next,
          bzPageIsOn: false,
          listenToSwipe: true,
        ),
        rec: FlyerRecorder(
          /// record functions
          onViewSlide: null,
          onAnkhTap: null,
          onShareTap: null,
          onFollowTap: null,
          onCallTap: null,
          /// user based bool triggers
          ankhIsOn: null,
          followIsOn: false,
        ),
        edit: FlyerEditor(
          /// editor functions
          onAddImages: null,
          onDeleteSlide: null,
          onCropImage: null,
          onResetImage: null,
          onFitImage: null,
          onFlyerTypeTap: null,
          onZoneTap: null,
          onEditInfoTap: null,
          onEditKeywordsTap: null,
          onShowAuthorTap: null,
          onTriggerEditMode: null,
          onPublishFlyer: null,
          onDeleteFlyer: null,
          onUnPublishFlyer: null,
          onRepublishFlyer: null,
          /// editor data
          firstTimer: null,
          editMode: false,
          canDelete: true,
        ),
        mSlides: null,

        loading: false,

        /// editor data
        infoController: null,
        screenshotsControllers: null,
        screenShots: null,

        /// slides settings
        numberOfSlides: 0,
        numberOfStrips: 0,

        /// current slide settings
        initialSlideIndex: null,
        currentSlideIndex: null,
        verticalIndex: null,

        /// bz data
        bzType: bzModel.bzType,
        bzForm: bzModel.bzForm,
        bldrBirth: bzModel.bldrBirth,
        accountType: bzModel.accountType,
        bzURL: bzModel.bzURL,
        bzName: bzModel.bzName,
        bzLogo: bzModel.bzLogo,
        bzScope: bzModel.bzScope,
        bzZone: bzModel.bzZone,
        bzAbout: bzModel.bzAbout,
        bzPosition: bzModel.bzPosition,
        bzContacts: bzModel.bzContacts,
        bzAuthors: bzModel.bzAuthors,
        bzShowsTeam: bzModel.bzShowsTeam,
        bzIsVerified: bzModel.bzIsVerified,
        bzAccountIsDeactivated: bzModel.bzAccountIsDeactivated,
        bzAccountIsBanned: bzModel.bzAccountIsBanned,
        bzNanoFlyers: bzModel.nanoFlyers,

        /// bz records
        bzTotalFollowers: bzModel.bzTotalFollowers,
        bzTotalFlyers: bzModel.nanoFlyers.length,
        bzTotalSaves: bzModel.bzTotalSaves,
        bzTotalShares: bzModel.bzTotalShares,
        bzTotalSlides: bzModel.bzTotalSlides,
        bzTotalViews: bzModel.bzTotalViews,
        bzTotalCalls: bzModel.bzTotalCalls,

        /// flyer identifiers
        key: null,
        flyerID: SuperFlyer.emptyFlyerBzOnlyFlyerID,
        bzID: bzModel.bzID,
        authorID: superUserID(),
        flyerURL: null,

        /// flyer data
        flyerType: null,
        flyerState: null,
        flyerTinyAuthor: null,
        flyerShowsAuthor: null,

        /// flyer tags
        flyerInfo: null,
        specs: null,
        keywords: null,

        /// flyer location
        flyerZone: null,
        position: null,

        /// publishing times
        flyerTimes: null,

      );
}

// // -----------------------------------------------------------------------------
//   static List<ValueKey> getKeysOfDrafts(List<DraftFlyerModel> drafts){
//     List<ValueKey> _keys = new List();
//
//     if(drafts != null){
//       drafts.forEach((draft) {
//         _keys.add(draft.key);
//       });
//
//     }
//
//     return _keys;
//   }
// // -----------------------------------------------------------------------------

}

