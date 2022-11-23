import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/zones_manager/aa_edit_country_page.dart';
import 'package:bldrs/x_dashboard/zones_manager/aaa_edit_city_page.dart';
import 'package:bldrs/x_dashboard/zones_manager/b_zoning_lab.dart';
import 'package:bldrs/x_dashboard/zones_manager/x_zones_manager_controller.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
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
  ScrollController _scrollController;
  PageController _pageController;
  ValueNotifier<ZoneModel> _zone;
  // -----------------------------------------------------------------------------
  /*
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
   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _zone = ValueNotifier<ZoneModel>(null);

    _scrollController = ScrollController();
    _pageController = PageController();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    // _loading.dispose();
    _zone.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      pageTitleVerse: Verse.plain('Zones Manager'),
      skyType: SkyType.black,
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
      layoutWidget: FloatingCenteredList(
        columnChildren: [

          /// ZONING LAB
          WideButton(
            verse: Verse.plain('Zoning Lab'),
            icon: Iconz.lab,
            onTap: () async {
              await Nav.goToNewScreen(
                context: context,
                screen: const ZoningLab(),
              );
            },
          ),

          /// GO TO COUNTRY SCREEN
          ValueListenableBuilder(
            valueListenable: _zone,
            builder: (_, ZoneModel zone, Widget child){

              if (zone == null){
                return WideButton(
                  verse: Verse.plain('Select Zone'),
                  onTap: () => goToCountrySelectionScreen(
                    context: context,
                    zone: _zone,
                  ),
                );
              }

              else {

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

                return PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[

                    /// COUNTRY PAGE
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
                    EditCityPage(
                      screenHeight: _screenHeight,
                      zoneModel: zone,
                    ),

                  ],
                );

              }


            },
          ),

          /// SYNCING
          ValueListenableBuilder(
            valueListenable: _zone,
            builder: (_, ZoneModel zone, Widget child){

              final bool _areIdentical = ZoneModel.checkZonesIDsAreIdentical(
                zone1: zone,
                zone2: zone,
              );

              return WideButton(
                verse: Verse.plain('Synced'),
                color: _areIdentical == true ? Colorz.nothing : Colorz.yellow255,
                bubble: !_areIdentical,
                isActive: !_areIdentical,
                onTap: (){},
              );

            },
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
