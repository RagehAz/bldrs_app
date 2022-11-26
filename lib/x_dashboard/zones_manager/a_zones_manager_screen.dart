import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/zones_manager/x_zones_manager_controller.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/a_country_editor/aa_edit_country_page.dart';
import 'package:bldrs/x_dashboard/zones_manager/zone_editors/b_city_editor/aaa_edit_city_page.dart';
import 'package:bldrs/x_dashboard/zones_manager/zoning_lab/b_zoning_lab.dart';
import 'package:flutter/material.dart';

class ZonesEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZonesEditorScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ZonesEditorScreenState createState() => _ZonesEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _ZonesEditorScreenState extends State<ZonesEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  // --------------------
  final ValueNotifier<ZoneModel> _zone = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _progressBarModel.value = const ProgressBarModel(
      swipeDirection: SwipeDirection.freeze,
      index: 0,
      numberOfStrips: 2,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {


        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _zone.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return ValueListenableBuilder(
      valueListenable: _zone,
      builder: (_, ZoneModel zone, Widget child){

        // final String _countryName = CountryModel.getTranslatedCountryName(
        //   context: context,
        //   countryID: zone.countryID,
        // );
        // final String _countryFlag = Flag.getFlagIconByCountryID(zone.countryID);
        //
        // final CurrencyModel _currencyModel = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        //   currencies: ZoneProvider.proGetAllCurrencies(context),
        //   countryID: zone.countryID,
        // );

        return PagesLayout(
          title: Verse.plain('Zones manager'),
          appBarRowWidgets: <Widget>[

            const Expander(),

            /// ZONE BUTTON
            ValueListenableBuilder(
              valueListenable: _zone,
              builder: (_, ZoneModel zone, Widget child){

                return ZoneButton(
                  zoneOverride: zone,
                  onTap: () => goToCountrySelectionScreen(
                    context: context,
                    zone: _zone,
                  ),
                );

              },
            ),

          ],
          pyramidButtons: <Widget>[

            /// SYNCING
            ValueListenableBuilder(
              valueListenable: _zone,
              builder: (_, ZoneModel zone, Widget child){

                final bool _areIdentical = ZoneModel.checkZonesIDsAreIdentical(
                  zone1: zone,
                  zone2: zone,
                );

                return PyramidFloatingButton(
                  icon: Iconz.reload,
                  color: _areIdentical == true ? Colorz.nothing : Colorz.yellow255,
                  isDeactivated: _areIdentical,
                  onTap: (){
                    if (_areIdentical == true){
                      blog('Zones has NOT changed');
                    }
                    else {
                      blog('Zones has changed');
                    }
                  },
                );

              },
            ),

            /// LAB
            PyramidFloatingButton(
              icon: Iconz.lab,
              onTap: () async {
                await Nav.goToNewScreen(
                  context: context,
                  screen: const ZoningLab(),
                );
              },
            ),

          ],
          pageBubbles: [

              if (zone == null)
                Center(
                  child: SuperVerse(
                    verse: Verse.plain('Select a Zone'),
                    size: 4,
                    italic: true,
                    color: Colorz.white50,
                  ),
                ),

              /// COUNTRY PAGE
              if (zone != null)
                CountryEditorPage(
                  appBarType: AppBarType.basic,
                  country: zone.countryModel,
                  screenHeight: _screenHeight,
                  onCityTap: () => goToCitySelectionScreen(
                    context: context,
                    zone: _zone,
                    pageController: _pageController,
                  ),
                ),

              /// CITY PAGE
              if (zone != null)
                EditCityPage(
                  screenHeight: _screenHeight,
                  zoneModel: zone,
                ),

            ],
        );

      },
    );

  }
  // -----------------------------------------------------------------------------
}
