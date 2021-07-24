import 'dart:io';
import 'package:bldrs/controllers/drafters/animators.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/secondary_models/draft_flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/sub_models/publish_time_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/sub_models/spec_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';

class SuperFlyer{
  /// sizes
  double flyerZoneWidth;
  double flyerZoneHeight;
  double flyerSizeFactor;

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

  /// animation parameters
  final Duration slidingDuration;
  final Duration fadingDuration;
  double progressBarOpacity;
  SwipeDirection swipeDirection;
  bool bzPageIsOn;
  bool listenToSwipe;

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

  /// editor data
  bool firstTimer;
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
  List<Keyword> keywords;

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
    this.flyerZoneWidth,
    this.flyerZoneHeight,
    this.flyerSizeFactor,

    /// animation controller
    this.horizontalController,
    this.verticalController,
    this.infoScrollController,

    /// animation functions
    this.onHorizontalSlideSwipe,
    this.onVerticalPageSwipe,
    this.onVerticalPageBack,
    this.onHeaderTap,
    this.onSlideRightTap,
    this.onSlideLeftTap,
    this.onSwipeFlyer,

    /// animation parameters
    this.slidingDuration,
    this.fadingDuration,
    this.progressBarOpacity,
    this.swipeDirection,
    this.bzPageIsOn,
    this.listenToSwipe,

    /// record functions
    this.onView,
    this.onAnkhTap,
    this.onShareTap,
    this.onFollowTap,
    this.onCallTap,

    /// editor functions
    this.onAddImages,
    this.onDeleteSlide,
    this.onCropImage,
    this.onResetImage,
    this.onFitImage,
    this.onFlyerTypeTap,
    this.onZoneTap,
    this.onAboutTap,
    this.onKeywordsTap,

    /// editor data
    this.firstTimer,
    this.headlinesControllers,
    this.descriptionsControllers,
    this.infoController,
    this.assetsSources,
    this.assetsFiles,
    this.boxesFits,

    /// slides settings
    this.slidesVisibilities,
    this.numberOfSlides,
    this.numberOfStrips,

    /// current slide settings
    this.currentPicFit,
    this.initialSlideIndex,
    this.currentSlideIndex,

    /// bz data
    this.bzType,
    this.bzForm,
    this.bldrBirth,
    this.accountType,
    this.bzURL,
    this.bzName,
    this.bzLogo,
    this.bzScope,
    this.bzZone,
    this.bzAbout,
    this.bzPosition,
    this.bzContacts,
    this.bzAuthors,
    this.bzShowsTeam,
    this.bzIsVerified,
    this.bzAccountIsDeactivated,
    this.bzAccountIsBanned,
    this.bzNanoFlyers,

    /// bz records
    this.bzTotalFollowers,
    this.bzTotalFlyers,
    this.bzTotalSaves,
    this.bzTotalShares,
    this.bzTotalSlides,
    this.bzTotalViews,
    this.bzTotalCalls,

    /// flyer identifiers
    this.key,
    this.flyerID,
    this.bzID,
    this.authorID,
    this.flyerURL,

    /// flyer data
    this.flyerType,
    this.flyerState,
    this.flyerTinyAuthor,
    this.flyerShowsAuthor,
    this.slides,

    /// flyer tags
    this.flyerInfo,
    this.specs,
    this.keywords,

    /// flyer location
    this.flyerZone,
    this.position,

    /// publishing times
    this.flyerTimes,

    /// user based bool triggers
    this.ankhIsOn,
    this.followIsOn,
  });
// -----------------------------------------------------------------------------
  static SuperFlyer createEmptySuperFlyer({BuildContext context, double flyerSizeFactor}){

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);

    return
        SuperFlyer(
          /// sizes
          flyerZoneWidth: _flyerZoneWidth,
          flyerZoneHeight: Scale.superFlyerZoneHeight(context, _flyerZoneWidth),
          flyerSizeFactor: flyerSizeFactor,

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

          /// animation parameters
          slidingDuration: null,
          fadingDuration: null,
          progressBarOpacity: null,
          swipeDirection: null,
          bzPageIsOn: null,
          listenToSwipe: null,

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

          /// editor data
          firstTimer: null,
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
    @required double flyerSizeFactor,
    @required FlyerModel flyerModel,
    @required int initialPage,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
    @required Function onView,
    @required Function onAnkhTap,
    @required Function onShareTap,
    @required Function onFollowTap,
    @required Function onCallTap,
  }){

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);
    int _initialPage = initialPage == null ? 0 : initialPage;

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: _flyerZoneWidth,
        flyerZoneHeight: Scale.superFlyerZoneHeight(context, _flyerZoneWidth),
        flyerSizeFactor: flyerSizeFactor,

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

        /// animation parameters
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,

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

        /// editor data
        firstTimer: null,
        headlinesControllers: null,
        descriptionsControllers: null,
        infoController: null,
        assetsSources: null,
        assetsFiles: null,
        boxesFits: null,

        /// slides settings
        slidesVisibilities: Animators.createSlidesVisibilityList(flyerModel.slides.length),
        numberOfSlides: flyerModel.slides.length,
        numberOfStrips: flyerModel.slides.length,

        /// current slide settings
        currentPicFit: flyerModel.slides[_initialPage].boxFit,
        initialSlideIndex: _initialPage,
        currentSlideIndex: _initialPage,

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
    @required double flyerSizeFactor,
    @required TinyFlyer tinyFlyer,
    @required Function onMicroFlyerTap,
    @required Function onAnkhTap,
  }){

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);

    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: _flyerZoneWidth,
        flyerZoneHeight: Scale.superFlyerZoneHeight(context, _flyerZoneWidth),
        flyerSizeFactor: flyerSizeFactor,

        /// animation controller
        horizontalController: null,
        verticalController: null,
        infoScrollController: null,

        /// animation functions
        onHorizontalSlideSwipe: null,
        onVerticalPageSwipe: null,
        onVerticalPageBack: null,
        onHeaderTap: onMicroFlyerTap,
        onSlideRightTap: onMicroFlyerTap,
        onSlideLeftTap: onMicroFlyerTap,
        onSwipeFlyer: null,

        /// animation parameters
        slidingDuration: null,
        fadingDuration: null,
        progressBarOpacity: null,
        swipeDirection: null,
        bzPageIsOn: false,
        listenToSwipe: false,

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

        /// editor data
        firstTimer: null,
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

        /// bz data
        bzType: tinyFlyer.tinyBz.bzType,
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
    @required double flyerSizeFactor,
    @required BzModel bzModel,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
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
  }){

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);
    CountryProvider _countryPro = Provider.of<CountryProvider>(context, listen: false);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: _flyerZoneWidth,
        flyerZoneHeight: Scale.superFlyerZoneHeight(context, _flyerZoneWidth),
        flyerSizeFactor: flyerSizeFactor,

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

        /// animation parameters
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,

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

        /// editor data
        firstTimer: true,
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
        flyerID: DraftFlyerModel.draftID,
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
    @required double flyerSizeFactor,
    @required BzModel bzModel,
    @required FlyerModel flyerModel,
    @required Function onHorizontalSlideSwipe,
    @required Function onVerticalPageSwipe,
    @required Function onVerticalPageBack,
    @required Function onHeaderTap,
    @required Function onSlideRightTap,
    @required Function onSlideLeftTap,
    @required Function onSwipeFlyer,
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
  }) async {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, flyerSizeFactor);

    return
      SuperFlyer(
        /// sizes
        flyerZoneWidth: _flyerZoneWidth,
        flyerZoneHeight: Scale.superFlyerZoneHeight(context, _flyerZoneWidth),
        flyerSizeFactor: flyerSizeFactor,

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

        /// animation parameters
        slidingDuration: Ratioz.durationSliding400,
        fadingDuration: Ratioz.durationFading200,
        progressBarOpacity: 1,
        swipeDirection: SwipeDirection.next,
        bzPageIsOn: false,
        listenToSwipe: true,

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

        /// editor data
        firstTimer: false,
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
        currentPicFit: flyerModel.slides[0].boxFit,
        initialSlideIndex: 0,
        currentSlideIndex: 0,

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
        key: ValueKey('${DraftFlyerModel.draftID} : ${bzModel.bzID} : ${bzModel.nanoFlyers.length + 1} : ${superUserID()}'),
        flyerID: DraftFlyerModel.draftID,
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
}

