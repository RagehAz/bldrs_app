import 'package:bldrs/a_models/secondary_models/name_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/y_views/d_zoning/d_3_select_district_screen_view.dart';
import 'package:bldrs/b_views/z_components/app_bar/zone_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/d_zoning_controller.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectDistrictScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectDistrictScreen({
    @required this.country,
    @required this.city,
    this.settingCurrentZone = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final CityModel city;
  final bool settingCurrentZone;
  /// --------------------------------------------------------------------------
  @override
  State<SelectDistrictScreen> createState() => _SelectDistrictScreenState();
}

class _SelectDistrictScreenState extends State<SelectDistrictScreen> {
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

            await initializeSelectDistrictScreen(
              context: context,
              cityModel: widget.city,
            );

          }
      );

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onDistrictTap(String districtID) async {

    await controlDistrictOnTap(
        context: context,
        cityModel: widget.city,
        districtID: districtID,
        settingCurrentZone: widget.settingCurrentZone
    );

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchDistrict(String inputText) async {

    await controlDistrictSearch(
      context: context,
      searchText: inputText,
    );

  }
// -----------------------------------------------------------------------------
  void _onBack(){
    controlDistrictScreenOnBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

//     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
//     final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
// // -----------------------------------------------------------------------------
//     final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
//     final String _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: widget.city.names)?.value;
//     final List<MapModel> _districtsMapModel = DistrictModel.getDistrictsNamesMapModels(
//       context: context,
//       districts: widget.city.districts,
//     );
// -----------------------------------------------------------------------------
//     return ListLayout(
//       pyramids: Iconz.pyramidzYellow,
//       pageTitle: _cityName,
//       mapModels: _districtsMapModel,
//       pageIconVerse: _cityName,
//       sky: SkyType.black,
//       onItemTap: (String districtID) async {
//         blog('districtID is $districtID');
//
//         final ZoneModel _zone = ZoneModel(
//           countryID: widget.city.countryID,
//           cityID: widget.city.cityID,
//           districtID: districtID,
//         );
//
//         _zone.blogZone(methodName: 'SELECTED ZONE');
//
//         await _zoneProvider.getsetCurrentZoneAndCountryAndCity(
//             context: context, zone: _zone);
//
//         await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
//           context: context,
//           section: _generalProvider.currentSection,
//           kw: _generalProvider.currentKeyword,
//         );
//
//         Nav.goBackToHomeScreen(context);
//       },
//     );

    final ZoneModel _appBarZone = ZoneModel(
      countryID: widget.country.id,
      cityID: widget.city.cityID,
    );

    final String _cityName = Name.getNameByCurrentLingoFromNames(context: context, names: widget.city.names)?.value;

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,

      onSearchSubmit: _onSearchDistrict,
      onSearchChanged: _onSearchDistrict,

      pageTitle: 'Select a District',
      pyramidsAreOn: true,

      onBack: _onBack,
      searchHint: 'Search Districts of $_cityName',
      appBarRowWidgets: <Widget>[

        const Expander(),

        ZoneButton(
          zoneOverride: _appBarZone,
          countryOverride: widget.country,
          cityOverride: widget.city,
        ),

      ],

      layoutWidget: SelectDistrictScreenView(
        districts: widget.city.districts,
        onDistrictTap: _onDistrictTap,
      ),
    );

  }
}
