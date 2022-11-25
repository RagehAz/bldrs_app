import 'dart:convert';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/centered_list_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/c_protocols/zone_protocols/json/zone_json_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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

  ZoneModel _bubbleZone;

  // -----------------------------------------------------------------------------
  /// DONE : KEEP FOR REFERENCE
  Future<void> _createISO3JSONBlog() async {
    blog('CREATE ISO3 MAP : START');

    /*
    final int _totalLength = CountryModel.getAllCountriesIDs().length;
    final List<ISO3> _iso3s = [];

    // final List<CountryModel> _allCountries =
    await ExoticMethods.fetchAllCountryModels(
      onRead: (int index, CountryModel countryModel) async {

        ISO3 _iso3;

        if (countryModel != null){
          _iso3 = ISO3(
            id: countryModel.id,
            iso2: countryModel.iso2 ?? xGetIso2(countryModel.id),
            flag: Flag.getFlagIcon(countryModel.id),
            region: countryModel.region,
            continent: countryModel.continent,
            language: countryModel.language,
            currencyID: countryModel.currency ?? BigMac.getCurrencyByCountryIdFromBigMacs(
              countryID: countryModel.id,
            ),
            phoneCode: countryModel.phoneCode ?? CountryModel.getCountryPhoneCode(countryModel.id),
            capital: countryModel.capital ?? xGetCapital(countryModel.id),
            langCodes: countryModel.langCodes ?? xGetLangs(countryModel.id),
            areaSqKm: countryModel.areaSqKm ?? xGetAreaKM(countryModel.id),
            phrases: countryModel.phrases,
          );

        }

        if (_iso3 != null && _iso3.iso2 != null){
          _iso3s.add(_iso3);
          blog('DONE : #${index + 1} / $_totalLength');
        }
        else {
          blog('SKIP : #${index + 1} / $_totalLength');
        }

      },
    );

    blog('done with ${_iso3s.length} iso3s');


    ISO3.blogISO3sToJSON(_iso3s);
     */
    blog('CREATE ISO3 MAP : END : already done and kept for reference');
  }
  // --------------------
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

    final List<Continent> _allContinents = await ZoneProtocols.fetchContinents();

    final Map<String, dynamic> _map = Continent.cipherContinents(_allContinents);
    final String _json = json.encode(_map);

    blog(_json);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      pageTitleVerse: Verse.plain('Zoning Lab'),
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.crystalYellow,
      layoutWidget: FloatingCenteredList(
        columnChildren: <Widget>[

          // -----------------------------------

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

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE ISO3 JSON
          WideButton(
            verse: Verse.plain('Create ISO3 map'),
            onTap: _createISO3JSONBlog,
          ),

          /// GET ISO3 JSON
          WideButton(
            verse: Verse.plain('Get ISO3 JSON map'),
            onTap: () async {

              final List<Flag> _iso3s = await ZoneJSONOps.readAllISO3s();
              Flag.blogFlags(_iso3s);

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE CURRENCIES JSON
          WideButton(
            verse: Verse.plain('Create Currencies JSON'),
            onTap: _createCurrenciesJSON,
          ),

          /// GET CURRENCIES JSON
          WideButton(
            verse: Verse.plain('Get Currencies JSON map'),
            onTap: () async {

              final List<CurrencyModel> _currencies = await ZoneJSONOps.readAllCurrencies();
              blog('start');
              CurrencyModel.blogCurrencies(_currencies);
              blog('end');
            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE CURRENCIES JSON
          WideButton(
            verse: Verse.plain('Create CONTINENTS JSON'),
            onTap: _createContinentsJSONMap,
          ),

          /// GET CONTINENTS JSON
          WideButton(
            verse: Verse.plain('Get CONTINENTS JSON map'),
            onTap: () async {

              final List<Continent> _continents = await ZoneJSONOps.readAllContinents();
              blog('start');

              Continent.blogContinents(_continents);

              blog('end');
            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

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

          /// READ A COUNTRY CITIES
          WideButton(
            verse: Verse.plain('Read Country Cities'),
            onTap: () async {

              final dynamic _dynamic = await Real.readPath(
                  path: 'zones/cities/bra',
              );

              final List<Map<String, dynamic>> _maps = Mapper.getMapsFromInternalHashLinkedMapObjectObject(
                internalHashLinkedMapObjectObject: _dynamic,
              );

              blog('read ${_maps.length} maps');
              // Mapper.blogMaps(_maps);

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE INITIAL CITIES LEVELS
          WideButton(
            verse: Verse.plain('Create initial cities levels'),
            isActive: false,
            onTap: () async {

              /*
              await ExoticMethods.fetchAllCountryModels(
                onRead: (int index, CountryModel countryModel) async {

                  await Real.createDocInPath(
                      pathWithoutDocName: 'zones/citiesLevels',
                      docName: countryModel.id,
                      addDocIDToOutput: false,
                      map: {
                        'hidden': countryModel.citiesIDs,
                        'inactive': <String>[],
                        'active': <String>[],
                        'public': <String>[],
                      },
                  );

                },
              );

 */

            },
          ),

          /// READ CITIES LEVELS
          WideButton(
            verse: Verse.plain('Read Cities Levels'),
            onTap: () async {

              final dynamic _dynamic = await Real.readPath(
                path: 'zones/citiesLevels',
              );

              final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
                internalHashLinkedMapObjectObject: _dynamic,
              );

              if (_map != null){

                final List<String> _countriesIDs = _map.keys.toList();

                for (final String countryID in _countriesIDs){

                  final Map<String, dynamic> _countryMap = Mapper.getMapFromInternalHashLinkedMapObjectObject(
                    internalHashLinkedMapObjectObject: _map[countryID],
                  );

                  final ZoneLevel _lvl = ZoneLevel.decipher(_countryMap);
                  _lvl.blogLeveL();

                }

                blog('done with : ${_countriesIDs.length} countries');

              }

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE INITIAL COUNTRIES LEVELS
          WideButton(
            verse: Verse.plain('Create initial Countries levels'),
            isActive: false,
            onTap: () async {

              final List<Flag> _iso3s = await ZoneJSONOps.readAllISO3s();

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

              final dynamic _dynamic = await Real.readPath(
                path: 'zones/countriesLevels',
              );

              final Map<String, dynamic> _map = Mapper.getMapFromInternalHashLinkedMapObjectObject(
                internalHashLinkedMapObjectObject: _dynamic,
              );

              final ZoneLevel _lvl = ZoneLevel.decipher(_map);
              _lvl.blogLeveL();

            },
          ),

          // -----------------------------------

          /// SEPARATOR
          const SeparatorLine(),

          /// CREATE FLAGS
          WideButton(
            verse: Verse.plain('Create Flags'),
            onTap: () async {

              final List<Flag> _iso3s = await ZoneJSONOps.readAllISO3s();

              Flag.blogFlags(_iso3s);

            },
          ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
