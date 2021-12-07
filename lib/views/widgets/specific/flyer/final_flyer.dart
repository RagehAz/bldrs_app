import 'dart:io';

import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/animators.dart' as Animators;
import 'package:bldrs/controllers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/controllers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/drafters/tracers.dart' as Tracer;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart' as Standards;
import 'package:bldrs/db/fire/methods/dynamic_links.dart';
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/models/secondary_models/map_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/flyer_maker_screen.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/keywords_picker_screen.dart';
import 'package:bldrs/views/screens/i_flyer/flyer_maker_screen.dart/specs_lists_pickers_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog_buttons.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_text_field.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/dialogs/flyer_type_selector.dart';
import 'package:bldrs/views/widgets/specific/flyer/flyer_methods.dart' as FlyerMethod;
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_pages.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/new_header.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/stats_dialog.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinalFlyer extends StatefulWidget {
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final int initialSlideIndex;
  final Function onSwipeFlyer;
  final bool goesToEditor;
  final bool inEditor; // vs inView
  final BzModel bzModel;
  final String flyerID;
  final Key flyerKey;

  const FinalFlyer({
    @required this.flyerBoxWidth,
    @required this.onSwipeFlyer,
    this.flyerModel,
    this.initialSlideIndex = 0,
    this.goesToEditor = false,
    this.inEditor = false,
    this.bzModel,
    this.flyerID,
    this.flyerKey,
    Key key,
  }) : super(key: key);
      // :
  // assert(isDraft != null),
  // assert(child != null),
  // super(key: key);


  @override
  _FinalFlyerState createState() => _FinalFlyerState();

}

class _FinalFlyerState extends State<FinalFlyer> with AutomaticKeepAliveClientMixin<FinalFlyer>{
  @override
  bool get wantKeepAlive => true;


  SuperFlyer _superFlyer;
  BzModel _bzModel;
  FlyerModel _originalFlyer;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if(mounted){

      if (function == null){
        setState(() {
          _loading = !_loading;
        });
      }

      else {
        setState(() {
          _loading = !_loading;
          function();
        });
      }

    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  FlyersProvider _flyersProvider;
  BzzProvider _bzzProvider;
  ZoneProvider _zoneProvider;
  // KeywordsProvider _keywordsProvider;

  @override
  void initState() {
    super.initState();
    _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    // _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    /// get current bzModel when this flyer goes to editor

    _bzModel = widget.bzModel;
    // print('FINAL FINAL initialized _bzModel as : ${_bzModel.bzID} as bzName : ${_bzModel.bzName}');

    /// initialize initial superFlyer before fetching the actual superFlyer
    _superFlyer = _initializeSuperFlyer();

  }
  // -----------------------------------------------------------------------------
  @override
  void dispose() {
    print('dispose---> final flyer : start');
    MutableSlide.disposeMutableSlidesTextControllers(_superFlyer.mSlides);
    TextChecker.disposeControllerIfPossible(_superFlyer.infoController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.verticalController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.horizontalController);
    Animators.disposeControllerIfPossible(_superFlyer.nav.infoScrollController);

    // FocusScope.of(context).dispose(); // error fash5
    print('dispose---> final flyer : end');
    super.dispose();
  }

// -----------------------------------------------------------------------------

  SharedPreferences _prefs;

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _triggerLoading().then((_) async {

        _prefs = await SharedPreferences.getInstance();

        final dynamic _flyerSource = FlyerMethod.selectFlyerSource(
          flyerID: widget.flyerID,
          flyerModel: widget.flyerModel,
          bzModel: widget.bzModel,
        );

        final FlyerMethod.FlyerMode _flyerMode = FlyerMethod.flyerModeSelector(
          context: context,
          flyerBoxWidth: widget.flyerBoxWidth,
          flyerSource: _flyerSource,
          inEditor: widget.inEditor,
        );

        final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);


        // --------------------------------------------------------------------X

        SuperFlyer _builtSuperFlyer;

        if (_flyerMode == FlyerMethod.FlyerMode.tinyModeByFlyerID){
          final FlyerModel _flyer = await _flyersProvider.fetchFlyerByID(context: context, flyerID: widget.flyerID);
          final BzModel _bz = await _bzzProvider.fetchBzModel(context: context, bzID: _flyer.bzID);
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _flyer.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: _flyer.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromFlyer(
            flyerModel: _flyer,
            bzModel: _bz,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.tinyModeByFlyerModel){
          final BzModel _bz = await _bzzProvider.fetchBzModel(context: context, bzID: widget.flyerModel.bzID);
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: widget.flyerModel.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: widget.flyerModel.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromFlyer(
            flyerModel: widget.flyerModel,
            bzModel: _bz,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.tinyModeByBzModel){
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: widget.bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: widget.bzModel.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromBzModel(
            bzModel: widget.bzModel,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.tinyModeByNull){
          _builtSuperFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: widget.goesToEditor);
        }

        // --------------------------------------------------------------------X

        else if (_flyerMode == FlyerMethod.FlyerMode.bigModeByFlyerID){
          final FlyerModel _flyer = await _flyersProvider.fetchFlyerByID(context: context, flyerID: widget.flyerID);
          final BzModel _bz = await _bzzProvider.fetchBzModel(context: context, bzID: widget.flyerModel.bzID);
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _flyer.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: _flyer.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromFlyer(
            flyerModel: _flyer,
            bzModel: _bz,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
          // await null;
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.bigModeByFlyerModel){
          final BzModel _bz = await _bzzProvider.fetchBzModel(context: context, bzID: widget.flyerModel.bzID);
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bz.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bz.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: widget.flyerModel.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: widget.flyerModel.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromFlyer(
            flyerModel: widget.flyerModel,
            bzModel: _bz,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
          // await null;
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.bigModeByBzModel){

          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: widget.bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: widget.bzModel.zone.cityID);

          _builtSuperFlyer = _getSuperFlyerFromBzModel(
            bzModel: widget.bzModel,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.bigModeByNull){
          _builtSuperFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: widget.goesToEditor);
        }

        // --------------------------------------------------------------------X

        else if (_flyerMode == FlyerMethod.FlyerMode.editorModeByFlyerID){
          _originalFlyer = await _flyersProvider.fetchFlyerByID(context: context, flyerID: widget.flyerID);
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bzModel.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _originalFlyer.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: _originalFlyer.zone.cityID);

          _builtSuperFlyer = await _getDraftSuperFlyerFromFlyer(
            bzModel: _bzModel,
            flyerModel: _originalFlyer,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.editorModeByFlyerModel){
          _originalFlyer = widget.flyerModel;

          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bzModel.zone.cityID);
          final CountryModel _flyerCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: widget.flyerModel.zone.countryID);
          final CityModel _flyerCity = await _zoneProvider.fetchCityByID(context: context, cityID: widget.flyerModel.zone.cityID);

          _builtSuperFlyer = await _getDraftSuperFlyerFromFlyer(
            bzModel: _bzModel,
            flyerModel: widget.flyerModel,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
            flyerCity: _flyerCity,
            flyerCountry: _flyerCountry,
          );
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.editorModeByBzModel){
          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bzModel.zone.cityID);

          _builtSuperFlyer = _getDraftSuperFlyerFromNothing(
            bzModel: _bzModel,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
          );
          // await null;
        }

        else if (_flyerMode == FlyerMethod.FlyerMode.editorModeByNull){

          final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _bzModel.zone.countryID);
          final CityModel _bzCity = await _zoneProvider.fetchCityByID(context: context, cityID: _bzModel.zone.cityID);

          _builtSuperFlyer =  _getDraftSuperFlyerFromNothing(
            bzModel: _bzModel,
            bzCountry: _bzCountry,
            bzCity: _bzCity,
          );
          // await null;
        }

        // --------------------------------------------------------------------X


        // --------------------------------------------------------------------X


        /// X - REBUILD
        _triggerLoading(function: (){
          _superFlyer = _builtSuperFlyer;
        });

      });

    }
    _isInit = false;
  }
// -----------------------------------------------------------------------------
  @override
  void didUpdateWidget(covariant FinalFlyer oldFlyer) {
    if(
    oldFlyer.flyerID != widget.flyerID ||
    oldFlyer.flyerModel != widget.flyerModel ||
    oldFlyer.bzModel != widget.bzModel ||
    oldFlyer.initialSlideIndex != widget.initialSlideIndex
    ){
      setState(() {

      });

      _isInit = true;
      didChangeDependencies();
    }
    super.didUpdateWidget(oldFlyer);
  }
// -----------------------------------------------------------------------------
  /// SUPER FLYER CREATORS

// -----------------------------------------------------o
  SuperFlyer _initializeSuperFlyer(){
    SuperFlyer _superFlyer;

    /// A - by flyerModel

    if (widget.flyerModel != null){
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: widget.goesToEditor); //_getSuperFlyerFromFlyer(flyerModel: widget.flyerModel);
    }

    else if(widget.bzModel != null){
      _superFlyer = _getSuperFlyerFromBzModel(
        bzModel: widget.bzModel,
        bzCountry: null,
        bzCity: null,
      );
    }

    /// A - when only bzModel is provided (empty flyer only with header)
    else if (widget.goesToEditor == true){

      // if (widget.tinyFlyer == null){
      _superFlyer = _getDraftSuperFlyerFromNothing(
        bzModel: _bzModel,
        bzCity: null,
        bzCountry: null,
      );
      // }


    }

    /// A - emptiness
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: widget.goesToEditor);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromFlyer({
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
    @required CountryModel flyerCountry,
    @required CityModel flyerCity,
  })  {
    SuperFlyer _superFlyer;

    if (flyerModel != null){
      _superFlyer = SuperFlyer.createViewSuperFlyerFromFlyerModel(
        context: context,
        flyerModel: flyerModel,
        bzModel: bzModel,
        initialPage: widget.initialSlideIndex,
        onHorizontalSlideSwipe: (int i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (int i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _slideBackToSlidesPage();},
        onHeaderTap: (bool isExpanded) { _onHeaderTap(isExpanded);},
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: (Sliders.SwipeDirection direction) => widget.onSwipeFlyer(direction),
        onTinyFlyerTap: () async {await _openTinyFlyer();},
        onView: (int slideIndex) => _onViewSlide(slideIndex),
        onAnkhTap: () async {await _onAnkhTap();} ,
        onShareTap: _onShareTap,
        onFollowTap: () async { await _onFollowTap();},
        onCallTap: () async { await _onCallTap();},
        onCountersTap: () async { await _onCountersTap();},
        onEditReview: () async {await _onEditReview();},
        onSubmitReview: () async {await _onSubmitReview();},
        onShowReviewOptions: (ReviewModel review) async {await _onShowReviewOptions(review);},
        onSaveInfoScrollOffset: onSaveInfoScrollOffset,
        getInfoScrollOffset: getInfoScrollOffset,
        initialInfoScrollOffset: getInfoScrollOffset(),
        bzCountry: bzCountry,
        bzCity: bzCity,
        flyerCountry: flyerCountry,
        flyerCity: flyerCity,
      );
    }

    /// TASK : below code is temp,,, should see what to do if flyer not found on db
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: false);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  Future <SuperFlyer> _getDraftSuperFlyerFromFlyer({
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
    @required CountryModel flyerCountry,
    @required CityModel flyerCity,
  }) async {
    SuperFlyer _superFlyer;
    if(flyerModel != null && bzModel != null){
      _superFlyer = await SuperFlyer.createDraftSuperFlyerFromFlyer(
        context: context,
        bzModel: bzModel,
        flyerModel: flyerModel,
        onHorizontalSlideSwipe: (int i) => _onHorizontalSlideSwipe(i),
        onVerticalPageSwipe: (int i) => _onVerticalPageSwipe(i),
        onVerticalPageBack: () async {await _slideBackToSlidesPage();},
        onHeaderTap: (bool isExpanded) {_onHeaderTap(isExpanded);},
        onSlideRightTap: _onSlideRightTap,
        onSlideLeftTap: _onSlideLeftTap,
        onSwipeFlyer: (Sliders.SwipeDirection direction) => widget.onSwipeFlyer(direction),
        onTinyFlyerTap: () async {await _openTinyFlyer();},
        onView: (int i) => _onViewSlide(i),
        onAnkhTap: () async {await _onAnkhTap();} ,
        onShareTap: _onShareTap,
        onFollowTap: () async { await _onFollowTap();},
        onCallTap: () async { await _onCallTap();},
        onCountersTap: () async { await _onCountersTap();},
        onAddImages: () => _onAddImages(),
        onDeleteSlide: () async {await _onDeleteSlide();},
        onCropImage: () async {await _onCropImage();},
        onResetImage: () async {await _onResetImage();},
        onFitImage: _onFitImage,
        onFlyerTypeTap: () async {await _onFlyerTypeTap();},
        onZoneTap: () async {await _onChangeZone();},
        onAboutTap: () async {await _onMoreInfoTap();},
        onKeywordsTap: () async {await _onAddKeywords();},
        onSpecsTap: () async {await _onAddSpecs();},
        onShowAuthorTap: _onShowAuthorTap,
        onTriggerEditMode: _onTriggerEditMode,
        onPublishFlyer: () async {await _onPublishFlyer();},
        onDeleteFlyer: () async {await _onDeleteFlyer();},
        onUnPublishFlyer: () async {await _onUnpublishFlyer();},
        onRepublishFlyer: () async {await _onRepublishFlyer();},
        onSaveInfoScrollOffset: onSaveInfoScrollOffset,
        getInfoScrollOffset: getInfoScrollOffset,
        initialInfoScrollOffset: getInfoScrollOffset(),
        bzCountry: bzCountry,
        bzCity: bzCity,
        flyerCountry: flyerCountry,
        flyerCity: flyerCity,
      );

    }
    else {
      _superFlyer = SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: widget.flyerBoxWidth, goesToEditor: widget.goesToEditor);
    }

    return _superFlyer;
  }
// -----------------------------------------------------o
  SuperFlyer _getDraftSuperFlyerFromNothing({
    @required BzModel bzModel,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
  }){
    final SuperFlyer _superFlyer = SuperFlyer.createDraftSuperFlyerFromNothing(
      context: context,
      bzModel: bzModel,
      onHorizontalSlideSwipe: (int i) => _onHorizontalSlideSwipe(i),
      onVerticalPageSwipe: (int i) => _onVerticalPageSwipe(i),
      onVerticalPageBack: () async {await _slideBackToSlidesPage();},
      onHeaderTap: (bool isExpanded) { _onHeaderTap(isExpanded);},
      onSlideRightTap: _onSlideRightTap,
      onSlideLeftTap: _onSlideLeftTap,
      onSwipeFlyer: (Sliders.SwipeDirection direction) => widget.onSwipeFlyer(direction),
      onTinyFlyerTap: () async {await _openTinyFlyer();},
      onView: (int i) => _onViewSlide(i),
      onAnkhTap: () async {await _onAnkhTap();} ,
      onShareTap: _onShareTap,
      onFollowTap: () async { await _onFollowTap();},
      onCallTap: () async { await _onCallTap();},
      onCountersTap: () async { await _onCountersTap();},
      onAddImages: () => _onAddImages(),
      onDeleteSlide: () async {await _onDeleteSlide();},
      onCropImage: () async {await _onCropImage();},
      onResetImage: () async {await _onResetImage();},
      onFitImage: _onFitImage,
      onFlyerTypeTap: () async {await _onFlyerTypeTap();},
      onZoneTap: () async {await _onChangeZone();},
      onAboutTap: () async {await _onMoreInfoTap();},
      onKeywordsTap: () async {await _onAddKeywords();},
      onSpecsTap: () async {await _onAddSpecs();},
      onShowAuthorTap: _onShowAuthorTap,
      onTriggerEditMode: _onTriggerEditMode,
      onPublishFlyer: () async {await _onPublishFlyer();},
      onDeleteFlyer: () async {await _onDeleteFlyer();},
      onUnPublishFlyer: () async {await _onUnpublishFlyer();},
      onRepublishFlyer: () async {await _onRepublishFlyer();},
      onSaveInfoScrollOffset: onSaveInfoScrollOffset,
      getInfoScrollOffset: getInfoScrollOffset,
      initialInfoScrollOffset: getInfoScrollOffset(),
      bzCountry: bzCountry,
      bzCity: bzCity,
      flyerCountry: bzCountry,
      flyerCity: bzCity,
    );

    return _superFlyer;
  }
// -----------------------------------------------------o
//   FlyerModel _createTempEmptyFlyer(){
//
//     AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bzModel, superUserID());
//     TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);
//
//     CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
//
//     return new FlyerModel(
//       flyerID : SuperFlyer.draftID, // no need
//       // -------------------------
//       flyerType : FlyerTypeClass.concludeFlyerType(_bzModel.bzType),
//       flyerState : FlyerState.Draft,
//       keywords : _superFlyer?.keywords,
//       flyerShowsAuthor : true,
//       flyerURL : '...',
//       flyerZone: _countryPro.currentZone,
//       // -------------------------
//       tinyAuthor : _tinyAuthor,
//       tinyBz : TinyBz.getTinyBzFromBzModel(_bzModel),
//       // -------------------------
//       publishTime : DateTime.now(),
//       flyerPosition : null,
//       // -------------------------
//       ankhIsOn : false,
//       // -------------------------
//       slides : [],
//       // -------------------------
//       flyerIsBanned: false,
//       deletionTime: null,
//       info: '',
//       specs: [],
//       // times:
//     );
//   }
// -----------------------------------------------------o
  SuperFlyer _getSuperFlyerFromBzModel({
    @required BzModel bzModel,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
  }){

    final SuperFlyer _superFlyer = SuperFlyer.getSuperFlyerFromBzModelOnly(
      onHeaderTap: _onHeaderTap,
      bzModel: bzModel,
      bzCountry: bzCountry,
      bzCity: bzCity,
    );

    return _superFlyer;
  }
// -----------------------------------------------------------------------------

  ///   NAVIGATION METHODS

  Future <void> _openTinyFlyer() async {

    final FlyerModel _flyer = FlyerModel.getFlyerModelFromSuperFlyer(_superFlyer);
    print('opening tiny flyer : ${_flyer.id} while THE FUCKING widget.goesToEditor IS : ${widget.goesToEditor}');

    await _bzzProvider.setActiveBz(_superFlyer.bz);

    /// opening editor
    if (widget.goesToEditor == true){
      await _goToFlyerEditor(
        context: context,
        firstTimer: _superFlyer.edit.firstTimer,
      );
    }

    /// opening flyer to view
    else {

      await Nav.openFlyer(
          context: context,
          flyer: _flyer,
      );

    }


    // await Navigator.push(context,
    // MaterialPageRoute(builder: (context) => FlyerScreen(
    //   tinyFlyer: _flyer,
    // )
    // )
    // );
    /// TASK : check this and delete when done
    // flyerOnTap: (tinyFlyer) async {
    //
    //
    //   dynamic _rebuild = await Navigator.push(context,
    //       new MaterialPageRoute(
    //           builder: (context) => new BzFlyerScreen(
    //             tinyFlyer: tinyFlyer,
    //             bzModel: _bzModel,
    //           )
    //       ));
    //   if (_rebuild == true){
    //     print('we should rebuild');
    //     setState(() { });
    //   } else if (_rebuild == false){
    //     print('do not rebuild');
    //   } else {
    //     print ('rebuild is null');
    //   }
    //
    // },


    print('WWWWWWWWWWWWWTTTTTTTTTTTFFFFFFFFFFF');
  }
// -----------------------------------------------------o
  void _onFlyerZoneTap(){

    print('aho');

    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    print('Final flyer zone tapped : ${_superFlyer.flyerID} : micro mode is $_tinyMode');

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    if (_tinyMode == true){

      print('tapping tiny flyer aho');
      _openTinyFlyer();

    }

  }
// -----------------------------------------------------o
  void _onFlyerZoneLongPress(){
    print('Final flyer zone long pressed');
  }
// -----------------------------------------------------o
  void _onHeaderTap(bool isExpanded){
    print('_onHeaderTap : bzPageIsOn was : ${_superFlyer.nav.bzPageIsOn}');
      // _superFlyer.nav.bzPageIsOn = !_superFlyer.nav.bzPageIsOn;

    if(_superFlyer.verticalIndex == 0){

      if (_superFlyer.nav.progressBarOpacity == 1){
        setState(() {
          _statelessTriggerProgressOpacity();
          // _superFlyer.nav.bzPageIsOn = isExpanded;
        });
      }
      else {
        Future<void>.delayed(Ratioz.durationFading210, (){
          setState(() {
            _statelessTriggerProgressOpacity();
            // _superFlyer.nav.bzPageIsOn = isExpanded;
          });
        });
      }


    }

    print('_onHeaderTap : bzPageIsOn is : ${_superFlyer.nav.bzPageIsOn}');
  }
// -----------------------------------------------------o
  Future<void> _goToFlyerEditor({BuildContext context, bool firstTimer}) async {

    print('going to flyer editor for flyerID ${_superFlyer.flyerID} as firstTimer is ${firstTimer}');

    await Future<void>.delayed(Ratioz.durationFading200, () async {

      // FlyerModel _flyer = firstTimer == true ? null : widget.flyerModel;

      final dynamic _result = await Nav.goToNewScreen(context,
          new FlyerMakerScreen(
            firstTimer: firstTimer,
            bzModel: _bzModel,
            flyerModel: firstTimer == true ? null : widget.flyerModel,
          )
      );

      if (_result.runtimeType == FlyerModel){
        print('_goToFlyerEditor : adding published flyer model to bzPage screen gallery');
        _updateTinyFlyerInLocalBzTinyFlyers(_result);
      }
      else {
        print('_goToFlyerEditor : did not publish the new draft flyer');
      }

    });
  }
// -----------------------------------------------------------------------------

  /// SLIDING METHODS

  void _onHorizontalSlideSwipe (int newIndex){
    // print('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    final Sliders.SwipeDirection _direction = Animators.getSwipeDirection(newIndex: newIndex, oldIndex: _superFlyer.currentSlideIndex,);

    /// A - if Keyboard is active
    if (Keyboarders.keyboardIsOn(context) == true){
      print('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == Sliders.SwipeDirection.next){
        print('going next');
        FocusScope.of(context).nextFocus();
        setState(() {
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }

      /// B - when direction is going back
      else if (_direction == Sliders.SwipeDirection.back){
        print('going back');
        FocusScope.of(context).previousFocus();
        setState(() {
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }

      /// B = when direction is freezing
      else {
        print('going no where');
        setState(() {
          _superFlyer.nav.swipeDirection = _direction;
          _superFlyer.currentSlideIndex = newIndex;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      // print('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _superFlyer.nav.swipeDirection = _direction;
        _superFlyer.currentSlideIndex = newIndex;
     });

    }


  }
// -----------------------------------------------------o
  void _onSlideRightTap(){
    print('_onSlideRightTap');
  }
// -----------------------------------------------------o
  void _onSlideLeftTap(){
    print('_onSlideLeftTap');
  }
// -----------------------------------------------------o
  void _onVerticalPageSwipe(int verticalIndex){
    print('verticalIndex was : ${_superFlyer.verticalIndex}');
    setState(() {
      _superFlyer.verticalIndex = verticalIndex;
      _statelessTriggerProgressOpacity(verticalIndex: verticalIndex);
    });
    print('verticalIndex is : ${_superFlyer.verticalIndex}');

  }
// -----------------------------------------------------o
  Future<void> _slideBackToSlidesPage() async {
  print('_slideBackToSlidesPage : sliding from info page to slides page aho by tap');
  await Sliders.slideToBackFrom(_superFlyer.nav.verticalController, 1);
}
// -----------------------------------------------------o
  void _statelessTriggerProgressOpacity({int verticalIndex}){

    print('triggering progress bar opacity');

    if (verticalIndex == null){

      if (_superFlyer.nav.progressBarOpacity == 1){
        _superFlyer.nav.progressBarOpacity = 0;
      }

      else {
        _superFlyer.nav.progressBarOpacity = 1;
      }

    }

    else {

      if (verticalIndex == 1){
        _superFlyer.nav.progressBarOpacity = 0;
      }

      else {
        _superFlyer.nav.progressBarOpacity = 1;
      }

    }

  }
// -----------------------------------------------------o
//   Future<void> _triggerKeywordsView() async {
//
//     print('_triggerKeywordsView : _verticalIndex : ${_superFlyer.verticalIndex}');
//
//
//     /// open keywords
//     if(_superFlyer.verticalIndex == 0){
//       await Sliders.slideToNext(_superFlyer.nav.verticalController, 2, 0);
//       // await Sliders.slideToNext(_panelController, 2, 0);
//     }
//     /// close keywords
//     else {
//       await Sliders.slideToBackFrom(_superFlyer.nav.verticalController, 1);
//       // await Sliders.slideToBackFrom(_panelController, 1);
//     }
//
//     setState(() {
//       _statelessTriggerProgressOpacity();
//     });
//
//   }
// -----------------------------------------------------o
//   Future<void> _onSwipeFlyer() async {
//     /// TASK : do some magic
//   }
// -----------------------------------------------------o ////////////////


  final PageStorageBucket flyerBucket = PageStorageBucket();
// -----------------------------------------------------o
  void onSaveInfoScrollOffset(){
    // final String bucketOffsetKey = '${_superFlyer.flyerID}_infoPage_offset';
    // flyerBucket.writeState(context, offset, identifier: ValueKey(bucketOffsetKey));

    final String _prefName = '${_superFlyer.flyerID}_info_scroll_pos';

    final double offset = _superFlyer.nav.infoScrollController.position.pixels;

    _prefs.setDouble(_prefName, offset);


    // print('X-X-X : offset is $offset : for _prefName : $_prefName');
  }
// -----------------------------------------------------o
  double getInfoScrollOffset(){
    // final String bucketOffsetKey = '${_superFlyer.flyerID}_infoPage_offset';
    // double _offset = flyerBucket.readState(context, identifier: ValueKey(bucketOffsetKey)) ?? 0.0;

    final String _prefName = '${_superFlyer?.flyerID}_info_scroll_pos';
    final double _offset = _prefs?.getDouble(_prefName) ?? 0;

    // print('O-O-O : offset is $_offset : for _prefName : $_prefName');

    return _offset;
  }
// -----------------------------------------------------------------------------

  /// RECORD METHODS

  void _onViewSlide(int slideIndex){
    print('viewing slide : ${slideIndex} : from flyer : ${_superFlyer.flyerID}');
  }
// -----------------------------------------------------o
  Future<void> _onAnkhTap() async {
    print('tapping Ankh');

    TopDialog.showTopDialog(
      context: context,
      verse: _superFlyer.rec.ankhIsOn == true ? 'Flyer is unsaved' : 'Flyer saved',
      // secondLine: 'Allows users to follow your account',
      color: _superFlyer.rec.ankhIsOn == true ? Colorz.grey255 : Colorz.yellow255,
    );

    setState(() {
      _superFlyer.rec.ankhIsOn = !_superFlyer.rec.ankhIsOn;
    });


    /// TASK : start save flyer ops
    // await RecordOps.saveFlyerOps(
    //     context: context,
    //     userID: superUserID(),
    //     flyerID: _superFlyer.flyerID,
    //     slideIndex: _superFlyer.currentSlideIndex,
    // );

    final FlyerModel _flyerModel = FlyerModel.getFlyerModelFromSuperFlyer(_superFlyer);

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    /// add or remove tiny flyer in local saved flyersList
    await _flyersProvider.saveOrUnSaveFlyer(
      context: context,
      inputFlyer: _flyerModel,
    );

    print('ankh is ${_superFlyer.rec.ankhIsOn}');

  }
// -----------------------------------------------------o
  Future<void> _onShareTap() async {
    print('Sharing flyer');

    if(widget.inEditor == true){
      await TopDialog.showTopDialog(
        context: context,
        verse: 'Share button',
        secondLine: "Allows users to share this flyer\'s link to other apps",

      );
    }

    else {
      final int _i = _superFlyer.currentSlideIndex;
      final FlyerModel _flyer = FlyerModel.getFlyerModelFromSuperFlyer(_superFlyer);

      final dynamic _dynamicLink = await DynamicLinksApi().createFlyerDynamicLink(
        context: context,
        isShortURL: true,
        flyerModel: _flyer,
        slideIndex: _i,
      );

      /// TASK : adjust link url and description
      final LinkModel _theFlyerLink = LinkModel(
          url: _dynamicLink,
          description: '${_superFlyer.flyerType} flyer .\n'
              '- slide number ${_superFlyer.currentSlideIndex} .\n'
              '- ${_superFlyer.mSlides[_i].headline} .\n'
      );

      /// TASK : START SHARE OPS
      // don't await this method
      // RecordOps.shareFlyerOPs(
      //   context: context,
      //   flyerID: _superFlyer.flyerID,
      //   userID: superUserID(),
      //   slideIndex: _superFlyer.currentSlideIndex,
      // );

      await Launcher.shareFlyer(context, _theFlyerLink);

    }

  }
// -----------------------------------------------------o
  Future <void> _onFollowTap() async {
    // print('Following bz : followIsOn was ${_superFlyer.rec.followIsOn} & headline for slide ${_superFlyer.currentSlideIndex} is : ${_superFlyer.mSlides[_superFlyer.currentSlideIndex].headline}');

    if(widget.inEditor == true){
      await TopDialog.showTopDialog(
        context: context,
        verse: 'Follow button',
        secondLine: 'Allows users to follow your account',
      );
    }

    else {

      /// TASK : start follow bz ops
      // final List<String> _updatedBzFollows = await RecordOps.followBzOPs(
      //   context: context,
      //   bzID: _superFlyer.bz.bzID,
      //   userID: superUserID(),
      // );
      //
      // /// add or remove tinyBz from local followed bzz
      // _prof.updatedFollowsInLocalList(_updatedBzFollows);

      /// trigger current follow value
      setState(() {
        _superFlyer.rec.followIsOn = !_superFlyer.rec.followIsOn;
      });

    }

  }
// -----------------------------------------------------o
  Future<void> _onCallTap() async {
    print('Call Bz');

    if(widget.inEditor == true){
      await TopDialog.showTopDialog(
        context: context,
        verse: 'Call button',
        secondLine: 'Allows users to call you directly',

      );
    }

    else {

      // final String _userID = superUserID();
      // final String _bzID = _superFlyer.bz.bzID;
      final String _contact = ContactModel.getAContactValueFromContacts(_superFlyer.bz.contacts, ContactType.email);

      /// alert user there is no contact to call
      if (_contact == null){
        print('no contact here');
      }

      /// or launch call and start call bz ops
      else {

        /// launch call
        await Launcher.launchCall('tel: $_contact');

        /// TASK : start call bz ops
        // await RecordOps.callBzOPs(
        //   context: context,
        //   bzID: _bzID,
        //   userID: _userID,
        //   slideIndex: _superFlyer.currentSlideIndex,
        // );

      }

    }



  }
// -----------------------------------------------------o
  Future<void> _onCountersTap() async {

    print('tapping slide counter');

    if(_superFlyer.edit.firstTimer == true){
      await TopDialog.showTopDialog(
        context: context,
        verse: 'Flyer stats',
        secondLine: "These count the flyer\'s counts of shares, views & saves",
      );
    }

    else {

      await FlyerStatsDialog.show(
        context: context,
        flyerID: _superFlyer.flyerID,
      );

    }

  }
// -----------------------------------------------------o
  Future<void> _onEditReview({ReviewModel review}) async {

    /// existing review
    String _existingReview = review?.body;

    /// assign review controller
    if (review != null){
      _superFlyer.rec.reviewController.text = review.body;
    }

    final double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.8);
    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    final double _dialogInnerCorners = BottomDialog.dialogClearCornerValue();

    bool _canUploadReview = false;

    await BottomDialog.showStatefulBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      title: 'Add your review on this flyer',
      builder: (BuildContext ctx, String title){

        return
          StatefulBuilder(
            builder: (BuildContext xxx, void Function(void Function()) setDialogState){

              return
                BottomDialog(
                  title: title,
                  height: _dialogHeight,
                  child: Column(
                    children: <Widget>[

                      /// REVIEW TEXT FIELD
                      SizedBox(
                        width: _dialogClearWidth,
                        child: SuperTextField(
                          autofocus: true,
                          // onChanged: textFieldOnChanged,
                          width: _dialogClearWidth,
                          fieldColor: Colorz.white20,
                          corners: _dialogInnerCorners,
                          // margin: EdgeInsets.only(top: (_dialogClearWidth * 0.3), left: 5, right: 5),
                          maxLines: 10,
                          minLines: 3,
                          maxLength: 500,
                          textController: _superFlyer.rec.reviewController,
                          inputWeight: VerseWeight.thin,
                          onChanged: (String val){

                            final bool _reviewControllerHasValue = TextChecker.textControllerIsEmpty(_superFlyer.rec.reviewController) == false;

                            print('_existingReview : $_existingReview');
                            print('_reviewControllerHasValue : $_reviewControllerHasValue');
                            print('_superFlyer.rec.reviewController.text : ${_superFlyer.rec.reviewController.text}');
                            // print('val : $val');
                            print('_canUploadReview : $_canUploadReview');

                            if (_reviewControllerHasValue == true){
                              if (_superFlyer.rec.reviewController.text != _existingReview){
                                setDialogState((){
                                  _canUploadReview = true;
                                });

                              }
                            }
                            else if (_canUploadReview == true){
                              setDialogState((){
                                _canUploadReview = false;
                              });
                            }

                          },
                          onSubmitted: (String val){
                            print('val is : $val');
                          },
                          keyboardTextInputType: TextInputType.multiline,
                          keyboardTextInputAction: TextInputAction.newline,
                        ),
                      ),

                      Container(
                        width: _dialogClearWidth,
                        height: 40,
                        margin: const EdgeInsets.only(top: Ratioz.appBarPadding),
                        alignment: Aligners.superInverseCenterAlignment(context),
                        child: DreamBox(
                          height: 40,
                          verse: _existingReview == null ? 'Add Review' : 'Edit Review',
                          verseScaleFactor: 0.6,
                          color: Colorz.yellow255,
                          verseColor: Colorz.black255,
                          verseShadow: false,
                          inActiveMode: !_canUploadReview,
                          onTap: () async {

                            Keyboarders.minimizeKeyboardOnTapOutSide(context);

                            await _onSubmitReview(
                              review: ReviewModel(
                                body: _superFlyer.rec.reviewController.text, time: DateTime.now(),
                                userID: FireAuthOps.superUserID(),
                                reviewID: review?.reviewID,
                              ),
                            );

                            if (_existingReview != null){
                              setState(() {
                                _superFlyer.rec.reviewController.clear();
                                _existingReview = null;
                              });

                              Nav.goBack(context);
                              // await null;

                            }

                            Nav.goBack(context);
                            // await null;

                          },
                        ),
                      ),

                    ],
                  ),
                );

            },
          );

      },
    );

  }
// -----------------------------------------------------o
  Future<void> _onShowReviewOptions(ReviewModel review) async {

    final double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    const int _numberOfButtons = 2;
    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    final double _dialogClearHeight = BottomDialog.dialogClearHeight(context: context, overridingDialogHeight: _dialogHeight, titleIsOn: true, draggable: true);
    const double _spacing = Ratioz.appBarMargin;
    final double _buttonWidth = (_dialogClearWidth - ((_numberOfButtons + 1) * _spacing) ) / _numberOfButtons;

    const Color _buttonColor = Colorz.white20;
    // const Color _verseColor = Colorz.white255;

    await BottomDialog.showBottomDialog(
      context: context,
      height: _dialogHeight,
      draggable: true,
      title: 'Review options',
      child: SizedBox(
        width: _dialogClearWidth,
        height: _dialogClearHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            DreamBox(
              height: 60,
              width: _buttonWidth,
              verse: 'Delete review',
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              color: _buttonColor,
              onTap: () => _deleteReview(review.reviewID),
            ),

            DreamBox(
              height: 60,
              width: _buttonWidth,
              verse: 'Edit review',
              verseMaxLines: 2,
              verseScaleFactor: 0.7,
              color: _buttonColor,
              onTap:  () => _onEditReview(review: review),
            ),

          ],
        ),
      ),
    );


  }
// -----------------------------------------------------o
  Future<void> _onSubmitReview({ReviewModel review}) async {

    print('review text is : ${review.body}');

    if (TextChecker.textControllerIsEmpty(_superFlyer.rec.reviewController) == true){
      await NavDialog.showNavDialog(
        context: context,
        firstLine: 'Review is Empty',
        secondLine: 'Add Your review before adding it',
      );
    }

    else {

      final ReviewModel _review =
          review ??
          ReviewModel(
        body: _superFlyer.rec.reviewController.text,
        userID: FireAuthOps.superUserID(),
        time: DateTime.now(),
      );

      await Fire.updateSubDoc(
        context: context,
        collName: FireColl.flyers,
        docName: _superFlyer.flyerID,
        subCollName: FireSubColl.flyers_flyer_reviews,
        subDocName: review.reviewID,
        input: _review.toMap(),
      );

      setState(() {
        _superFlyer.rec.reviewController.clear();
      });

      // await CenterDialog.superDialog(
      //   context: context,
      //   title: 'Review Added',
      //   body: 'review added',
      //   boolDialog: false,
      // );

    }
  }
// -----------------------------------------------------o
  Future<void> _deleteReview(String reviewID) async {

    Nav.goBack(context);
    // await null;

    await Fire.deleteSubDoc(
      context: context,
      collName: FireColl.flyers,
      docName: _superFlyer.flyerID,
      subCollName: FireSubColl.flyers_flyer_reviews,
      subDocName: reviewID,
    );

    await NavDialog.showNavDialog(
      context: context,
      firstLine: 'Review Deleted',
    );


  }

// -----------------------------------------------------------------------------

  /// EDITOR METHOD

// -----------------------------------------------------o
  Future<void> _onTriggerEditMode() async {

    /// to  update slides headlines
    // List<SlideModel> _updatedSlides = await _createSlidesModelsFromCurrentSuperFlyer();
    // List<MutableSlide> _updatedMutableSlides = MutableSlide.getDraftMutableSlidesFromSlidesModels(_updatedSlides);
    setState(() {
      _superFlyer.edit.editMode = !_superFlyer.edit.editMode;
      _superFlyer.flyerInfo = _superFlyer.infoController.text;
      // _superFlyer.mutableSlides = _updatedMutableSlides;
    });
  }
// -----------------------------------------------------o
  void _onShowAuthorTap(){

    print('triggering showing author : as _superFlyer is : ${_superFlyer.flyerID} \n and superFlyer.flyerShowsAuthor is : ${_superFlyer.flyerShowsAuthor}');

    setState(() {
      _superFlyer.flyerShowsAuthor = !_superFlyer.flyerShowsAuthor;
    });
  }
// -----------------------------------------------------o
  Future<void> _onAddImages() async {

    if (mounted){

      /// TASK : figure this out ( and study shared preferences )
      // final Directory appDir = await sysPaths.getApplicationDocumentsDirectory();
      // final String fileName = path.basename(_imageFile.path);
      // final File savedImage = await _storedImage.copy('${appDir.path}/$fileName');

      FocusScope.of(context).unfocus();

      _triggerLoading();


      /// A - if max slides reached
      if(FlyerMethod.maxSlidesReached(superFlyer: _superFlyer) == true){

        final int _maxLength = Standards.getMaxSlidesCount(_superFlyer.bz.accountType);
        await Dialogz.maxSlidesReached(context, _maxLength);

      }

      /// A - if can pick more gallery pictures
      else {

        /// B1 - get assets from mutable slides
        final List<Asset> _assetsSources = MutableSlide.getAssetsFromMutableSlides(_superFlyer.mSlides); //Imagers.getOnlyAssetsFromDynamics(_superFlyer.assetsSources);
        /// B2 - assert that index in never null
        _superFlyer.currentSlideIndex = FlyerMethod.unNullIndexIfNull(_superFlyer.currentSlideIndex);

        /// B3 - pick images from gallery
        final List<dynamic> _phoneAssets = await Imagers.takeGalleryMultiPictures(
          context: context,
          images: _assetsSources,
          mounted: mounted,
          accountType: _superFlyer.bz.accountType,
        );

        /// B4 - if did not pick new assets
        if(_phoneAssets.isEmpty){
          // will do nothing
          print('no new picks');
        }

        /// B4 - if picked new assets
        else {
          print('picked new picks');

          /// C1 - declare private existing and new mutable slides
          final List<MutableSlide> _tempMutableSlides = _superFlyer.mSlides;


          /// C2 - for every asset received from gallery
          for (int i = 0; i < _phoneAssets.length; i++){

            /// D1 - declare private asset
            final Asset _newAsset = _phoneAssets[i];

            /// D2 - search index of _newAsset in the existing asset if possible
            final int _assetIndexInAssets =  MutableSlide.getMutableSlideIndexThatContainsThisAsset(
              mSlides: _tempMutableSlides,
              assetToSearchFor: _newAsset,
            );

            bool _assetFound;
            if (_assetIndexInAssets == -1){
              _assetFound = false;
            }
            else {
              _assetFound = true;
            }

            if (_assetFound){
              // nothing shall be added to the existing mutable slides
              // _tempMutableSlides.add(_existingMutableSlides[i]);
            }

            else {
              final File _newFile = await Imagers.getFileFromPickerAsset(_newAsset);

              final MutableSlide _mutableSlide = MutableSlide(
                slideIndex: i,
                opacity: 1,
                picAsset: _newAsset,
                picFile: _newFile,
                imageSize: await ImageSize.superImageSize(_newAsset),
                picFit: Imagers.concludeBoxFitForAsset(asset: _newAsset, flyerBoxWidth: widget.flyerBoxWidth),
                midColor: await Colorizer.getAverageColor(_newFile),
                headline: null,
                headlineController: new TextEditingController(),
                descriptionController: new TextEditingController(),
                viewsCount: 0,
                sharesCount: 0,
                savesCount: 0,
              );

              _tempMutableSlides.add(_mutableSlide);
            }

          }

          /// D - assign all new values
          setState(() {
            _superFlyer.mSlides = _tempMutableSlides;
            _superFlyer.numberOfSlides = _tempMutableSlides.length;
            _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
            _superFlyer.nav.progressBarOpacity = 1;
          });
          Tracer.traceSetState(screenName: 'FinalFlyer', varName: 'numberOfSlides', varNewValue: _superFlyer.mSlides.length);

          /// C - animate to last slide
          await Sliders.slideTo(
            controller: _superFlyer.nav.horizontalController,
            toIndex: _superFlyer.numberOfSlides - 1,
          );

        }

      }

      await _triggerLoading();

    }

  }
// -----------------------------------------------------o
  Future<void> _onDeleteSlide() async {

    /// A - if slides are empty
    if (_superFlyer.numberOfSlides == 0 || _superFlyer.edit.canDelete == false){
      print('FinalFlyer : _onDeleteSlide : Can not delete slide : ${_superFlyer.currentSlideIndex}');
    }


    /// A - if slides are not empty
    else {

      _superFlyer.edit.canDelete = false;

      /// B - if at (FIRST) slide
      if (_superFlyer.currentSlideIndex == 0){
        await _deleteFirstSlide();
      }

      /// B - if at (LAST) slide
      else if (_superFlyer.currentSlideIndex + 1 == _superFlyer.numberOfSlides){
        await _deleteMiddleOrLastSlide();
      }

      /// B - if at (Middle) slide
      else {
        await _deleteMiddleOrLastSlide();
      }

      _superFlyer.edit.canDelete = true;

    }

  }
// -----------------------------------------------------o
  Future<void> _deleteFirstSlide() async {
    print('DELETING STARTS AT (FIRST) index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides} ------------------------------------');

    /// 1 - if only one slide remaining
    if(_superFlyer.numberOfSlides == 1){

      print('_draft.visibilities : ${_superFlyer.mSlides[_superFlyer.currentSlideIndex].toString()}, _draft.numberOfSlides : $_superFlyer.numberOfSlides');

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = 0;
        _statelessTriggerProgressOpacity();
      });

      /// B - wait fading to start deleting + update index to null
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data
        setState(() {
          _statelessSlideDelete(_superFlyer.currentSlideIndex);
          _superFlyer.currentSlideIndex = null;
        });

      });

    }

    /// 2 - if two slides remaining
    else if(_superFlyer.numberOfSlides == 2){

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _superFlyer.nav.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await Sliders.slideToNext(_superFlyer.nav.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);


        /// D - delete when one slide remaining
        /// E - wait for sliding to end
        await Future<void>.delayed(Ratioz.durationFading210, () async {


          // /// F - snap to index 0
          // await Sliders.snapTo(_pageController, 0);
          //
          // print('now i can swipe again');
          //
          // /// G - trigger progress bar listener (onPageChangedIsOn)
          setState(() {
            /// Dx - delete data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            _superFlyer.currentSlideIndex = 0;
            // _draft.numberOfSlides = 1;
            _superFlyer.nav.listenToSwipe = true;
          });

        });


      });
    }

    /// 2 - if more than two slides
    else {

      final int _originalNumberOfSlides = _superFlyer.numberOfSlides;
      final int _decreasedNumberOfSlides =  _superFlyer.numberOfSlides - 1;
      // int _originalIndex = 0;
      // int _decreasedIndex = 0;

      /// A - decrease progress bar and trigger visibility
      setState(() {
        _superFlyer.nav.listenToSwipe = false;
        _statelessTriggerSlideVisibility(_superFlyer.currentSlideIndex);
        _superFlyer.numberOfSlides = _decreasedNumberOfSlides;
        _superFlyer.numberOfStrips = _superFlyer.numberOfSlides;
        // _slidingNext = true;
      });

      /// B - wait fading to start sliding
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// C - slide
        await  Sliders.slideToNext(_superFlyer.nav.horizontalController, _superFlyer.numberOfSlides, _superFlyer.currentSlideIndex);

        /// D - delete when one slide remaining
        if(_originalNumberOfSlides <= 1){

          setState(() {
            /// Dx - delte data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            _superFlyer.nav.listenToSwipe = true;
          });

        }

        /// D - delete when at many slides remaining
        else {

          /// E - wait for sliding to end
          await Future<void>.delayed(Ratioz.durationFading210, () async {

            /// Dx - delete data
            _statelessSlideDelete(_superFlyer.currentSlideIndex);
            /// F - snap to index 0
            Sliders.snapTo(_superFlyer.nav.horizontalController, 0);
            // await null;

            print('now i can swipe again');

            /// G - trigger progress bar listener (onPageChangedIsOn)
            setState(() {
              _superFlyer.nav.listenToSwipe = true;
            });

          });

        }

      });

    }

    print('DELETING ENDS AT (FIRST) : index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides} ------------------------------------');
  }
// -----------------------------------------------------o
  Future<void> _deleteMiddleOrLastSlide() async {
    print('XXXXX ----- DELETING STARTS AT (MIDDLE) index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides}');

    final int _originalIndex = _superFlyer.currentSlideIndex;

    /// A - decrease progress bar and trigger visibility
    setState(() {
      _superFlyer.nav.listenToSwipe = false;
      _superFlyer.currentSlideIndex = _superFlyer.currentSlideIndex - 1;
      _superFlyer.nav.swipeDirection = Sliders.SwipeDirection.freeze;
      _superFlyer.numberOfStrips = _superFlyer.numberOfSlides - 1;
      _statelessTriggerSlideVisibility(_originalIndex);
    });

    // print('XXX after first rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    /// B - wait fading to start sliding
    await Future<void>.delayed(Ratioz.durationFading210, () async {

      // print('_currentIndex before slide : $_draft.currentSlideIndex');

      /// C - slide
      await  Sliders.slideToBackFrom(_superFlyer.nav.horizontalController, _originalIndex);
      // print('_currentIndex after slide : $_draft.currentSlideIndex');

      /// E - wait for sliding to end
      await Future<void>.delayed(Ratioz.durationFading210, () async {

        /// Dx - delete data & trigger progress bar listener (onPageChangedIsOn)
        setState(() {
          _statelessSlideDelete(_originalIndex);
          _superFlyer.nav.listenToSwipe = true;
        });

        // print('XXX after second rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

      });

      // print('XXX after third LAST rebuild AT (MIDDLE) index : $_draft.currentSlideIndex, numberOfSlides : $_draft.numberOfSlides');

    });

    print('XXXXX -------  DELETING ENDS AT (MIDDLE) : index : ${_superFlyer.currentSlideIndex}, numberOfSlides : ${_superFlyer.numberOfSlides}');
  }
// -----------------------------------------------------o
  void _statelessTriggerSlideVisibility(int index) {

    if (index != null){
      if(index >= 0 && _superFlyer.mSlides.isNotEmpty){
        print('_superFlyer.mSlides[index].isVisible was ${_superFlyer.mSlides[index].opacity} for index : $index');


        if(_superFlyer.mSlides[index].opacity == 1){
          _superFlyer.mSlides[index].opacity = 0;
        }
        else {
          _superFlyer.mSlides[index].opacity = 1;
        }

        print('_superFlyer.mSlides[index].isVisible is ${_superFlyer.mSlides[index].opacity} for index : $index');
      }
      else {
        print('can not trigger visibility for index : $index');
      }
    }

  }
// -----------------------------------------------------o
  void _statelessSlideDelete(int index) {

    print('before stateless delete index was $index, _draft.numberOfSlides was : ${_superFlyer.numberOfSlides}');
    // if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.assetsFiles.removeAt(index);}
    // if(ObjectChecker.listCanBeUsed(_superFlyer.assetsFiles) == true){_superFlyer.mutableSlides.removeAt(index);}


    // if(_superFlyer.edit.firstTimer == false){
    //   int _assetIndex = MutableSlide.getAssetTrueIndexFromMutableSlides(mutableSlides: _superFlyer.mutableSlides, slideIndex: index);
    //   if(_assetIndex != null){
    //     _superFlyer.assetsSources.removeAt(_assetIndex);
    //   }
    // }
    // else {
    //   _superFlyer.assetsSources.removeAt(index);
    // }

    _superFlyer.mSlides.removeAt(index);
    // _superFlyer.screenshotsControllers.removeAt(index);
    _superFlyer.numberOfSlides = _superFlyer.mSlides.length;
    // _superFlyer.screenShots.removeAt(index);

    print('after stateless delete index is $index, _draft.numberOfSlides is : ${_superFlyer.numberOfSlides}');
  }
// -----------------------------------------------------o
  Future<void> _onCropImage() async {

    if(_superFlyer.mSlides.isNotEmpty){

      _triggerLoading();

      final File croppedFile = await Imagers.cropImage(
          context: context,
          file: _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile
      );

      if (croppedFile != null) {
        setState(() {
          _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile = croppedFile;
        });
      }

      _triggerLoading();

    }

  }
// -----------------------------------------------------o
  Future<void> _onResetImage() async {

    if(_superFlyer.mSlides.isNotEmpty){

      if(_superFlyer.mSlides[_superFlyer.currentSlideIndex].picAsset != null){
        final File _file = await Imagers.getFileFromPickerAsset(_superFlyer.mSlides[_superFlyer.currentSlideIndex].picAsset);

        setState(() {
          _superFlyer.mSlides[_superFlyer.currentSlideIndex].picFile = _file;
        });
      }

    }

  }
// -----------------------------------------------------o
  void _onFitImage(){

    final int _i = _superFlyer.currentSlideIndex;
    final BoxFit _currentPicFit = _superFlyer.mSlides[_i].picFit;

    print('tapping on fit image : ${_superFlyer.mSlides.length} mSlides and _currentPicFit was : $_currentPicFit');

    if(_superFlyer.mSlides.isNotEmpty){

      if(_currentPicFit == BoxFit.fitWidth) {
        print('trying to get fit width to fit height');
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitHeight;
        });
      }

      else if (_currentPicFit == BoxFit.fitHeight){
        print('trying to get fit height to fit width');
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitWidth;
        });
      }

      else {
        setState(() {
          _superFlyer.mSlides[_i].picFit = BoxFit.fitHeight;
        });
      }

    }

    print('tapping on fit image : ${_superFlyer.mSlides.length} mSlides and _currentPicFit is : $_currentPicFit');

  }
// -----------------------------------------------------o
  Future<void> _onFlyerTypeTap() async {

    final double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.25);

    await BottomDialog.showBottomDialog(
      context: context,
      title: 'Select Flyer Type',
      height: _dialogHeight,
      draggable: true,
      child: FlyerTypeSelector(
        superFlyer: _superFlyer,
        onChangeFlyerType: (FlyerTypeClass.FlyerType flyerType){

          setState(() {
            _superFlyer.flyerType = flyerType;
          });

        },
      ),
    );
  }
// -----------------------------------------------------o
  Future<void> _onChangeZone() async {

    final ZoneModel _zone = _superFlyer.zone;

    final List<MapModel> _countriesMapModels = CountryModel.getAllCountriesNamesMapModels(context);
    CountryModel _country = await _zoneProvider.fetchCountryByID(context: context, countryID: _zone.countryID);

    List<CityModel> _cities = await _zoneProvider.fetchCitiesByIDs(context: context, citiesIDs: _country.citiesIDs);
    List<MapModel> _citiesMaps = CityModel.getCitiesNamesMapModels(context: context, cities: _cities);

    final CityModel _city = CityModel.getCityFromCities(cities: _cities, cityID: _zone.cityID);
    List<DistrictModel> _districts = _city.districts;
    List<MapModel> _districtsMaps = DistrictModel.getDistrictsNamesMapModels(context: context, districts: _districts);

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    bool _openNextDialog = false;

    /// COUNTRY DIALOG
    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      title: 'Publish this flyer targeting a specific city',
      child: BottomDialogButtons(
        mapsModels: _countriesMapModels,
        alignment: Alignment.center,
        buttonTap: (String countryID) async {

          final String _lastCountryID = _superFlyer.zone.countryID;

          final CountryModel _selectedCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: countryID);
          final List<CityModel> _selectedCountryCities = await _zoneProvider.fetchCitiesByIDs(context: context, citiesIDs: _selectedCountry.citiesIDs);

          setState(() {
            _superFlyer.zone.countryID = countryID;
            _superFlyer.zone.cityID = null;
            _superFlyer.zone.districtID = null;

            _country = _selectedCountry;

            _cities = _selectedCountryCities;
            _citiesMaps = CityModel.getCitiesNamesMapModels(context: context, cities: _selectedCountryCities);

            _districts = <DistrictModel>[];
            _districtsMaps = <MapModel>[];

            _openNextDialog = true;
          });

          /// if changed country, reset city & district
          if (_lastCountryID != countryID){
            setState(() {
              _superFlyer.zone.cityID = null;
              _superFlyer.zone.districtID = null;
            });
          }

          Nav.goBack(context);
          // await null;

        },
      ),
    );

    /// CITY DIALOG
    if(_openNextDialog == true) {
      _openNextDialog = false;
      await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        title: '${CountryModel.getTranslatedCountryNameByID(context: context, countryID: _superFlyer.zone.countryID)} Cities',
        child: BottomDialogButtons(
          mapsModels: _citiesMaps,
          alignment: Alignment.center,
          bottomDialogType: BottomDialogType.cities,
          buttonTap: (String cityID) async {

            final String _lastCityID = _superFlyer.zone.cityID;
            final CityModel _city = await _zoneProvider.fetchCityByID(context: context, cityID: cityID);

            setState(() {
              _superFlyer.zone.cityID = cityID;

              _districts = _city.districts;
              _districtsMaps = DistrictModel.getDistrictsNamesMapModels(context: context, districts: _districts);

              _openNextDialog = true;
            });

            /// if city changed, reset district
            if (_lastCityID != cityID){
              setState(() {
                _superFlyer.zone.districtID = null;
              });
            }

            Nav.goBack(context);
            // await null;
          },
        ),
      );
    }

    /// DISTRICT DIALOG
    if(_openNextDialog == true) {
      await BottomDialog.showBottomDialog(
        context: context,
        draggable: true,
        title: '${CityModel.getTranslatedCityNameFromCity(context: context, city: _city,)} Districts',
        child: BottomDialogButtons(
          mapsModels: _districtsMaps,
          alignment: Alignment.center,
          bottomDialogType: BottomDialogType.districts,
          buttonTap: (String districtID){

            setState(() {
              _superFlyer.zone.districtID = districtID;
            });

            Nav.goBack(context);
            // await null;
          },
        ),
      );
    }

  }
// -----------------------------------------------------o
  Future<void> _onMoreInfoTap() async {

    final double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.95);
    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    final double _dialogInnerCorners = BottomDialog.dialogClearCornerValue();

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      title: 'Add more info to your flyer',
      child: Column(
        children: <Widget>[

          /// TEXT FIELD
          SizedBox(
            width: _dialogClearWidth,
            child: SuperTextField(
              // autofocus: autoFocus,
              // onChanged: textFieldOnChanged,
              width: _dialogClearWidth,
              fieldColor: Colorz.white20,
              corners: _dialogInnerCorners,
              // margin: EdgeInsets.only(top: (_dialogClearWidth * 0.3), left: 5, right: 5),
              maxLines: 10,
              minLines: 5,
              maxLength: 500,
              textController: _superFlyer.infoController,
              inputWeight: VerseWeight.thin,

              onSubmitted: (String val){
                print('val is : $val');
              },
              keyboardTextInputType: TextInputType.multiline,
              keyboardTextInputAction: TextInputAction.newline,
            ),
          ),

        ],
      ),
    );

  }
// -----------------------------------------------------o
  Future<void> _onAddKeywords() async {

    final dynamic _result = await Nav.goToNewScreen(context,
        SelectKeywordsScreen(
          selectedKeywords: _superFlyer.keywords,
          flyerType: _superFlyer.flyerType,
        )
    );

    /// when user selected some keywords
    if (_result != null){
      setState(() {
        _superFlyer.keywords = _result;
      });
    }

    /// when no keywords selected
    else {

    }

    // List<Keyword> _keywords = <Keyword>[
    //   Keyword.bldrsKeywords()[100],
    //   Keyword.bldrsKeywords()[120],
    //   Keyword.bldrsKeywords()[205],
    //   Keyword.bldrsKeywords()[403],
    //   Keyword.bldrsKeywords()[600],
    // ];
    //
    // double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.7);
    // double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    // double _dialogClearHeight = BottomDialog.dialogClearHeight(context: context, title: 'x', overridingDialogHeight: _dialogHeight);
    //
    // await BottomDialog.slideStatefulBottomDialog(
    //     context: context,
    //     draggable: true,
    //     height: _dialogHeight,
    //     title: 'Select flyer tags',
    //     builder: (context, title) {
    //       return StatefulBuilder(
    //           builder: (BuildContext context, StateSetter setDialogState) {
    //             return
    //               BottomDialog(
    //                 title: title,
    //                 height: _dialogHeight,
    //                 draggable: true,
    //                 child: Container(
    //                   width: _dialogClearWidth,
    //                   height: _dialogClearHeight,
    //                   color: Colorz.BloodTest,
    //                   child: Column(
    //                     children: <Widget>[
    //
    //                       Container(
    //                         width: _dialogClearWidth * 0.9,
    //                         height: 100,
    //                         color: Colorz.Yellow200,
    //                       ),
    //
    //                       Container(
    //                         width: _dialogClearWidth * 0.9,
    //                         height: _dialogClearHeight - 100,
    //                         color: Colorz.BlackSemi255,
    //                         child: ListView.builder(
    //                           itemCount: 3,
    //                             itemBuilder: (BuildContext ctx, int index){
    //                               return
    //                                 BldrsExpansionTile(
    //                                   height: _dialogClearHeight * 0.7,
    //                                   tileWidth: _dialogClearWidth * 0.9,
    //                                   key: new GlobalKey(),
    //                                   // icon: KeywordModel.getImagePath(_filterID),
    //                                   iconSizeFactor: 0.5,
    //                                   group: Group.architecturalStylesGroup,
    //                                   selectedKeywords: _superFlyer.keywords,
    //                                   onKeywordTap: (Keyword selectedKeyword){
    //                                     if (_superFlyer.keywords.contains(selectedKeyword)){
    //                                       setDialogState(() {
    //                                         print('a77a');
    //                                         _superFlyer.keywords.remove(selectedKeyword);
    //                                       });
    //                                     }
    //                                     else {
    //                                       setDialogState(() {
    //                                         _superFlyer.keywords.add(selectedKeyword);
    //                                       });
    //                                     }
    //                                     },
    //                                   onGroupTap: (String groupID){
    //                                     },
    //                                 );
    //                             }
    //                             ),
    //                       ),
    //                     ],
    //                 ),
    //               ),
    //
    //
    //
    //               );
    //           }
    //       );
    //     }
    // );
  }

  Future<void> _onAddSpecs() async {

    final dynamic _result = await Nav.goToNewScreen(context,

      SpecsListsPickersScreen(
        flyerType:  _superFlyer.flyerType,
        selectedSpecs: _superFlyer.specs,
      )

    );

    /// when user selected some keywords
    if (_result != null){
      setState(() {
        _superFlyer.specs = _result;
      });
    }


  }
// -----------------------------------------------------o
//   Future<void>_selectOnMap() async {
//
//     if (_superFlyer.mSlides.length == 0){
//
//       await superDialog(
//         context: context,
//         title: '',
//         body: 'Map Slide Can not be The First Slide',
//         boolDialog: false,
//       );
//
//     } else {
//       final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
//           MaterialPageRoute(
//               builder: (ctx) =>
//                   GoogleMapScreen(
//                     isSelecting: true,
//                     flyerBoxWidth: Scale.superflyerBoxWidth(context, 0.8),
//                   )
//           )
//       );
//       if (selectedLocation == null) {
//         return;
//       }
//       _showMapPreview(selectedLocation.latitude, selectedLocation.longitude);
//       _newLocationSlide();
//       print("${selectedLocation.latitude},${selectedLocation.longitude}");
//     }
//   }
// -----------------------------------------------------o
//   void _showMapPreview(double lat, double lng) {
//     final staticMapImageUrl = getStaticMapImage(context, lat, lng);
//     setState(() {
//       // _mapImageURL = staticMapImageUrl;
//       // _superFlyer.position = GeoPoint(lat, lng);
//     });
//
//     /// TASK : when adding map slide,, should add empty values in _draft.assetsFiles & _assets ... etc
//   }
// -----------------------------------------------------o
//   Future<void> _newLocationSlide() async {
//
//     /// TASK : REVISION REQUIRED
//     // if (_currentSlides.length == 0){
//     //
//     //   await superDialog(
//     //     context: context,
//     //     title: '',
//     //     body: 'Add at least one Picture Slide First',
//     //     boolDialog: false,
//     //   );
//     //
//     //
//     // } else if (_currentFlyerPosition == null){
//     //
//     //   setState(() {
//     //     _currentSlides.add(
//     //         SlideModel(
//     //           slideIndex: _currentSlides.length,
//     //           picture: _draft.mapImageURL,
//     //           headline: _titleControllers[_currentSlides.length].text,
//     //         ));
//     //     _draft.currentSlideIndex = _currentSlides.length - 1;
//     //     _draft.numberOfSlides = _currentSlides.length;
//     //     _draft.visibilities.add(true);
//     //     // slidesModes.add(SlideMode.Map);
//     //     _titleControllers.add(TextEditingController());
//     //     onPageChangedIsOn = true;
//     //   });
//     //   Sliders.slideTo(_pageController, _draft.currentSlideIndex);
//     //
//     // } else {
//     //
//     // }
//
//   }
// -----------------------------------------------------o
  void _updateTinyFlyerInLocalBzTinyFlyers(FlyerModel flyerModel){
    // _prof.update(modifiedTinyFlyer);
    print(' should update tiny flyer in current bz tiny flyers shof enta ezay');
  }

  // void _onReorderSlides(){
  //   /// check this package
  //   // https://pub.dev/packages/reorderables
  // }
// -----------------------------------------------------------------------------

  /// CREATION METHODS

// -----------------------------------------------------o
  Future<bool> _inputsValidator() async {
    bool _inputsAreValid;

    /// when no pictures picked
    if (_superFlyer.mSlides == null || _superFlyer.mSlides.isEmpty){
      await CenterDialog.showCenterDialog(
        context: context,
        // title: 'No '
        body: 'First, select some pictures',
      );
      _inputsAreValid = false;
    }

    /// when less than 3 pictures selected
    else if (_superFlyer.mSlides.length < 3){
      await CenterDialog.showCenterDialog(
        context: context,
        // title: 'No '
        body: 'At least 3 pictures are required to publish this flyer',
      );
      _inputsAreValid = false;
    }

    /// when no keywords selected
    else if (_superFlyer.keywords.isEmpty){
      /// TASK : add these keywords condition in flyer publish validator
      // await
      _inputsAreValid = true;
    }

    /// when flyerType is not defined
    else if (_superFlyer.flyerType == null){
      await _onFlyerTypeTap();
      _inputsAreValid = false;
    }

    /// when everything is okey
    else {
      _inputsAreValid = true;

    }

    return _inputsAreValid;
  }
// -----------------------------------------------------o
  Future<void> _onPublishFlyer() async {
    print('publishing flyer');

    _triggerLoading();

    await _slideBackToSlidesPage();

    FlyerModel _uploadedFlyer;

    /// A - when creating new flyer
    if (_superFlyer.edit.firstTimer == true){
      print('first timer');

      _uploadedFlyer = await _createNewFlyer();
    }

    /// A - when creating updated flyer
    else {
      print('updating the flyer not first timer');

      _uploadedFlyer = await _updateExistingFlyer(_originalFlyer);
    }

    // /// B - update local tiny flyer
    // if(_uploadedFlyer != null){

    // /// B1 - when first time creating the flyer
    // if(_superFlyer.firstTimer == true){
    //   /// add the result final TinyFlyer to local list and notifyListeners
    //   _prof.addTinyFlyerToLocalList(_uploadedTinyFlyer);
    // }
    //
    // /// B1 - when updating existing flyer
    // else {
    //   _prof.replaceTinyFlyerInLocalList(_uploadedTinyFlyer);
    // }

    // }

    // /// B - if uploaded flyer is null
    // else {
    //   print('_uploaded flyer is null,, very weird');
    // }

    _triggerLoading();

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Great !',
      body: _superFlyer.edit.firstTimer == true ? 'Flyer has been created' : 'Flyer has been updated',
    );

    Nav.goBack(context, argument: _uploadedFlyer);

  }
// -----------------------------------------------------o
// -----------------------------------------------------o
//   Future<List<SlideModel>> combineSlidesStuffInSlidesModels({
//     List<String> picturesURLs,
//     List<SlideModel> currentSlides,
//     List<TextEditingController> titlesControllers,
//     List<TextEditingController> descriptionsControllers,
//   }) async {
//     List<SlideModel> _slides = [];
//
//     for (var slide in currentSlides){
//
//       int i = slide.slideIndex;
//
//       SlideModel _newSlide = SlideModel(
//         slideIndex: currentSlides[i].slideIndex,
//         picture: picturesURLs[i],
//         headline: titlesControllers[i].text,
//         description: descriptionsControllers[i].text,
//         savesCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].savesCount,
//         sharesCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].sharesCount,
//         viewsCount: _superFlyer.firstTimer ? 0 : _superFlyer.mutableSlides[i].viewsCount,
//         imageSize: currentSlides[i].imageSize,
//         boxFit: currentSlides[i].boxFit,
//       );
//
//       _slides.add(_newSlide);
//
//     }
//
//     print('slides are $_slides');
//
//     return _slides;
//   }
// -----------------------------------------------------o
//   Future<List<SlideModel>> _createSlidesModelsFromCurrentSuperFlyer() async {
//     List<SlideModel> _slides = [];
//
//     // for (int i = 0; i<_superFlyer.mutableSlides.length; i++){
//     //
//     //   SlideModel _newSlide = SlideModel(
//     //     slideIndex: i,
//     //     picURL: _superFlyer.mutableSlides[i].picURL,
//     //     headline: _superFlyer.headlinesControllers[i].text,
//     //     description: _superFlyer.descriptionsControllers[i].text,
//     //     savesCount: _superFlyer.mutableSlides[i].savesCount,
//     //     sharesCount: _superFlyer.mutableSlides[i].sharesCount,
//     //     viewsCount: _superFlyer.mutableSlides[i].viewsCount,
//     //     imageSize: _superFlyer.mutableSlides[i].imageSize,
//     //     picFit: _superFlyer.mutableSlides[i].picFit,
//     //     midColor: _superFlyer.mutableSlides[i].midColor,
//     //   );
//     //
//     //   _slides.add(_newSlide);
//     //
//     // }
//
//     return _slides;
//   }
// -----------------------------------------------------o
  Future<List<SlideModel>> _createSlidesFromCurrentSuperFlyer() async {
    final List<SlideModel> _slides = <SlideModel>[];

    for (int i = 0; i<_superFlyer.mSlides.length; i++){


      final SlideModel _newSlide = SlideModel(
        slideIndex: i,
        pic: _superFlyer.mSlides[i].picFile,
        headline: _superFlyer.mSlides[i].headlineController.text,
        description: _superFlyer.mSlides[i].descriptionController.text,
        savesCount: _superFlyer.mSlides[i].savesCount,
        sharesCount: _superFlyer.mSlides[i].sharesCount,
        viewsCount: _superFlyer.mSlides[i].viewsCount,
        imageSize: _superFlyer.mSlides[i].imageSize,
        picFit: _superFlyer.mSlides[i].picFit,
        midColor: _superFlyer.mSlides[i].midColor,
      );

      _slides.add(_newSlide);

    }

    return _slides;
  }
// -----------------------------------------------------o
//   Future<List<SlideModel>> _createUpdatesSlides() async {
//     List<SlideModel> _slides = [];
//
//     for (int i = 0; i<_superFlyer.assetsFiles.length; i++){
//
//       ImageSize _imageSize = await Imagers.superImageSize(_superFlyer.assetsFiles[i]);
//
//       SlideModel _newSlide = SlideModel(
//         slideIndex: i,
//         picURL: _superFlyer.assetsFiles[i],
//         headline: _superFlyer.headlinesControllers[i].text,
//         description: _superFlyer.descriptionsControllers[i].text,
//         savesCount: _superFlyer.mutableSlides[i].savesCount,
//         sharesCount: _superFlyer.mutableSlides[i].sharesCount,
//         viewsCount: _superFlyer.mutableSlides[i].viewsCount,
//         picFit: _superFlyer.mutableSlides[i].picFit,
//         imageSize: _imageSize,
//         midColor:  _superFlyer.mutableSlides[i].midColor,
//       );
//
//       _slides.add(_newSlide);
//
//     }
//
//     return _slides;
//   }
// -----------------------------------------------------o
  Future<FlyerModel> _createNewFlyer() async {
    FlyerModel _uploadedFlyerModel;


    /// assert that all required fields are valid
    final bool _inputsAreValid = await _inputsValidator();

    if (_inputsAreValid == false){
      // dialogs already pushed in inputsValidator

    } else {


      /// create slides models
      final List<SlideModel> _slides = await _createSlidesFromCurrentSuperFlyer();

      /// create tiny author model from bz.authors
      final BzModel _bz = _superFlyer.bz;
      // final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(_bz, superUserID());

      ///create FlyerModel
      final FlyerModel _newFlyerModel = FlyerModel(
        id: _superFlyer.flyerID, /// TASK : redundancy : will be created in createFlyerOps
        title: _superFlyer.title,
        trigram: TextGen.createTrigram(input: _superFlyer.title), /// TASK : redundancy : will be created in createFlyerOps
        // -------------------------
        flyerType: _superFlyer.flyerType,
        flyerState: _superFlyer.flyerState,
        keywordsIDs: KW.getKeywordsIDsFromKeywords(_superFlyer.keywords),
        showsAuthor: _superFlyer.flyerShowsAuthor,
        zone: _superFlyer.zone,
        // -------------------------
        authorID: _superFlyer.authorID,
        bzID: _superFlyer.bz.id,
        // -------------------------
        position: _superFlyer.position,
        // -------------------------
        slides: _slides,
        // -------------------------
        isBanned: false,
        info: _superFlyer.infoController.text,
        specs: _superFlyer.specs,
        times: <PublishTime>[PublishTime(time: DateTime.now(), state: FlyerState.published)],
        priceTagIsOn: _superFlyer.priceTagIsOn,
      );

      /// start create flyer ops
      _uploadedFlyerModel = await FireFlyerOps.createFlyerOps(
          context: context,
          inputFlyerModel: _newFlyerModel,
          bzModel: _bz,
      );

    }

    return _uploadedFlyerModel;
  }
// -----------------------------------------------------o
  Future<FlyerModel> _updateExistingFlyer(FlyerModel originalFlyer) async {
    FlyerModel _uploadedFlyerModel;

    /// assert that all required fields are valid
    final bool _inputsAreValid = await _inputsValidator();
    if (_inputsAreValid == false){
      // show something for user to know

      await CenterDialog.showCenterDialog(
        context: context,
        title: '',
        body: 'Please add all required fields',
      );


    } else {

      print('A- Managing slides');

      /// create slides models
      final List<SlideModel> _updatedSlides = await _createSlidesFromCurrentSuperFlyer();

      print('B- Modifying flyer');

      ///create updated FlyerModel
      final FlyerModel _tempUpdatedFlyerModel = FlyerModel(
        id: _superFlyer.flyerID,
        title: _superFlyer.title,
        trigram: TextGen.createTrigram(input: _superFlyer.title), /// IS NOT RECREATED IN UPDATE FLYER OPS
        // -------------------------
        flyerType: _superFlyer.flyerType,
        flyerState: _superFlyer.flyerState,
        keywordsIDs: KW.getKeywordsIDsFromKeywords(_superFlyer.keywords),
        showsAuthor: _superFlyer.flyerShowsAuthor,
        zone: _superFlyer.zone,
        // -------------------------
        authorID: _superFlyer.authorID,
        bzID: _superFlyer.bz.id,
        // -------------------------
        position: _superFlyer.position,
        // -------------------------
        slides: _updatedSlides,
        // -------------------------
        isBanned: PublishTime.flyerIsBanned(_superFlyer.times),
        info: _superFlyer.infoController.text,
        specs: _superFlyer.specs,
        priceTagIsOn: _superFlyer.priceTagIsOn,
        times: _superFlyer.times,
        // specs: _draft.specs,
      );

      print('C- Uploading to cloud');

      /// start create flyer ops
      _uploadedFlyerModel = await FireFlyerOps.updateFlyerOps(
        context: context,
        updatedFlyer: _tempUpdatedFlyerModel,
        originalFlyer: originalFlyer,
        bzModel : _superFlyer.bz,
      );

      print('D- Uploading to cloud');


      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Great !',
        body: 'Flyer has been updated',
      );

    }

    return _uploadedFlyerModel;
  }
// -----------------------------------------------------o
  Future<void> _onDeleteFlyer() async {
    // Nav.goBack(context);
    _triggerLoading();

    /// Task : this should be bool dialog instead
    final bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to Delete this flyer and never get it back?',
      boolDialog: true,
    );

    print(_dialogResult);

    if (_dialogResult == true){

      /// start delete flyer ops
      await FireFlyerOps.deleteFlyerOps(
        context: context,
        bzModel: _bzModel,
        flyerModel : _originalFlyer,
        deleteFlyerIDFromBzzFlyersIDs: true,
      );

      /// remove tinyFlyer from Local list
      // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);

      _triggerLoading();

      /// re-route back
      Nav.goBack(context, argument: true);

    }

    else {
      _triggerLoading();
    }

  }
// -----------------------------------------------------o
  Future<void> _onUnpublishFlyer() async {

    // Nav.goBack(context);

    /// Task : this should be bool dialog instead
    final bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to unpublish this flyer ?',
      boolDialog: true,
    );

    /// if user stop
    if (_dialogResult == false) {

      print('cancelled unpublishing flyer');

    }

    /// if user continue
    else {

      /// start delete flyer ops
      await FireFlyerOps.deactivateFlyerOps(
        context: context,
        bzModel: _bzModel,
        flyerID : _superFlyer.flyerID,
      );

      /// remove tinyFlyer from Local list
      // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
      // _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);


    }

    // /// re-route back
    // Nav.goBack(context, argument: true);

  }
// -----------------------------------------------------o
  Future<void> _onRepublishFlyer() async {
    print('this is here to republish the flyer');
  }
// -----------------------------------------------------o
//   void _slideFlyerOptions(BuildContext context, FlyerModel flyerModel){
//
//     // BottomDialog.slideButtonsBottomDialog(
//     //   context: context,
//     //   // height: (50+10+50+10+50+30).toDouble(),
//     //   draggable: true,
//     //   buttonHeight: 50,
//     //   buttons: <Widget>[
//     //
//     //     // --- UNPUBLISH FLYER
//     //     DreamBox(
//     //       height: 50,
//     //       width: BottomDialog.dialogClearWidth(context),
//     //       icon: Iconz.XSmall,
//     //       iconSizeFactor: 0.5,
//     //       iconColor: Colorz.Red255,
//     //       verse: 'Unpublish Flyer',
//     //       verseScaleFactor: 1.2,
//     //       verseColor: Colorz.Red255,
//     //       // verseWeight: VerseWeight.thin,
//     //       onTap: () => _unpublishFlyerOnTap(context),
//     //
//     //     ),
//     //
//     //     // --- DELETE FLYER
//     //     DreamBox(
//     //       height: 50,
//     //       width: BottomDialog.dialogClearWidth(context),
//     //       icon: Iconz.FlyerScale,
//     //       iconSizeFactor: 0.5,
//     //       verse: 'Delete Flyer',
//     //       verseScaleFactor: 1.2,
//     //       verseColor: Colorz.White255,
//     //       onTap: () async {
//     //         Nav.goBack(context);
//     //
//     //         /// Task : this should be bool dialog instead
//     //         bool _dialogResult = await superDialog(
//     //           context: context,
//     //           title: '',
//     //           body: 'Are you sure you want to Delete this flyer and never get it back?',
//     //           boolDialog: true,
//     //         );
//     //
//     //         print(_dialogResult);
//     //
//     //         /// start delete flyer ops
//     //         await FlyerOps().deleteFlyerOps(
//     //           context: context,
//     //           bzModel: bzModel,
//     //           flyerModel : flyerModel,
//     //         );
//     //
//     //         /// remove tinyFlyer from Local list
//     //         FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
//     //         _prof.removeTinyFlyerFromLocalList(tinyFlyer.flyerID);
//     //
//     //         /// re-route back
//     //         Nav.goBack(context, argument: true);
//     //       },
//     //     ),
//     //
//     //     // --- EDIT FLYER
//     //     DreamBox(
//     //       height: 50,
//     //       width: BottomDialog.dialogClearWidth(context),
//     //       icon: Iconz.Gears,
//     //       iconSizeFactor: 0.5,
//     //       verse: 'Edit Flyer',
//     //       verseScaleFactor: 1.2,
//     //       verseColor: Colorz.White255,
//     //       onTap: (){
//     //
//     //         Nav.goToNewScreen(context,
//     //             OldFlyerEditorScreen(
//     //                 bzModel: bzModel,
//     //                 firstTimer: false,
//     //                 flyerModel: flyerModel
//     //             ));
//     //
//     //       },
//     //     ),
//     //
//     //   ],
//     //
//     // );
//
//   }
// -----------------------------------------------------o
  //   // List<TextEditingController> _createHeadlinesForExistingFlyer(){
//   //   List<TextEditingController> _controllers = [];
//   //
//   //   _flyer.slides.forEach((slide) {
//   //     TextEditingController _controller = new TextEditingController();
//   //     _controller.text = slide.headline;
//   //     _controllers.add(_controller);
//   //   });
//   //
//   //   return _controllers;
//   // }
// // -----------------------------------------------------------------------------
// //   List<bool> _createSlidesVisibilityList(){
// //     int _listLength = widget.draftFlyer.assetsFiles.length;
// //     List<bool> _visibilityList = [];
// //
// //     for (int i = 0; i<_listLength; i++){
// //       _visibilityList.add(true);
// //     }
// //
// //     return _visibilityList;
// //   }
//
// }
// -----------------------------------------------------------------------------
  bool _superFlyerHasIDCheck(){
    bool _hasID;

    if (_superFlyer?.flyerID == null){
      _hasID = false;
    }
    else {
      _hasID = true;
    }

    return _hasID;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);

    final bool _superFlyerHasID = _superFlyerHasIDCheck();

    // bool _flyerHasMoreThanOnePage = FlyerMethod.flyerHasMoreThanOneSlide(_superFlyer);

    // BzModel _editorBzModel =
    // _superFlyer == null ? null :
    // _superFlyer.isDraft == true ? BzModel.getBzModelFromSuperFlyer(_superFlyer) :
    // null;

    // print('widget.goesToFlyer is : ${widget.goesToEditor} for ${_superFlyer.flyerID}');

    Tracer.traceWidgetBuild(number: 1, widgetName: 'FinalFlyer', varName: 'flyerID', varValue: _superFlyer.flyerID, tracerIsOn: false);
    // Tracer.traceWidgetBuild(number: 2, widgetName: 'FinalFlyer', varName: 'numberOfSlides', varValue: _superFlyer.numberOfSlides);
    // Tracer.traceWidgetBuild(number: 3, widgetName: 'FinalFlyer', varName: 'midColor', varValue: Colorizer.cipherColor(_superFlyer.mSlides[0].midColor));
    return
        FlyerBox(
          flyerBoxWidth: widget.flyerBoxWidth,
          superFlyer: _superFlyer,
          onFlyerZoneTap: _onFlyerZoneTap,
          onFlyerZoneLongPress: _onFlyerZoneLongPress,
          editorBzModel: _bzModel,
          editorMode: widget.inEditor,
          key: widget.flyerKey,
          stackWidgets: <Widget>[

            if (_superFlyerHasID == true)
              FlyerPages(
                superFlyer: _superFlyer,
                flyerBoxWidth: widget.flyerBoxWidth,
              ),

            if (_superFlyerHasID == true)
              NewHeader(
                superFlyer: _superFlyer,
                flyerBoxWidth: widget.flyerBoxWidth,
              ),

            if (_tinyMode == false)
              ProgressBar(
                swipeDirection: _superFlyer.nav.swipeDirection,
                opacity: _superFlyer.nav.progressBarOpacity,
                numberOfStrips: _superFlyer?.numberOfStrips ?? 0,
                numberOfSlides: _superFlyer?.mSlides?.length ?? 0,
                index: _superFlyer.currentSlideIndex,
                flyerBoxWidth: widget.flyerBoxWidth,
                loading: _loading,
              ),

          ],
        );

  }
}
