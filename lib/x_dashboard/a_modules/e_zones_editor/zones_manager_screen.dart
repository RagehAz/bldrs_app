import 'dart:async';

import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/edit_city_page.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/edit_country_page.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/zones_manager_controller.dart';
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
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'ZonesEditorScreen',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _zone = ValueNotifier<ZoneModel>(null);

    _scrollController = ScrollController();
    _pageController = PageController();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading().then((_) async {
        // -------------------------------

        // -------------------------------
        await _triggerLoading();

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _loading.dispose();
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
        sectionButtonIsOn: false,
        appBarType: AppBarType.basic,
        pageTitleVerse:  'Zones Manager',
        skyType: SkyType.black,
        appBarRowWidgets: <Widget>[

          const Expander(),

          /// SYNCING
          ValueListenableBuilder(
            valueListenable: _zone,
            builder: (_, ZoneModel zone, Widget child){

              final bool _areIdentical = ZoneModel.checkZonesIDsAreIdentical(
                  zone1: zone,
                  zone2: zone,
              );

              return AppBarButton(
                verse:  'Synced',
                buttonColor: _areIdentical == true ? Colorz.nothing : Colorz.yellow255,
                bubble: !_areIdentical,
                isDeactivated: _areIdentical,
                onTap: (){},
              );

            },
          ),

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
        layoutWidget: ValueListenableBuilder(
          valueListenable: _zone,
          builder: (_, ZoneModel zone, Widget child){

            if (zone == null){
              return Center(
                child: DreamBox(
                  verse:  'Select Zone',
                  height: 100,
                  verseMaxLines: 2,
                  onTap: () => goToCountrySelectionScreen(
                    context: context,
                    zone: _zone,
                  ),
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
    );
  }
}
