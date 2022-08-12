import 'dart:async';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/e_zones_editor/edict_country_page.dart';
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
  ScrollController _scrollController; /// tamam disposed
  PageController _pageController; /// tamam disposed
  final ValueNotifier<ZoneModel> _zone = ValueNotifier<ZoneModel>(null);
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
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
  @override
  void dispose() {
    _loading.dispose();
    _zone.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
        pyramidsAreOn: true,
        sectionButtonIsOn: false,
        appBarType: AppBarType.basic,
        pageTitle: 'Zones Manager',
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
                verse: 'Synced',
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
              return const SizedBox();
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



                  CountryEditorPage(
                    country: zone.countryModel,
                    screenHeight: _screenHeight,
                  ),

                  /// COUNTRIES PAGE
                  // PageBubble(
                  //   screenHeightWithoutSafeArea: _screenHeight,
                  //   appBarType: AppBarType.basic,
                  //   color: Colorz.white10,
                  //   child: ListView(
                  //     physics: const BouncingScrollPhysics(),
                  //     children: <Widget>[
                  //
                  //       const Stratosphere(),
                  //
                  //       /// ID
                  //       DataStrip(
                  //         width: _appBarWidth,
                  //         dataKey: 'ID',
                  //         dataValue: zone.countryID,
                  //         color: Colorz.black255,
                  //       ),
                  //
                  //       /// REGION - CONTINENT
                  //       DataStrip(
                  //         width: _appBarWidth,
                  //         dataKey: 'Region\nCont.',
                  //         dataValue: '${zone.countryModel.region} - ${zone.countryModel.continent}',
                  //         color: Colorz.black255,
                  //       ),
                  //
                  //       /// CURRENCY
                  //       DataStrip(
                  //         width: _appBarWidth,
                  //         dataKey: 'Currency',
                  //         dataValue: '${_currencyModel.symbol} : ${xPhrase(context, _currencyModel.id)}',
                  //         color: Colorz.black255,
                  //       ),
                  //
                  //       /// LANGUAGE
                  //       DataStrip(
                  //         width: _appBarWidth,
                  //         dataKey: 'Lang',
                  //         dataValue: zone.countryModel.language,
                  //         color: Colorz.black255,
                  //       ),
                  //
                  //       const DotSeparator(),
                  //
                  //       // /// ENGLISH NAME
                  //       // TextFieldBubble(
                  //       //   title: 'English Name',
                  //       //   textController: _enNameController,
                  //       //   textOnChanged: (String text){
                  //       //
                  //       //     _countryModel.value = _countryModel.value.copyWith(
                  //       //       phrases: updatePhrases(
                  //       //           langCode: 'en',
                  //       //           text: text
                  //       //       ),
                  //       //     );
                  //       //
                  //       //   },
                  //       // ),
                  //       //
                  //       // /// ARABIC NAME
                  //       // TextFieldBubble(
                  //       //   title: 'Arabic Name',
                  //       //   textController: _arNameController,
                  //       //   textOnChanged: (String text){
                  //       //
                  //       //     _countryModel.value = _countryModel.value.copyWith(
                  //       //       phrases: updatePhrases(
                  //       //           langCode: 'ar',
                  //       //           text: text
                  //       //       ),
                  //       //     );
                  //       //
                  //       //   },
                  //       // ),
                  //
                  //       const DotSeparator(),
                  //
                  //       /// --- IS ACTIVATED
                  //       TileBubble(
                  //         verse: 'Country is Activated',
                  //         secondLine: 'When Country is Deactivated, '
                  //             'only business authors may see it while creating business profile',
                  //         icon: _countryFlag,
                  //         iconBoxColor: Colorz.grey50,
                  //         iconSizeFactor: 1,
                  //         switchIsOn: zone.countryModel.isActivated,
                  //         switching: (bool val) {
                  //
                  //           _zone.value = _zone.value.copyWith(
                  //             countryModel: _zone.value.countryModel.copyWith(
                  //               isActivated: val,
                  //             ),
                  //           );
                  //
                  //         },
                  //       ),
                  //
                  //       /// --- IS GLOBAL
                  //       TileBubble(
                  //         verse: 'Country is Global ?',
                  //         secondLine:
                  //         'When Country is not Global, only users of this country will see its businesses and flyers',
                  //         icon: _countryFlag,
                  //         iconBoxColor: Colorz.grey50,
                  //         iconSizeFactor: 1,
                  //         switchIsOn: zone.countryModel.isGlobal,
                  //         switching: (bool val) {
                  //
                  //           _zone.value = _zone.value.copyWith(
                  //             countryModel: _zone.value.countryModel.copyWith(
                  //               isGlobal: val,
                  //             ),
                  //           );
                  //
                  //         },
                  //       ),
                  //
                  //       const DotSeparator(),
                  //
                  //       const Horizon(),
                  //
                  //     ],
                  //   ),
                  // ),

                  /// CITIES PAGE
                  PageBubble(
                    screenHeightWithoutSafeArea: _screenHeight,
                    appBarType: AppBarType.search,
                    color: Colorz.bloodTest,
                    child: Container(),
                  ),

                ],
              );

            }


          },
        ),
    );
  }
}
