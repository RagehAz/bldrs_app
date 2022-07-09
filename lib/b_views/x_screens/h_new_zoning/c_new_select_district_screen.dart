import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/ccc_select_district_screen_all_districts_view.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_district_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/h_zoning_controllers/zoning_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NewSelectDistrictScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewSelectDistrictScreen({
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final CityModel city;
  /// --------------------------------------------------------------------------
  @override
  State<NewSelectDistrictScreen> createState() => _NewSelectDistrictScreenState();
/// --------------------------------------------------------------------------
}

class _NewSelectDistrictScreenState extends State<NewSelectDistrictScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false); /// tamam disposed
  final ValueNotifier<List<DistrictModel>> _cityDistricts = ValueNotifier<List<DistrictModel>>(<DistrictModel>[]);  /// tamam disposed
  final ValueNotifier<List<DistrictModel>> _foundDistricts = ValueNotifier<List<DistrictModel>>(null); /// tamam disposed
  ValueNotifier<ZoneModel> _currentZone;
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(true); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({
    @required setTo,
  }) async {
    _loading.value = setTo;
    blogLoading(
      loading: _loading.value,
      callerName: 'EditProfileScreen',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    final ZoneModel _initialZone = ZoneModel(
      countryID: widget.country.id,
      countryModel: widget.country,
      cityID: widget.city.cityID,
      cityModel: widget.city,
    );
    _currentZone = ValueNotifier<ZoneModel>(_initialZone);
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------------
        /// COMPLETE CURRENT ZONE
        _currentZone.value = await ZoneProvider.proFetchCompleteZoneModel(
          context: context,
          incompleteZoneModel: _currentZone.value,
        );

        _cityDistricts.value = _currentZone.value.cityModel.districts;

        // ----------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onDistrictTap(String districtID) async {

    final ZoneModel _zoneWithDistrict = await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value.copyWith(
        districtID: districtID,
      ),
    );

    Nav.goBack(context, passedData: _zoneWithDistrict);

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
    Nav.goBack(context);
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

    // final ZoneModel _appBarZone = ZoneModel(
    //   countryID: widget.country.id,
    //   cityID: widget.city.cityID,
    // );

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: widget.city,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onSearchSubmit: _onSearchDistrict,
      onSearchChanged: _onSearchDistrict,
      pageTitle: superPhrase(context, 'phid_select_a_district'),
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHint: '${superPhrase(context, 'phid_search_districts_of')} $_cityName',
      loading: _loading,
      // appBarRowWidgets: <Widget>[
        // const Expander(),
        //
        // ZoneButton(
        //   zoneOverride: _appBarZone,
        //   countryOverride: widget.country,
        //   cityOverride: widget.city,
        // ),
      // ],
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return ValueListenableBuilder(
                  valueListenable: _loading,
                  builder:(_, bool loading, Widget child){

                    /// WHILE LOADING
                    if (loading == true){
                      return const LoadingFullScreenLayer();
                    }

                    /// SEARCH RESULT
                    else {

                      return ValueListenableBuilder(
                        valueListenable: _foundDistricts,
                        builder: (_, List<DistrictModel> foundDistricts, Widget child){

                          const EdgeInsets _topMargin = EdgeInsets.only(
                              top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                              bottom: Ratioz.horizon,
                          );

                          /// WHEN SEARCH RESULTS
                          if (Mapper.checkCanLoopList(foundDistricts) == true){
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: foundDistricts.length,
                                padding: _topMargin,
                                shrinkWrap: true,
                                itemBuilder: (_, int index) {

                                  final DistrictModel input = foundDistricts[index];

                                  return WideDistrictButton(
                                    district: input,
                                    onTap: _onDistrictTap,
                                  );

                                }
                            );
                          }

                          /// WHEN RESULT IS EMPTY
                          else {

                            return Container(
                              margin: _topMargin,
                              child: const SuperVerse(
                                verse: 'No Result found',
                                labelColor: Colorz.white10,
                                size: 3,
                                weight: VerseWeight.thin,
                                italic: true,
                                color: Colorz.white200,
                              ),
                            );

                          }

                        },
                      );

                    }


                  }
              );


            }

            /// NOT SEARCHING
            else {

              return
                ValueListenableBuilder(
                  valueListenable: _cityDistricts,
                  builder: (_, List<DistrictModel> districts, Widget child){

                    return SelectDistrictScreenAllDistrictsView(
                      onDistrictChanged: _onDistrictTap,
                      districts: districts,
                    );

                  },
                );

            }

            // if (isSearchingDistrict == true){
            //
            //   return
            //
            //     SearchedDistrictsButtons(
            //       onDistrictTap: onDistrictTap,
            //     );
            //
            // }
            //
            // else {
            //
            //   return
            //     SelectDistrictScreenAllDistrictsView(
            //       onDistrictChanged: onDistrictTap,
            //       districts: districts,
            //     );
            //
            // }

          },
        ),
      ),
    );

  }
}
