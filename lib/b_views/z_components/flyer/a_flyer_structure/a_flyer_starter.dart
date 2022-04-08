import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
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
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true);
// -----------------------------------
  Future<void> _triggerLoading({@required setTo}) async {
    _loading.value = setTo;
    blogLoading(loading: _loading.value);
  }
// -----------------------------------------------------------------------------
  /// --- FLYER BZ MODEL
  final ValueNotifier<BzModel> _bzModelNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
  /// FLYER BZ ZONE
  final ValueNotifier<ZoneModel> _bzZoneNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
  /// FLYER ZONE
  final ValueNotifier<ZoneModel> _flyerZoneNotifier = ValueNotifier(null);
// -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
// -----------------------------------------------------------------------------
  /// CURRENT SLIDE INDEX
  ValueNotifier<int> _currentSlideIndex;

  @override
  void initState() {

    _flyerModel = widget.flyerModel;

    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
// -----------------------------------------------------------------
        /// BZ MODEL
        final BzModel _bzModel = await getFlyerBzModel(
          context: context,
          flyerModel: _flyerModel,
        );
// ------------------------------------------
        /// BZ ZONE
        final CountryModel _bzCountry = await getFlyerBzCountry(
          context: context,
          countryID: _bzModel?.zone?.countryID,
        );
        final CityModel _bzCity = await getFlyerBzCity(
          context: context,
          cityID: _bzModel?.zone?.cityID,
        );
// -----------------------------------------------------------------
        /// FLYER ZONE
        final CountryModel _flyerCountry = await getFlyerBzCountry(
          context: context,
          countryID: widget.flyerModel.zone.countryID,
        );
        final CityModel _flyerCity = await getFlyerBzCity(
          context: context,
          cityID: widget.flyerModel.zone.cityID,
        );
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

        _bzModelNotifier.value = _bzModel;
        _bzZoneNotifier.value = getZoneModel(
          context: context,
          countryID: _bzCountry.id,
          cityModel: _bzCity,
          districtID: _bzModel.zone.districtID,
        );

        _flyerZoneNotifier.value = getZoneModel(
          context: context,
          countryID: _flyerCountry.id,
          cityModel: _flyerCity,
          districtID: widget.flyerModel.zone.districtID,
        );

        _currentSlideIndex = ValueNotifier(_startingIndex);
// -----------------------------------------------------------------
        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();

    if (_currentSlideIndex != null){
      _currentSlideIndex.dispose();
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _openFullScreenFlyer() async {

    await context.pushTransparentRoute(
        FlyerFullScreen(
          key: const ValueKey<String>('Flyer_Full_Screen'),
          flyerModel: _flyerModel,
          bzModel: _bzModelNotifier.value,
          minWidthFactor: widget.minWidthFactor,
          bzZone: _bzZoneNotifier.value,
          flyerZone: _flyerZoneNotifier.value,
          heroTag: widget.heroTag,
          currentSlideIndex: _currentSlideIndex,
        )
    );

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
                      valueListenable: _bzZoneNotifier,
                      builder: (_, ZoneModel bzCountry, Widget child){

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
                                    bzZone: bzCountry,
                                    flyerZone: flyerZone,
                                    minWidthFactor: widget.minWidthFactor,
                                    isFullScreen: widget.isFullScreen,
                                    heroTag: widget.heroTag,
                                    currentSlideIndex: _currentSlideIndex,
                                  ),
                                );

                              }

                            }
                        );

                      }
                  );

                }
            );

          }

        }
    );
  }
}
