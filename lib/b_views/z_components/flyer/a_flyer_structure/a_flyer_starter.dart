import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_full_screen.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/i_flyer_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerStarter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerStarter({
    @required this.flyerModel,
    @required this.minWidthFactor,
    this.parentFlyerID,
    this.isFullScreen = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double minWidthFactor;
  final bool isFullScreen;
  final String parentFlyerID;
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
  Future<void> _setBz(BzModel bzModel) async {
    _bzModelNotifier.value = bzModel;
  }
// -----------------------------------------------------------------------------
  /// FLYER BZ COUNTRY
  final ValueNotifier<CountryModel> _bzCountryNotifier = ValueNotifier(null);
  void _setBzCountry(CountryModel bzCountry){
    _bzCountryNotifier.value = bzCountry;
  }
// -----------------------------------------------------------------------------
  /// FLYER BZ CITY
  final ValueNotifier<CityModel> _bzCityNotifier = ValueNotifier(null);
  void _setBzCity(CityModel bzCity){
    _bzCityNotifier.value = bzCity;
  }
// -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _flyerModel = widget.flyerModel;
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        final BzModel _bzModel = await getFlyerBzModel(
          context: context,
          flyerModel: _flyerModel,
        );
        final CountryModel _bzCountry = await getFlyerBzCountry(
          context: context,
          countryID: _bzModel.zone.countryID,
        );
        final CityModel _bzCity = await getFlyerBzCity(
          context: context,
          cityID: _bzModel.zone.cityID,
        );

        await _setBz(_bzModel);
        _setBzCountry(_bzCountry);
        _setBzCity(_bzCity);

        await _triggerLoading(setTo: false);

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _openFullScreenFlyer() async {

    await context.pushTransparentRoute(
        FlyerFullScreen(
          key: const ValueKey<String>('Flyer_Full_Screen'),
          flyerModel: _flyerModel,
          bzModel: _bzModelNotifier.value,
          minWidthFactor: widget.minWidthFactor,
          bzCountry: _bzCountryNotifier.value,
          bzCity: _bzCityNotifier.value,
          parentFlyerID: widget.parentFlyerID,
        )
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('flyer ID is ${widget.flyerModel.id} : parentID is ${widget.parentFlyerID?? 'non'}');

    return ValueListenableBuilder(
        key: ValueKey<String>('FlyerStarter_${widget.flyerModel.id}'),
        valueListenable: _loading,
        child: FlyerLoading(flyerWidthFactor: widget.minWidthFactor,),
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return child;
          }

          else {

            return ValueListenableBuilder<BzModel>(
                valueListenable: _bzModelNotifier,
                builder: (_, BzModel bzModel, Widget child){

                  return ValueListenableBuilder<CountryModel>(
                      valueListenable: _bzCountryNotifier,
                      builder: (_, CountryModel bzCountry, Widget child){

                        return ValueListenableBuilder<CityModel>(
                            valueListenable: _bzCityNotifier,
                            builder: (_, CityModel bzCity, Widget child){

                              if (bzModel == null || widget.flyerModel == null){
                                return FlyerLoading(flyerWidthFactor: widget.minWidthFactor,);
                              }

                              else {

                                return GestureDetector(
                                  onTap: _openFullScreenFlyer,
                                  child: FlyerHero(
                                    key: const ValueKey<String>('Flyer_hero'),
                                    flyerModel: _flyerModel,
                                    bzModel: bzModel,
                                    bzCountry: bzCountry,
                                    bzCity: bzCity,
                                    minWidthFactor: widget.minWidthFactor,
                                    isFullScreen: widget.isFullScreen,
                                    parentFlyerID: widget.parentFlyerID,
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
