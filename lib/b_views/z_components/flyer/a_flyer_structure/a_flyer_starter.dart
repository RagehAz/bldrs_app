import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/a_my_bz_screen_controllers.dart';
import 'package:bldrs/c_controllers/x_flyer_controllers/flyer_controllers.dart';
import 'package:bldrs/c_controllers/x_flyer_controllers/footer_controller.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerStarter({
    @required this.flyerModel,
    @required this.minWidthFactor,
    this.heroTag,
    this.isFullScreen = false,
    this.startFromIndex = 0,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double minWidthFactor;
  final bool isFullScreen;
  final String heroTag;
  final int startFromIndex;
  /// --------------------------------------------------------------------------
  @override
  _FlyerStarterState createState() => _FlyerStarterState();
}

class _FlyerStarterState extends State<FlyerStarter> {
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    if (mounted == true){
      _loading.value = setTo;
    }
    blogLoading(
      loading: _loading.value,
      callerName: 'FlyerStarter',
    );
  }
// -----------------------------------------------------------------------------
  /// --- FLYER BZ MODEL
  final ValueNotifier<BzModel> _bzModelNotifier = ValueNotifier(null); /// tamam disposed
// -----------------------------------------------------------------------------
  /// FLYER ZONE
  final ValueNotifier<ZoneModel> _flyerZoneNotifier = ValueNotifier(null); /// tamam disposed
// -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
// -----------------------------------------------------------------------------
  /// CURRENT SLIDE INDEX
  ValueNotifier<int> _currentSlideIndex; /// tamam disposed
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _flyerModel = widget.flyerModel;

    final bool _isSaved = UserModel.checkFlyerIsSaved(
        userModel: UsersProvider.proGetMyUserModel(context: context, listen: false),
        flyerID: _flyerModel.id,
    );

    _flyerIsSaved = ValueNotifier(_isSaved);

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted && _flyerModel != null && _flyerModel?.id != null) {

      _flyerModel.blogFlyer(methodName: 'Flyer Starter : didChangeDependencies');

      _triggerLoading(setTo: true).then((_) async {
        BzModel _bzModel;
// -----------------------------------------------------------------
        /// BZ MODEL
        if (mounted == true){
          _bzModel = await getFlyerBzModel(
            context: context,
            flyerModel: _flyerModel,
          );
        }
// ------------------------------------------
        /// BZ ZONE FIX
        if (mounted == true){
          _bzModel = await completeBzZoneModel(
            context: context,
            bzModel: _bzModel,
          );
        }
// -----------------------------------------------------------------
        CountryModel _flyerCountry;
        /// FLYER ZONE
        if (mounted == true){
          _flyerCountry = await getFlyerBzCountry(
            context: context,
            countryID: widget.flyerModel.zone.countryID,
          );
        }

        CityModel _flyerCity;
        if (mounted == true){
          _flyerCity = await getFlyerBzCity(
            context: context,
            cityID: widget.flyerModel.zone.cityID,
          );
        }
// -----------------------------------------------------------------
        /// STARTING INDEX
        final int _startingIndex = getPossibleStartingIndex(
          flyerModel: widget.flyerModel,
          bzModel: _bzModel,
          heroTag: widget.heroTag,
          startFromIndex: widget.startFromIndex,
        );

        // blog('POSSIBLE STARTING INDEX IS for ${widget.flyerModel.id}: $_startingIndex');

// -----------------------------------------------------------------

        /// SETTERS

        if (mounted == true){
          _bzModelNotifier.value = _bzModel;

          _flyerZoneNotifier.value = getZoneModel(
            context: context,
            countryID: _flyerCountry.id,
            cityModel: _flyerCity,
            districtID: widget.flyerModel.zone.districtID,
          );

          _currentSlideIndex = ValueNotifier(_startingIndex);

        }

// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);

      }
      );
      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _loading?.dispose();
    _bzModelNotifier?.dispose();
    _flyerZoneNotifier?.dispose();
    _currentSlideIndex?.dispose();
    _flyerIsSaved?.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  Future<void> _openFullScreenFlyer() async {

    unawaited(recordFlyerView(
      context: context,
      index: 0,
      flyerModel: widget.flyerModel,
    ));

    await context.pushTransparentRoute(
        FlyerFullScreen(
          key: const ValueKey<String>('Flyer_Full_Screen'),
          flyerModel: _flyerModel,
          bzModel: _bzModelNotifier.value,
          minWidthFactor: widget.minWidthFactor,
          flyerZone: _flyerZoneNotifier.value,
          heroTag: widget.heroTag,
          currentSlideIndex: _currentSlideIndex,
          flyerIsSaved: _flyerIsSaved,
          onSaveFlyer: onTriggerSave,
        )
    );

  }
// -----------------------------------------------------------------------------
  ValueNotifier<bool> _flyerIsSaved; /// tamam disposed
  Future<void> onTriggerSave() async {

    if (mounted == true){
      await onSaveFlyer(
          context: context,
          flyerModel: _flyerModel,
          slideIndex: _currentSlideIndex.value,
          flyerIsSaved: _flyerIsSaved
      );
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('flyer ID is ${widget.flyerModel.id} : parentID is ${widget.heroTag?? 'non'}');

    final double _flyerBoxWidth = FlyerBox.width(context, widget.minWidthFactor);

    return ValueListenableBuilder(
        key: ValueKey<String>('FlyerStarter_${widget.flyerModel?.id}'),
        valueListenable: _loading,
        child: FlyerLoading(flyerBoxWidth: widget.minWidthFactor,),
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return child;
          }

          else {

            return ValueListenableBuilder<BzModel>(
                valueListenable: _bzModelNotifier,
                builder: (_, BzModel bzModel, Widget child){

                  return ValueListenableBuilder<ZoneModel>(
                      valueListenable: _flyerZoneNotifier,
                      builder: (_, ZoneModel flyerZone, Widget child){

                        if (bzModel == null || widget.flyerModel == null){
                          return FlyerLoading(flyerBoxWidth: _flyerBoxWidth,);
                        }

                        else {

                          return GestureDetector(
                            onTap: _openFullScreenFlyer,
                            child: FlyerHero(
                              key: const ValueKey<String>('Flyer_hero'),
                              flyerModel: _flyerModel,
                              bzModel: bzModel,
                              flyerZone: flyerZone,
                              minWidthFactor: widget.minWidthFactor,
                              isFullScreen: widget.isFullScreen,
                              heroTag: widget.heroTag,
                              currentSlideIndex: _currentSlideIndex,
                              onSaveFlyer: onTriggerSave,
                              flyerIsSaved: _flyerIsSaved,
                            ),
                          );

                        }

                      }
                  );

                }
            );

          }

        }
    );
  }
}
