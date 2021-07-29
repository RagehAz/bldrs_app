import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/flyer_type_class.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/sub_models/publish_time_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/sub_models/spec_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

/// need to add
/// string mapImageURL
/// all fields are valid

class SuperFlyer{
  /// sizes
  double flyerZoneWidth;

  /// animation controller
  final PageController horizontalController;
  final PageController verticalController;
  final ScrollController infoScrollController;

  /// animation functions
  final Function onHorizontalSlideSwipe;
  final Function onVerticalPageSwipe;
  final Function onVerticalPageBack;
  final Function onHeaderTap;
  final Function onSlideRightTap;
  final Function onSlideLeftTap;
  final Function onSwipeFlyer;
  final Function onTinyFlyerTap;

  /// animation parameters
  final Duration slidingDuration;
  final Duration fadingDuration;
  double progressBarOpacity;
  SwipeDirection swipeDirection;
  bool bzPageIsOn;
  bool listenToSwipe;
  bool loading;

  /// record functions
  final Function onView;
  final Function onAnkhTap;
  final Function onShareTap;
  final Function onFollowTap;
  final Function onCallTap;

  /// editor functions
  final Function onAddImages;
  final Function onDeleteSlide;
  final Function onCropImage;
  final Function onResetImage;
  final Function onFitImage;
  final Function onFlyerTypeTap;
  final Function onZoneTap;
  final Function onAboutTap;
  final Function onKeywordsTap;
  final Function onShowAuthorTap;
  final Function onTriggerEditMode;
  final Function onPublishFlyer;

  /// editor data
  bool firstTimer;
  bool editMode; // to trigger between view mode and edit mode for the draft
  bool isDraft; // to label the flyer that is currently being drafted as new or existing flyer
  List<TextEditingController> headlinesControllers;
  List<TextEditingController> descriptionsControllers;
  TextEditingController infoController;
  List<Asset> assetsSources;
  List<File> assetsFiles;
  List<BoxFit> boxesFits;

  /// slides settings
  List<bool> slidesVisibilities;
  int numberOfSlides;
  int numberOfStrips;

  /// current slide settings
  BoxFit currentPicFit;
  final int initialSlideIndex;
  int currentSlideIndex;
  int verticalIndex;

  /// bz data
  final BzType bzType;
  final BzForm bzForm;
  final DateTime bldrBirth;
  final BzAccountType accountType;
  final String bzURL;
  final String bzName;
  final dynamic bzLogo;
  final String bzScope;
  final Zone bzZone;
  final String bzAbout;
  final GeoPoint bzPosition;
  final List<ContactModel> bzContacts;
  final List<AuthorModel> bzAuthors;
  final bool bzShowsTeam;
  final bool bzIsVerified;
  final bool bzAccountIsDeactivated;
  final bool bzAccountIsBanned;
  final List<NanoFlyer> bzNanoFlyers;

  /// bz records
  int bzTotalFollowers;
  int bzTotalFlyers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;

  /// flyer identifiers
  final ValueKey key;
  final String flyerID;
  final String bzID;
  String authorID;
  final String flyerURL;

  /// flyer data
  FlyerType flyerType;
  FlyerState flyerState;
  TinyUser flyerTinyAuthor;
  bool flyerShowsAuthor;
  List<SlideModel> slides;

  /// flyer tags
  String flyerInfo;
  List<Spec> specs;
  List<dynamic> keywords;

  /// flyer location
  Zone flyerZone;
  GeoPoint position;

  /// publishing times
  List<PublishTime> flyerTimes;

  /// user based bool triggers
  bool ankhIsOn;
  bool followIsOn;


  /// --------------------------------------------------------------------------
  SuperFlyer({
    /// sizes
    @required this.flyerZoneWidth,

    /// animation controller
    @required this.horizontalController,
    @required this.verticalController,
    @required this.infoScrollController,

    /// animation functions
    @required this.onHorizontalSlideSwipe,
    @required this.onVerticalPageSwipe,
    @required this.onVerticalPageBack,
    @required this.onHeaderTap,
    @required this.onSlideRightTap,
    @required this.onSlideLeftTap,
    @required this.onSwipeFlyer,
    @required this.onTinyFlyerTap,

    /// animation parameters
    @required this.slidingDuration,
    @required this.fadingDuration,
    @required this.progressBarOpacity,
    @required this.swipeDirection,
    @required this.bzPageIsOn,
    @required this.listenToSwipe,
    @required this.loading,

    /// record functions
    @required this.onView,
    @required this.onAnkhTap,
    @required this.onShareTap,
    @required this.onFollowTap,
    @required this.onCallTap,

    /// editor functions
    @required this.onAddImages,
    @required this.onDeleteSlide,
    @required this.onCropImage,
    @required this.onResetImage,
    @required this.onFitImage,
    @required this.onFlyerTypeTap,
    @required this.onZoneTap,
    @required this.onAboutTap,
    @required this.onKeywordsTap,
    @required this.onShowAuthorTap,
    @required this.onTriggerEditMode,
    @required this.onPublishFlyer,

    /// editor data
    @required this.firstTimer,
    @required this.editMode,
    @required this.isDraft,
    @required this.headlinesControllers,
    @required this.descriptionsControllers,
    @required this.infoController,
    @required this.assetsSources,
    @required this.assetsFiles,
    @required this.boxesFits,

    /// slides settings
    @required this.slidesVisibilities,
    @required this.numberOfSlides,
    @required this.numberOfStrips,

    /// current slide settings
    @required this.currentPicFit,
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
    @required this.slides,

    /// flyer tags
    @required this.flyerInfo,
    @required this.specs,
    @required this.keywords,

    /// flyer location
    @required this.flyerZone,
    @required this.position,

    /// publishing times
    @required this.flyerTimes,

    /// user based bool triggers
    @required this.ankhIsOn,
    @required this.followIsOn,
  });
// -----------------------------------------------------------------------------
  static String draftID = 'draft';
  static String emptyFlyerBzOnlyFlyerID = 'bzOnly';
// -----------------------------------------------------------------------------
  static SuperFlyer createEmptySuperFlyer({@required double flyerZoneWidth}){


    return
        SuperFlyer(
          /// sizes
          flyerZoneWidth: flyerZoneWidth,

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
          slidingDuration: null,
          fadingDuration: null,
          progressBarOpacity: null,
          swipeDirection: null,
          bzPageIsOn: null,
          listenToSwipe: null,
          loading: false,

          /// record functions
          onView: null,
          onAnkhTap: null,
          onShareTap: null,
          onFollowTap: null,
          onCallTap: null,

          /// editor functions
          onAddImages: null,
          onDeleteSlide: null,
          onCropImage: null,
          onResetImage: null,
          onFitImage: null,
          onFlyerTypeTap: null,
          onZoneTap: null,
          onAboutTap: null,
          onKeywordsTap: null,
          onShowAuthorTap: null,
          onTriggerEditMode: null,
          onPublishFlyer: null,

          /// editor data
          firstTimer: null,
          editMode: null,
          isDraft: null,
          headlinesControllers: null,
          descriptionsControllers: null,
          infoController: null,
          assetsSources: null,
          assetsFiles: null,
          boxesFits: null,

          /// slides settings
          slidesVisibilities: null,
          numberOfSlides: null,
          numberOfStrips: null,

          /// current slide settings
          currentPicFit: null,
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
          slides: null,

          /// flyer tags
          flyerInfo: null,
          specs: null,
          keywords: null,

          /// flyer location
          flyerZone: null,
          position: null,

          /// publishing times
          flyerTimes: null,

          /// user based bool triggers
          ankhIsOn: null,
          followIsOn: null,
        );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createViewSuperFlyerFromFlyerModel({
    @required BuildContext context,
    @required double flyerZoneWidth,
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
        /// sizes
        flyerZoneWidth: flyerZoneWidth,

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
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,
        loading: false,

        /// record functions
        onView: onView,
        onAnkhTap: onAnkhTap,
        onShareTap: onShareTap,
        onFollowTap: onFollowTap,
        onCallTap: onCallTap,

        /// editor functions
        onAddImages: null,
        onDeleteSlide: null,
        onCropImage: null,
        onResetImage: null,
        onFitImage: null,
        onFlyerTypeTap: null,
        onZoneTap: null,
        onAboutTap: null,
        onKeywordsTap: null,
        onShowAuthorTap: null,
        onTriggerEditMode: null,
        onPublishFlyer: null,

        /// editor data
        firstTimer: null,
        editMode: false,
        isDraft: false,
        headlinesControllers: null,
        descriptionsControllers: null,
        infoController: null,
        assetsSources: null,
        assetsFiles: null,
        boxesFits: SlideModel.getSlidesBoxFits(flyerModel.slides),

        /// slides settings
        slidesVisibilities: Animators.createSlidesVisibilityList(flyerModel.slides.length),
        numberOfSlides: flyerModel.slides.length,
        numberOfStrips: flyerModel.slides.length,

        /// current slide settings
        currentPicFit: flyerModel.slides[_initialPage].boxFit,
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
        slides: flyerModel.slides,

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

        /// user based bool triggers
        ankhIsOn: _prof.checkAnkh(flyerModel.flyerID),
        followIsOn: _prof.checkFollow(flyerModel.tinyBz.bzID),
      );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createViewSuperFlyerFromTinyFlyer({
    @required BuildContext context,
    @required double flyerZoneWidth,
    @required TinyFlyer tinyFlyer,
    @required Function onHeaderTap,
    @required Function onTinyFlyerTap,
    @required Function onAnkhTap,
  }){

    print('CREATING view super flyer from tiny flyer : ${tinyFlyer.flyerID} : ${tinyFlyer?.flyerType} : : ${tinyFlyer?.tinyBz?.bzName}');

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: flyerZoneWidth,

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
        slidingDuration: null,
        fadingDuration: null,
        progressBarOpacity: 0,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: false,
        loading: false,

        /// record functions
        onView: null,
        onAnkhTap: onAnkhTap,
        onShareTap: null,
        onFollowTap: null,
        onCallTap: null,

        /// editor functions
        onAddImages: null,
        onDeleteSlide: null,
        onCropImage: null,
        onResetImage: null,
        onFitImage: null,
        onFlyerTypeTap: null,
        onZoneTap: null,
        onAboutTap: null,
        onKeywordsTap: null,
        onShowAuthorTap: null,
        onTriggerEditMode: null,
        onPublishFlyer: null,

        /// editor data
        firstTimer: false,
        editMode: false,
        isDraft: false,
        headlinesControllers: null,
        descriptionsControllers: null,
        infoController: null,
        assetsSources: null,
        assetsFiles: null,
        boxesFits: null,

        /// slides settings
        slidesVisibilities: <bool>[true],
        numberOfSlides: 1,
        numberOfStrips: null,

        /// current slide settings
        currentPicFit: tinyFlyer.picFit,
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
        slides: <SlideModel>[
          SlideModel(
            picture: tinyFlyer.slidePic,
            headline: null, /// TASK : should reconsider slide headlines in tinyFlyers
            description: null,
            boxFit: tinyFlyer.picFit,
            savesCount: null,
            sharesCount: null,
            slideIndex: 0,
            viewsCount: null,
          ),
        ],

        /// flyer tags
        flyerInfo: null,
        specs: null,
        keywords: tinyFlyer.keywords,

        /// flyer location
        flyerZone: tinyFlyer.flyerZone,
        position: null,

        /// publishing times
        flyerTimes: null,

        /// user based bool triggers
        ankhIsOn: _prof.checkAnkh(tinyFlyer.flyerID),
        followIsOn: _prof.checkFollow(tinyFlyer.tinyBz.bzID),
      );
  }
// -----------------------------------------------------------------------------
  static SuperFlyer createDraftSuperFlyerFromNothing({
    @required BuildContext context,
    @required double flyerZoneWidth,
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
  }){

    print('CREATING draft super flyer from nothing for bz  : ${bzModel.bzName} : id : ${bzModel.bzID}');

    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: flyerZoneWidth,

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
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,
        loading: false,

        /// record functions
        onView: onView,
        onAnkhTap: onAnkhTap,
        onShareTap: onShareTap,
        onFollowTap: onFollowTap,
        onCallTap: onCallTap,

        /// editor functions
        onAddImages: onAddImages,
        onDeleteSlide: onDeleteSlide,
        onCropImage: onCropImage,
        onResetImage: onResetImage,
        onFitImage: onFitImage,
        onFlyerTypeTap: onFlyerTypeTap,
        onZoneTap: onZoneTap,
        onAboutTap: onAboutTap,
        onKeywordsTap: onKeywordsTap,
        onShowAuthorTap: onShowAuthorTap,
        onTriggerEditMode: onTriggerEditMode,
        onPublishFlyer: onPublishFlyer,


        /// editor data
        firstTimer: true,
        editMode: true,
        isDraft: true,
        headlinesControllers: new List(),
        descriptionsControllers: new List(),
        infoController: new TextEditingController(),
        assetsSources: new List(),
        assetsFiles: new List(),
        boxesFits: new List(),

        /// slides settings
        slidesVisibilities: new List(),
        numberOfSlides: 0,
        numberOfStrips: 0,

        /// current slide settings
        currentPicFit: null,
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
        slides: new List(),

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

        /// user based bool triggers
        ankhIsOn: false,
        followIsOn: false,
      );

  }
// -----------------------------------------------------------------------------
  static Future<SuperFlyer> createDraftSuperFlyerFromFlyer({
    @required BuildContext context,
    @required double flyerZoneWidth,
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
  }) async {

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: flyerZoneWidth,

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
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,
        loading: false,

        /// record functions
        onView: onView,
        onAnkhTap: onAnkhTap,
        onShareTap: onShareTap,
        onFollowTap: onFollowTap,
        onCallTap: onCallTap,

        /// editor functions
        onAddImages: onAddImages,
        onDeleteSlide: onDeleteSlide,
        onCropImage: onCropImage,
        onResetImage: onResetImage,
        onFitImage: onFitImage,
        onFlyerTypeTap: onFlyerTypeTap,
        onZoneTap: onZoneTap,
        onAboutTap: onAboutTap,
        onKeywordsTap: onKeywordsTap,
        onShowAuthorTap: onShowAuthorTap,
        onTriggerEditMode: onTriggerEditMode,
        onPublishFlyer: onPublishFlyer,

        /// editor data
        firstTimer: false,
        editMode: true,
        isDraft: true,
        headlinesControllers: FlyerModel.createHeadlinesControllersForExistingFlyer(flyerModel),
        descriptionsControllers: FlyerModel.createDescriptionsControllersForExistingFlyer(flyerModel),
        infoController: new TextEditingController(text: flyerModel.info),
        assetsSources: new List(),
        assetsFiles: await SlideModel.getImageFilesFromPublishedSlides(flyerModel.slides),
        boxesFits: SlideModel.getSlidesBoxFits(flyerModel.slides),

        /// slides settings
        slidesVisibilities: SlideModel.createVisibilityListFromSlides(flyerModel.slides),
        numberOfSlides: flyerModel.slides.length,
        numberOfStrips: flyerModel.slides.length,

        /// current slide settings
        currentPicFit: flyerModel.slides.length == 0 ? null : flyerModel.slides[0].boxFit,
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
        slides: flyerModel.slides,

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

        /// user based bool triggers
        ankhIsOn: false,
        followIsOn: false,
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
  double flyerZoneWidth,
  BzModel bzModel,
  @required onHeaderTap,
}){
    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: flyerZoneWidth,

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
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,
        loading: false,

        /// record functions
        onView: null,
        onAnkhTap: null,
        onShareTap: null,
        onFollowTap: null,
        onCallTap: null,

        /// editor functions
        onAddImages: null,
        onDeleteSlide: null,
        onCropImage: null,
        onResetImage: null,
        onFitImage: null,
        onFlyerTypeTap: null,
        onZoneTap: null,
        onAboutTap: null,
        onKeywordsTap: null,
        onShowAuthorTap: null,
        onTriggerEditMode: null,
        onPublishFlyer: null,


        /// editor data
        firstTimer: null,
        editMode: null,
        isDraft: false,
        headlinesControllers: null,
        descriptionsControllers: null,
        infoController: null,
        assetsSources: null,
        assetsFiles: null,
        boxesFits: null,

        /// slides settings
        slidesVisibilities: null,
        numberOfSlides: null,
        numberOfStrips: null,

        /// current slide settings
        currentPicFit: null,
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
        slides: null,

        /// flyer tags
        flyerInfo: null,
        specs: null,
        keywords: null,

        /// flyer location
        flyerZone: null,
        position: null,

        /// publishing times
        flyerTimes: null,

        /// user based bool triggers
        ankhIsOn: null,
        followIsOn: false,
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

