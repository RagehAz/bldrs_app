import 'dart:async';
import 'dart:convert';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/all_flags_list.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs/c_protocols/zone_protocols/json/currency_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/b_city_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/ldb/c_district_ldb_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/a_countries_levels_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_cities_levels_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_city_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/b_districts_levels_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/real/d_district_real_ops.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/backend_lab/ldb_viewer/ldb_manager_screen.dart';
import 'package:bldrs/x_dashboard/zones_manager/zoning_lab/zones_initial_creators.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class ZoningLab extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoningLab({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<ZoningLab> createState() => _ZoningLabState();
/// --------------------------------------------------------------------------
}

class _ZoningLabState extends State<ZoningLab> {
  // -----------------------------------------------------------------------------

  ZoneModel _bubbleZone;

  // -----------------------------------------------------------------------------
  /// DONE : KEEP FOR REFERENCE
  Future<void> _createCurrenciesJSON() async {

    final List<CurrencyModel> _currencies = ZoneProvider.proGetAllCurrencies(context: context, listen: false);
    // CurrencyModel.blogCurrencies(_currencies);

    final Map<String, dynamic> _map = CurrencyModel.cipherCurrencies(_currencies);

    final String _json = json.encode(_map, );

    blog(_json);

  }
  // --------------------
  ///
  Future<void> _createContinentsJSONMap() async {

    final List<Continent> _allContinents = await ZoneProtocols.readAllContinents();

    final Map<String, dynamic> _map = Continent.cipherContinents(_allContinents);
    final String _json = json.encode(_map);

    blog(_json);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenHeightWithoutSafeArea = Scale.superScreenHeightWithoutSafeArea(context);
    const AppBarType _appBarType = AppBarType.basic;

    return PagesLayout(
      title: Verse.plain('Zoning Lab'),
      pageBubbles: <Widget>[

        /// SELECTION
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Selection'),
              ),

              /// ZONE BY ONE BUTTON
              WideButton(
                verse: Verse.plain('Zone by one button'),
                onTap: () async {

                  final ZoneModel _zone = await Nav.goToNewScreen(
                    context: context,
                    screen: const CountriesScreen(),
                  );

                  _zone?.blogZone(invoker: 'ZONE BY ONE BUTTON');

                  if (_zone == null){
                    blog('ZONE IS NULL');
                  }

                },
              ),

              /// BLOG BUBBLE ZONE
              WideButton(
                verse: Verse.plain('blog current zone'),
                onTap: (){

                  _bubbleZone?.blogZone();

                },
              ),

              /// ZONE BUBBLE
              ZoneSelectionBubble(
                currentZone: _bubbleZone,
                titleVerse:  const Verse(
                  text: 'Zoning test',
                  translate: false,
                ),
                bulletPoints:  const <Verse>[
                  Verse(text: 'Fuck you', translate: false,),
                  Verse(text: 'Bitch', translate: false,),
                ],
                onZoneChanged: (ZoneModel zone){

                  zone.blogZone(invoker: 'ZONE Received from bubble');

                  if (zone != null){
                    _bubbleZone = zone;
                  }

                },
              ),

            ],
          ),
        ),

        /// CURRENCIES
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Currencies'),
              ),

              /// CREATE CURRENCIES JSON
              WideButton(
                verse: Verse.plain('Create Currencies JSON'),
                onTap: _createCurrenciesJSON,
              ),

              /// GET CURRENCIES JSON
              WideButton(
                verse: Verse.plain('Get Currencies JSON map'),
                onTap: () async {

                  final List<CurrencyModel> _currencies = await CurrencyJsonOps.readAllCurrencies();
                  blog('start');
                  CurrencyModel.blogCurrencies(_currencies);
                  blog('end');
                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

        /// CONTINENTS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Continents'),
              ),

              /// CREATE CONTINENTS JSON
              WideButton(
                verse: Verse.plain('Create CONTINENTS JSON'),
                onTap: _createContinentsJSONMap,
              ),

              /// GET CONTINENTS JSON
              WideButton(
                verse: Verse.plain('Get CONTINENTS JSON map'),
                onTap: () async {

                  final List<Continent> _continents = await ZoneProtocols.readAllContinents();
                  blog('start');

                  Continent.blogContinents(_continents);

                  blog('end');
                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

        /// CITIES OPS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Cities Ops'),
              ),

              /// MIGRATE CITY TO NEW REAL
              WideButton(
                verse: Verse.plain('Migrate Cities to real'),
                isActive: false,
                onTap: () async {

                  /// DONE : VERY LONG AND DANGEROUS
                  // await ExoticMethods.readAllSubCollectionDocs(
                  //   collName: FireColl.zones,
                  //   docName: FireDoc.zones_cities,
                  //   subCollName: FireSubColl.zones_cities_cities,
                  //   limit: 40000,
                  //   finders: <FireFinder>[
                  //     // const FireFinder(
                  //     //   field: 'countryID',
                  //     //   comparison: FireComparison.equalTo,
                  //     //   value: 'egy',
                  //     // ),
                  //   ],
                  //   onRead: (i, Map<String, dynamic> map) async {
                  //
                  //     final CityModel _city = CityModel.decipherCityMap(map: map, fromJSON: false);
                  //
                  //     Map<String, dynamic> _newCityMap = {
                  //       'population': _city.population ?? 0,
                  //       'position': Atlas.cipherGeoPoint(point: _city.position, toJSON: true),
                  //     };
                  //
                  //     /// PHRASES
                  //     Map<String, dynamic> _phrasesMap = {};
                  //     for (final Phrase phrase in _city.phrases){
                  //       _phrasesMap = Mapper.insertPairInMap(
                  //           map: _phrasesMap,
                  //           key: phrase.langCode,
                  //           value: phrase.value,
                  //       );
                  //     }
                  //     _newCityMap = Mapper.insertPairInMap(
                  //         map: _newCityMap,
                  //         key: 'phrases',
                  //         value: _phrasesMap,
                  //     );
                  //
                  //     /// DISTRICTS
                  //     if (Mapper.checkCanLoopList(_city.districts) == true){
                  //       Map<String, dynamic> _districtsMap = {};
                  //       for (final DistrictModel dis in _city.districts){
                  //         // -->
                  //         Map<String, dynamic> _disPhrasesMap = {};
                  //         for (final Phrase disPhrase in dis.phrases){
                  //           _disPhrasesMap = Mapper.insertPairInMap(
                  //             map: _disPhrasesMap,
                  //             key: disPhrase.langCode,
                  //             value: disPhrase.value,
                  //           );
                  //         }
                  //         // -->
                  //         _districtsMap = Mapper.insertPairInMap(
                  //           map: _districtsMap,
                  //           key: dis.districtID,
                  //           value: {
                  //             'level': 'inactive',
                  //             'phrases': _disPhrasesMap,
                  //           },
                  //         );
                  //       }
                  //       _newCityMap = Mapper.insertPairInMap(
                  //         map: _newCityMap,
                  //         key: 'districts',
                  //         value: _districtsMap,
                  //       );
                  //
                  //     }
                  //
                  //     // Mapper.blogMap(_newCityMap);
                  //
                  //     await Real.createDocInPath(
                  //       pathWithoutDocName: 'zones/cities/${_city.countryID}',
                  //       docName: _city.cityID,
                  //       addDocIDToOutput: false,
                  //       map: _newCityMap,
                  //     );
                  //
                  //     final String _num = Numeric.formatNumberWithinDigits(num: i, digits: 5);
                  //     blog('$_num : DONE : ${_city.cityID}');
                  //   }
                  // );

                },
              ),

              /// READ A CITY
              WideButton(
                verse: Verse.plain('REAL Read a City'),
                onTap: () async {

                  final CityModel _city = await CityRealOps.readCity(
                    countryID: 'sau',
                    cityID: 'sau_khamis_mushait',
                  );

                  _city?.blogCity();

                },
              ),

              /// READ CITIES
              WideButton(
                verse: Verse.plain('REAL Read CITIES'),
                onTap: () async {

                  final List<CityModel> _cities = await CityRealOps.readCities(
                    citiesIDs: [
                      'sau+al_dammam',
                      'egy+cairo',
                    ],
                  );

                  blog('read ${_cities.length} Cities');
                  // Mapper.blogMaps(_maps);

                  CityModel.blogCities(_cities);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// READ A COUNTRY CITIES
              WideButton(
                verse: Verse.plain('REAL Read Country Cities'),
                onTap: () async {

                  final List<CityModel> _cities = await CityRealOps.readCountryCities(
                    countryID: 'egy',
                  );

                  blog('read ${_cities.length} Cities');
                  // Mapper.blogMaps(_maps);

                  CityModel.blogCities(_cities);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// LDB INSERT CITIES
              WideButton(
                verse: Verse.plain('LDB Insert cities'),
                onTap: () async {

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.cities);


                  final List<CityModel> _cities = await CityRealOps.readCountryCities(
                    countryID: 'egy',
                  );
                  await CityLDBOps.insertCities(_cities);

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.cities);

                },
              ),

              /// LDB READ CITIES
              WideButton(
                verse: Verse.plain('LDB READ cities'),
                onTap: () async {

                  final List<CityModel> _cities = await CityLDBOps.readCities(
                    citiesIDs: [
                      'egy+kafr_el_sheikh',
                      'btn+jakar',
                      'cub+colon',
                      'egy+red_sea',
                    ],
                  );

                  CityModel.blogCities(_cities);

                },
              ),

            ],
          ),
        ),

        /// DISTRICTS OPS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Districts Ops'),
              ),

              /// FIX DISTRICTS PHRASES 2
              WideButton(
                verse: Verse.plain('read districts backups and create new real districts models'),
                color: Colorz.bloodTest,
                isActive: false,
                onTap: () async {

                  // final List<DistrictModel> _districts = await ZoneProtocols.fetchCountryDistricts('egy');

                  const String _countryID = 'sau';

                  final List<CityModel> _cities = await CityRealOps.readCountryCities(countryID: _countryID);
                  final List<String> _citiesIDs = CityModel.getCitiesIDs(_cities);


                  for (final String cityID in _citiesIDs){

                    final Object object = await Real.readPath(
                        path: 'citiesBackups/$cityID'
                    );

                    final Map<String, dynamic> cityMap = Mapper.getMapFromIHLMOO(
                      ihlmoo: object,
                    );

                    final Map<String, dynamic> _districtsMap = Mapper.getMapFromIHLMOO(
                      ihlmoo: cityMap['districts'],
                    );

                    final List<String> _districtsIDs = _districtsMap.keys.toList();

                    for (final String districtsID in _districtsIDs){

                      final Map<String, dynamic> _districtMap = Mapper.getMapFromIHLMOO(
                        ihlmoo: _districtsMap[districtsID],
                      );

                      final DistrictModel _districtModel = DistrictModel(
                        id: _districtMap['id'],
                        phrases: [
                          Phrase(
                            langCode: 'en',
                            value: _districtMap['phrases']['en'],
                            id: _districtMap['id'],
                          ),
                          Phrase(
                            langCode: 'ar',
                            value: _districtMap['phrases']['ar'],
                            id: _districtMap['id'],
                          ),
                        ],
                      );

                      await DistrictRealOps.createDistrict(
                        district: _districtModel,
                      );


                    }



                  }


                  // final List<Map<String, dynamic>> cities = Mapper.getMapsFromIHLMOO(
                  //   ihlmoo: object,
                  //   addChildrenIDs: false,
                  // );
                  //
                  // for (final Map<String, dynamic> city in cities){
                  //
                  //   // Mapper.blogMap(city);
                  //
                  //   final List<String> _districtsIDs = city.keys.toList();
                  //
                  //   for (int i = 0; i < _districtsIDs.length; i++){
                  //
                  //     final String _districtID = _districtsIDs[i];
                  //     blog('$i / ${_districtsIDs.length} : districtID : $_districtID');
                  //
                  //     final Map<String, dynamic> _enFireMap = await Fire.readDoc(
                  //       collName: FireColl.phrases_districts,
                  //       docName: '$_districtID+en',
                  //     );
                  //
                  //     final Map<String, dynamic> _arFireMap = await Fire.readDoc(
                  //       collName: FireColl.phrases_districts,
                  //       docName: '$_districtID+ar',
                  //     );
                  //
                  //     final DistrictModel _districtModel = DistrictModel(
                  //       id: _districtID,
                  //       phrases: [
                  //         Phrase(
                  //           langCode: 'en',
                  //           value: _enFireMap['value'],
                  //           id: _districtID,
                  //         ),
                  //         Phrase(
                  //           langCode: 'ar',
                  //           value: _arFireMap['value'],
                  //           id: _districtID,
                  //         ),
                  //       ],
                  //     );
                  //
                  //     _districtModel.blogDistrict();
                  //
                  //     // final Object _districtObject = city[_districtID];
                  //     //
                  //     // final Map<String, dynamic> _districtMap = Mapper.getMapFromIHLMOO(
                  //     //     ihlmoo: _districtObject,
                  //     // );
                  //     //
                  //     // Mapper.blogMap(_districtMap);
                  //
                  //     // blog('cityDistrictsMap[cityID] : ${cityDistrictsMap[cityID]}');
                  //
                  //     // final Map<String, dynamic> _districtMap = cityDistrictsMap[cityID];
                  //     //
                  //     // Mapper.blogMap(_districtMap);
                  //
                  //   }
                  //
                  // }

                },
              ),

              /// TAMAM : READ A DISTRICT
              WideButton(
                verse: Verse.plain('Read a DistrictModel'),
                onTap: () async {
                 final DistrictModel _district = await DistrictRealOps.readDistrict(
                   districtID: 'egy+alexandria+bulkly',
                 );
                  _district?.blogDistrict();
                },
              ),

              /// READ A DISTRICTS
              WideButton(
                verse: Verse.plain('Read a DistrictModelsss'),
                onTap: () async {

                  final List<DistrictModel> _districts = await DistrictRealOps.readDistricts(
                    districtsIDs: [
                      'egy+alexandria+bulkly',
                      'sau+al_duwadimi+al_harmin',
                    ],
                  );

                  DistrictModel.blogDistricts(_districts);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// READ DISTRICTS LEVELS
              WideButton(
                verse: Verse.plain('GET DISTRICTS LEVELS'),
                onTap: () async {

                  final ZoneLevel _districts = await DistrictsLevelsRealOps.readDistrictsLevels(
                    cityID: 'egy+alexandria',
                  );
                  _districts?.blogLeveL();

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// READ CITY DISTRICTS
              WideButton(
                verse: Verse.plain('READ CITY DISTRICTS'),
                onTap: () async {

                  final List<DistrictModel> _districts = await DistrictRealOps.readCityDistricts(
                    cityID: 'egy+alexandria',
                  );
                  DistrictModel.blogDistricts(_districts);

                },
              ),

              /// READ COUNTRY DISTRICTS
              WideButton(
                verse: Verse.plain('READ country DISTRICTS'),
                onTap: () async {

                  final List<DistrictModel> _districts = await DistrictRealOps.readCountryDistricts('egy');
                  DistrictModel.blogDistricts(_districts);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// LDB INSERT DISTRICT
              WideButton(
                verse: Verse.plain('LDB Insert ONE DISTRICT'),
                color: Colorz.green255,
                onTap: () async {

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.districts);

                  final List<DistrictModel> _diss = await DistrictRealOps.readCityDistricts(
                    cityID: 'egy+alexandria',
                  );
                  await DistrictLDBOps.insertDistrict(
                    districtModel: _diss.first,
                  );

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.districts);

                },
              ),

              /// LDB INSERT DISTRICTS
              WideButton(
                verse: Verse.plain('LDB Insert DISTRICTS'),
                color: Colorz.green255,
                onTap: () async {

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.districts);

                  final List<DistrictModel> _diss = await DistrictRealOps.readCityDistricts(
                    cityID: 'egy+alexandria',
                  );

                  await DistrictLDBOps.insertDistricts(
                    districts: _diss,
                  );

                  await LDBViewersScreen.goToLDBViewer(context, LDBDoc.districts);

                },
              ),

              /// LDB READ DISTRICT
              WideButton(
                verse: Verse.plain('LDB READ DISTRICT'),
                color: Colorz.green255,
                onTap: () async {

                  final DistrictModel _dis = await DistrictLDBOps.readDistrict(
                    districtID: 'egy+alexandria+victoria',
                  );
                  _dis?.blogDistrict();

                },
              ),

              /// LDB READ DISTRICTS
              WideButton(
                verse: Verse.plain('LDB READ DISTRICTS'),
                color: Colorz.green255,
                onTap: () async {

                  final List<DistrictModel> _dis = await DistrictLDBOps.readDistricts(
                    districtsIDs: [
                      'egy+alexandria+victoria',
                      'egy+alexandria+bulkly',
                    ],
                  );
                  DistrictModel.blogDistricts(_dis);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

              /// FIX DISTRICTS PHRASES
              WideButton(
                verse: Verse.plain('Fix egy districts phrases in FIRE'),
                color: Colorz.bloodTest,
                onTap: () async {

                  // final List<DistrictModel> _districts = await ZoneProtocols.fetchCountryDistricts('egy');

                  const String _countryID = 'sau';

                  final List<DistrictModel> _districts = await ZoneProtocols.fetchCountryDistricts(_countryID);

                  blog('read ${_districts.length} districts');

                  for (final DistrictModel _district in _districts) {

                    // _district.blogDistrict();

                    final List<Map<String, dynamic>> _maps = _district.toFirePhrasesMaps();

                    for (final Map<String, dynamic> _map in _maps) {

                      await Fire.createNamedDoc(
                          collName: FireColl.phrases_districts,
                          docName: _map['docName'],
                          input: Mapper.removePair(
                            map: _map,
                            fieldKey: 'docName',
                          ),
                      );

                      // Mapper.blogMap(_mapWithoutDocName);

                    }

                  }

                },
              ),

              // WideButton(
              //   verse: Verse.plain('clean fire districts egy'),
              //   color: Colorz.bloodTest,
              //   onTap: () async {
              //
              //     final List<Map<String, dynamic>> _maps = await Fire.superCollPaginator(
              //         queryModel: FireQueryModel(
              //           collRef: Fire.getCollectionRef(FireColl.phrases_districts),
              //           limit: 500,
              //           finders: const [
              //             FireFinder(field: 'countryID', comparison: FireComparison.equalTo, value: 'egy'),
              //           ],
              //           idFieldName: 'id',
              //         ),
              //         startAfter: null,
              //       addDocsIDs: true,
              //     );
              //
              //     for (final dynamic map in _maps){
              //
              //       await Fire.deleteDoc(collName: FireColl.phrases_districts, docName: map['id']);
              //
              //     }
              //
              //
              //
              //   },
              // ),


            ],
          ),
        ),

        /// CITIES LEVELS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Cities levels'),
              ),

              /// CREATE INITIAL CITIES LEVELS
              WideButton(
                verse: Verse.plain('Create initial cities levels'),
                isActive: false,
                onTap: () async {

                  /*
                  final List<String> _countriesIDs = Flag.getAllCountriesIDs();

                  for (int i = 0; i < _countriesIDs.length; i++){

                    final String countryID = _countriesIDs[i];
                    final List<CityModel> _cities = await ZoneRealOps.readCountryCities(countryID: countryID);
                    final List<String> _citiesIDs = CityModel.getCitiesIDs(_cities);

                    await Real.createDocInPath(
                      pathWithoutDocName: 'zones/citiesLevels',
                      docName: countryID,
                      addDocIDToOutput: false,
                      map: {
                        'hidden': _citiesIDs,
                        'inactive': <String>[],
                        'active': <String>[],
                        'public': <String>[],
                      },
                    );

                    blog('## ${i+1} / ${_countriesIDs.length} - Country is good : $countryID');
                  }


 */

                },
              ),

              /// READ CITIES LEVELS
              WideButton(
                verse: Verse.plain('Read Cities Levels'),
                onTap: () async {

                  final List<String> _countriesIDs = Flag.getAllCountriesIDs();

                  for (final String countryID in _countriesIDs){

                    final ZoneLevel _lvl = await CitiesLevelsRealOps.readCitiesLevels(countryID);
                    _lvl?.blogLeveL();

                    if (_lvl == null){
                      blog('NULL : for $countryID');
                    }

                  }

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

        /// COUNTRIES LEVELS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Countries levels'),
              ),

              /// CREATE INITIAL COUNTRIES LEVELS
              WideButton(
                verse: Verse.plain('Create initial Countries levels'),
                isActive: false,
                onTap: () async {

                  const List<Flag> _iso3s = allFlags;

                  final List<String> hidden = [];
                  final List<String> inactive = [];

                  for (final Flag iso3 in _iso3s){

                    if (
                    iso3.id == 'egy' ||
                        iso3.id == 'sau' ||
                        iso3.id == 'kwt' ||
                        iso3.id == 'and' ||
                        iso3.id == 'are' ||
                        iso3.id == 'bhr'
                    ){
                      inactive.add(iso3.id);
                    }

                    else {
                      hidden.add(iso3.id);
                    }

                  }

                  final ZoneLevel _lvl = ZoneLevel(
                    hidden: hidden,
                    inactive: inactive,
                    active: const [],
                    public: const [],
                  );

                  _lvl.blogLeveL();

                  await Real.createDocInPath(
                    pathWithoutDocName: 'zones',
                    docName: 'countriesLevels',
                    addDocIDToOutput: false,
                    map: _lvl.toMap(),
                  );

                },
              ),

              /// READ COUNTRIES LEVELS
              WideButton(
                verse: Verse.plain('Read Countries Levels'),
                onTap: () async {

                  final ZoneLevel _lvl = await CountriesLevelsRealOps.readCountriesLevels();
                  _lvl.blogLeveL();

                  final List<String> _countriesIDs = ZoneLevel(
                    hidden: _lvl.hidden,
                    inactive: _lvl.inactive,
                    active: null,
                    public: const [],
                  ).getAllIDs();

                  Stringer.blogStrings(strings: _countriesIDs, invoker: '');

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

        /// FLAGS
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Flag'),
              ),

              /// CREATE FLAGS
              WideButton(
                verse: Verse.plain('Create Flags'),
                onTap: () async {

                  const List<Flag> _iso3s = allFlags;

                  Flag.blogFlags(_iso3s);

                },
              ),

              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

        /// PLAY GROUND
        PageBubble(
          screenHeightWithoutSafeArea: _screenHeightWithoutSafeArea,
          appBarType: _appBarType,
          color: Colorz.white20,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              /// HEADLINE
              SuperHeadline(
                verse: Verse.plain('Play Ground'),
              ),

              /// CREATE INITIAL DISTRICTS
              WideButton(
                verse: Verse.plain('Create initial Districts'),
                onTap: () async {

                  const String _countryID = 'sau';

                  final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountryByLevel(
                    countryID: _countryID,
                  );

                  for (final CityModel cityModel in _cities){

                    final List<DistrictModel> _districts = cityModel.districts;

                    for (final DistrictModel district in _districts){

                      blog('${cityModel.cityID} : ${district.id}');

                      final String _districtID = district.id;

                      await Real.createDocInPath(
                          pathWithoutDocName: '${RealColl.zones}/${RealDoc.zones_districts}/$_countryID/${cityModel.cityID}',
                          docName: _districtID,
                          addDocIDToOutput: false,
                          map: district.toMap(
                              toJSON: true,
                              toLDB: false,
                          ),
                      );

                    }

                  }

                },
              ),

              /// SYMBOL TEST
              WideButton(
                verse: Verse.plain('Symbol test'),
                onTap: () async {

                  await Real.createDocInPath(
                    pathWithoutDocName: 'zzzzzzzz',
                    docName: 'xxx+yyy+zzz',
                    addDocIDToOutput: false,
                    map: {
                      'yy=zz' : 3,
                      'bb*uuu' : 4,
                      'ss&tt' : 5,
                      'ee@ee' : {
                        'fuck' : {'e' : 'ffff'},
                        'fff': 34333,
                      },
                    },
                  );

                },
              ),

              /// DELETE PATH TEST
              WideButton(
                verse: Verse.plain('Delete path test'),
                onTap: () async {

                  await Real.deletePath(
                    pathWithDocName: 'zzzzzzzz/xxx+yyy+zzz/ee@ee',
                  );

                },
              ),

              /// REAL OVERRIDE TEST
              WideButton(
                verse: Verse.plain('Real override test'),
                onTap: () async {

                  await Real.createDocInPath(
                    pathWithoutDocName: 'zzzzzzzz',
                    docName: 'xxx+yyy+zzz',
                    addDocIDToOutput: false,
                    map: {
                      's' : 3,
                      // 'bb*uuu' : 4,
                      // 'ss&tt' : 5,
                      // 'ee@ee' : {
                      //   'xx' : 3,
                      //   'yy' : 4,
                      // },
                    },
                  );


                },
              ),

              /// FIX CITIES IDS
              WideButton(
                verse: Verse.plain('FIX CITIES IDS AND CREATE FIRE PHRASES'),
                onTap: () async {

               final List<String> _countriesIDs = Flag.getAllCountriesIDs();
               _countriesIDs.remove('egy');

               for (int i = 0; i < _countriesIDs.length; i++){

                 final String countryID = _countriesIDs[i];

                 final List<CityModel> _countryCities = await ZoneProtocols.fetchCitiesFromAllOfCountry(
                   countryID: countryID,
                 );

                 for (int i = 0; i < _countryCities.length; i++){

                   final CityModel city = _countryCities[i];
                   final String _oldID = city.cityID;
                   String _newCityID = _oldID;
                   final bool _isAlreadyNewID = TextCheck.stringContainsSubString(string: _oldID, subString: '+');

                   if (_isAlreadyNewID == true){
                     _newCityID = _oldID;
                   }

                   else {

                     final String _cityPortion = TextMod.removeTextBeforeFirstSpecialCharacter(_oldID, '_');
                     _newCityID = CityModel.createCityID(
                       countryID: countryID,
                       cityEnName: _cityPortion,
                     );

                     await Future.wait(<Future>[

                       /// TAMAM : FIRE CITY PHRASES
                       createCityPhrases(
                         countryID: countryID,
                         city: city.copyWith(cityID: _newCityID,),
                         newCItyID: _newCityID,
                       ),

                       /// TAMAM : CREATE NEW REAL CITY MODELS
                       createNewCityModel(
                         countryID: countryID,
                         city: city.copyWith(cityID: _newCityID,),
                         newCityID: _newCityID,
                       ),

                       /// TAMAM : REMOVE OLD REAL CITY MODEL
                       removeOldCityModel(
                         countryID: countryID,
                         oldCityID: _oldID,
                       ),

                       /// TAMAM : CREATE OLD MODEL BACKUP
                       createCityBackup(
                         countryID: countryID,
                         city: city.copyWith(cityID: _newCityID,),
                       ),

                       /// TAMAM FIRE DISTRICTS PHRASES
                       createDistrictPhrasesModelsAndEverything(
                         countryID: countryID,
                         city: city.copyWith(cityID: _newCityID,),
                       ),

                       /// TAMAM : DISTRICTS LEVELS
                       createDistrictsLevels(
                         countryID: countryID,
                         city: city.copyWith(cityID: _newCityID,),
                       ),


                     ])
                         .then((value) => blog(
                         '##      ======= >>>>>>> ${i+1} / ${_countryCities.length} : DONE : $_newCityID'
                     )
                     );


                   }

                 }


                 blog('#######      ================ >>>>>>> $i / ${_countriesIDs.length} : DONE : $countryID');

                 unawaited(Dialogs.showSuccessDialog(context: context, firstLine: Verse.plain('$i / ${_countriesIDs.length} : countryID')),);

               }

                },
              ),

              /// TAMAM : CHECK ALL CITIES IDS ARE GOOD
              WideButton(
                verse: Verse.plain('Check all cities ids are good'),
                onTap: () async {

                  final List<String> _countriesIDs = Flag.getAllCountriesIDs();

                  for (final String countryID in _countriesIDs){

                    blog('===========================> STARTING : $countryID');

                    final List<CityModel> _cities = await CityRealOps.readCountryCities(countryID: countryID);
                    bool _countryIsGood = true;

                    // -----------------

                    if (Mapper.checkCanLoopList(_cities) == true){

                      for (final CityModel city in _cities){

                        final bool _isGood = TextCheck.stringContainsSubString(
                          string: city.cityID,
                          subString: '+',
                        );

                        if (_isGood == true){
                          blog('00 - GOOD : ${city.cityID}');
                        }

                        else {
                          blog('xx - BAD : $countryID : (${city.cityID})');
                          _countryIsGood = false;
                          // await Dialogs.topNotice(
                          //     context: context,
                          //     color: Colorz.red255,
                          //     verse: Verse.plain('BAD : ${city.cityID}'),
                          // );
                        }

                      }

                    }

                    else {
                      blog('xxx! - COUNTRY : $countryID : NO CITIES FOUND, take a fucking note');
                    }

                    // -----------------

                    if (_countryIsGood == true){
                      blog('## 000 - Country is good : $countryID');
                    }

                    else {
                      blog('## xxx! - COUNTRY : $countryID : IS BAD : has old cities IDs, take a fucking note');
                    }

                  }

                },
              ),



              /// SEPARATOR
              const SeparatorLine(),

            ],
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
