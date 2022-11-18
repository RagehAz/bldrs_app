import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/a_models/d_zone/city_model.dart';
import 'package:bldrs/a_models/d_zone/continent_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/d_zone/region_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

@immutable
class CountryModel {
  /// --------------------------------------------------------------------------
  const CountryModel({
    @required this.id,
    @required this.region,
    @required this.continent,
    @required this.isActivated,
    @required this.isGlobal,
    @required this.citiesIDs,
    @required this.language,
    @required this.currency,
    @required this.phrases,
    @required this.iso2,
    @required this.phoneCode,
    @required this.capital,
    @required this.langCodes,
    @required this.areaSqKm,
    @required this.internetUsers,
    @required this.gdp, // in Millions
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String region;
  final String continent;

  /// manual dashboard switch to deactivate an entire country
  final bool isActivated;

  /// automatic switch when country reaches 'Global target' ~ 10'000 flyers
  /// then country flyers will be visible to other countries users 'bzz & users'
  final bool isGlobal;
  final List<String> citiesIDs;
  final String language;
  final String currency;
  /// mixed languages country names
  final List<Phrase> phrases;

  final String iso2;
  final String phoneCode;
  final String capital;
  final String langCodes;
  final int areaSqKm;
  final int internetUsers;
  final double gdp;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  CountryModel copyWith({
    String id,
    String region,
    String continent,
    bool isActivated,
    bool isGlobal,
    List<String> citiesIDs,
    String language,
    String currency,
    List<Phrase> phrases,
    String iso2,
    String phoneCode,
    String capital,
    String langCodes,
    int areaSqKm,
    int internetUsers,
    double gdp,
  }){
    return CountryModel(
      id: id ?? this.id,
      region: region ?? this.region,
      continent: continent ?? this.continent,
      isActivated: isActivated ?? this.isActivated,
      isGlobal: isGlobal ?? this.isGlobal,
      citiesIDs: citiesIDs ?? this.citiesIDs,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      phrases: phrases ?? this.phrases,
      iso2: iso2 ?? this.iso2,
      phoneCode: phoneCode ?? this.phoneCode,
      capital: capital ?? this.capital,
      langCodes: langCodes ?? this.langCodes,
      areaSqKm: areaSqKm ?? this.areaSqKm,
      internetUsers: internetUsers ?? this.internetUsers,
      gdp: gdp ?? this.gdp,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap({
    @required bool includePhrasesTrigrams,
  }) {
    return <String, dynamic>{
      'id': id,
      'region': region,
      'continent': continent,
      'isActivated': isActivated,
      'isGlobal': isGlobal,
      'citiesIDs': citiesIDs,
      'language': language,
      'currency': currency,
      'phrases' : cipherZonePhrases(
        phrases: phrases,
        includeTrigram: includePhrasesTrigrams,
      ),
      'iso2' : iso2,
      'phoneCode' : phoneCode,
      'capital' : capital,
      'langCodes' : langCodes,
      'areaSqKm' : areaSqKm,
      'internetUsers' : internetUsers,
      'gdp' : gdp,
    };
  }
  // --------------------
  static CountryModel decipherCountryMap({
    @required Map<String, dynamic> map,
  }) {

    CountryModel _countryModel;

    if (map != null) {

      _countryModel = CountryModel(
        id: map['id'],
        region: map['region'],
        continent: map['continent'],
        isActivated: map['isActivated'],
        isGlobal: map['isGlobal'],
        citiesIDs: Stringer.getStringsFromDynamics(dynamics: map['citiesIDs']),
        language: map['language'],
        currency: map['currency'],
        phrases: decipherZonePhrases(
          phrasesMap: map['phrases'],
          zoneID: map['id'],
        ),
        iso2 : map['iso2'],
        phoneCode : map['phoneCode'],
        capital : map['capital'],
        langCodes : map['langCodes'],
        areaSqKm : map['areaSqKm'],
        internetUsers : map['internetUsers'],
        gdp : map['gdp'],
      );
    }

    return _countryModel;
  }
  // --------------------
  static List<CountryModel> decipherCountriesMaps({
    @required List<Map<String, dynamic>> maps,
  }) {
    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _countries.add(
            decipherCountryMap(
              map: map,
            )
        );
      }
    }

    return _countries;
  }
  // -----------------------------------------------------------------------------

  /// COUNTRY PHRASES CYPHERS

  // --------------------
  /// phrases contain mixed languages phrases in one list
  static Map<String, dynamic> cipherZonePhrases({
    @required List<Phrase> phrases,
    @required bool includeTrigram,
  }){
    Map<String, dynamic> _output = {};

    if (Mapper.checkCanLoopList(phrases) == true){

      for (final Phrase phrase in phrases){

        _output = Mapper.insertPairInMap(
          map: _output,
          key: phrase.langCode,
          value: phrase.toMap(
            includeID: false,
            includeTrigram: includeTrigram,
            // includeLangCode: false,
          ),
        );

      }

    }

    return _output;
  }
  // --------------------
  static List<Phrase> decipherZonePhrases({
    @required Map<String, dynamic> phrasesMap,
    @required String zoneID,
  }){

    final List<Phrase> _output = <Phrase>[];

    if (phrasesMap != null){

      final List<String> _keys = phrasesMap.keys.toList(); // lang codes

      if (Mapper.checkCanLoopList(_keys) == true){

        for (final String key in _keys){

          final Phrase _phrase = Phrase(
            id: zoneID,
            langCode: key,
            value: phrasesMap[key]['value'],
            trigram: Stringer.createTrigram(
              input: TextMod.fixCountryName(phrasesMap[key]['value']),
            ),
          );

          _output.add(_phrase);

        }

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool countriesIDsIncludeCountryID({
    @required List<String> countriesIDs,
    @required String countryID,
  }) {
    bool _includes = false;

    for (final String id in countriesIDs) {
      if (id == countryID) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool countriesIDsAreTheSame(CountryModel country1, CountryModel country2) {
    bool _areTheSame = false;

    if (country1 != null && country2 != null) {
      if (country1.id == country2.id) {
        _areTheSame = true;
      }
    }

    return _areTheSame;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCountriesAreIdentical(CountryModel country1, CountryModel country2) {
    bool _identical = false;

    if (country1 == null && country2 == null){
      _identical = true;
    }
    else if (country1 != null && country2 != null) {
      if (
      country1.id == country2.id
          &&
          country1.continent == country2.continent
          &&
          country1.region == country2.region
          &&
          country1.currency == country2.currency
          &&
          country1.language == country2.language
          &&
          Phrase.checkPhrasesListsAreIdentical(
            phrases1: country1.phrases,
            phrases2: country2.phrases,
          ) == true
          &&
          country1.isActivated == country2.isActivated
          &&
          country1.isGlobal == country2.isGlobal
          &&
          Mapper.checkListsAreIdentical(
              list1: country1.citiesIDs,
              list2: country2.citiesIDs
          ) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateCountryName({
    @required BuildContext context,
    @required String countryID
  }) {

    String _countryName = '...';

    if (countryID != null) {
      _countryName = Localizer.translate(context, countryID);
    }

    return _countryName;
  }
  // --------------------
  static List<String> getCountriesIDsOfContinent(Continent continent) {
    final List<String> _countriesIDs = <String>[];

    for (final Region region in continent.regions) {
      _countriesIDs.addAll(region.countriesIDs);
    }

    return _countriesIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllCountriesIDs() {
    final List<String> _ids = <String>[];

    for (final Flag flag in Flag.allFlags) {
      _ids.add(flag.countryID);
    }

    return _ids;
  }
  // --------------------
  static String getCountryPhoneCode(String countryID) {

    const Map<String , dynamic> _phoneCodes =  <String, dynamic>{
      'ala': '+358',
      'alb': '+355',
      'dza': '+213',
      'asm': '+1',
      'and': '+376',
      'ago': '+244',
      'aia': '+1',
      'atg': '+1',
      'arg': '+54',
      'arm': '+374',
      'abw': '+297',
      'aus': '+61',
      'aut': '+43',
      'aze': '+994',
      'bhs': '+1',
      'bhr': '+973',
      'bgd': '+880',
      'brb': '+1-246',
      'blr': '+375',
      'bel': '+32',
      'blz': '+501',
      'ben': '+229',
      'bmu': '+1',
      'btn': '+975',
      'bol': '+591',
      'bes': '+599',
      'bih': '+387',
      'bwa': '+267',
      'bvt': '+55',
      'bra': '+55',
      'iot': '+246',
      'brn': '+673',
      'bgr': '+359',
      'bfa': '+226',
      'bdi': '+257',
      'cpv': '+238',
      'khm': '+855',
      'cmr': '+237',
      'can': '+1',
      'cym': '+1',
      'caf': '+236',
      'tcd': '+235',
      'chl': '+56',
      'chn': '+86',
      'cxr': '+61',
      'cck': '+61',
      'col': '+57',
      'com': '+269',
      'cog': '+242',
      'cod': '+243',
      'cok': '+682',
      'cri': '+506',
      'civ': '+225',
      'hrv': '+385',
      'cub': '+53',
      'cuw': '+599',
      'cyp': '+357',
      'cze': '+420',
      'dnk': '+45',
      'dji': '+253',
      'dma': '+1',
      'dom': '+1',
      'ecu': '+593',
      'egy': '+2',
      'slv': '+503',
      'gnq': '+240',
      'eri': '+291',
      'est': '+372',
      'swz': '+268',
      'eth': '+251',
      'flk': '+500',
      'fro': '+298',
      'fji': '+679',
      'fin': '+358',
      'fra': '+33',
      'guf': '+594',
      'pyf': '+689',
      'atf': '+262',
      'gab': '+241',
      'gmb': '+220',
      'geo': '+995',
      'deu': '+49',
      'gha': '+233',
      'gib': '+350',
      'grc': '+30',
      'grl': '+299',
      'grd': '+1',
      'glp': '+590',
      'gum': '+1',
      'gtm': '+502',
      'ggy': '+44-1481',
      'gin': '+224',
      'gnb': '+245',
      'guy': '+592',
      'hti': '+509',
      'hmd': '+0',
      'vat': '+379',
      'hnd': '+504',
      'hkg': '+852',
      'hun': '+36',
      'isl': '+354',
      'ind': '+91',
      'idn': '+62',
      'irn': '+98',
      'irq': '+964',
      'irl': '+353',
      'imn': '+44-1624',
      'isr': '+972',
      'ita': '+39',
      'jam': '+1',
      'jpn': '+81',
      'jey': '+44-1534',
      'jor': '+962',
      'kaz': '+7',
      'ken': '+254',
      'kir': '+686',
      'prk': '+850',
      'kor': '+82',
      'kwt': '+965',
      'kgz': '+996',
      'lao': '+856',
      'lva': '+371',
      'lbn': '+961',
      'lso': '+266',
      'lbr': '+231',
      'lby': '+218',
      'lie': '+423',
      'ltu': '+370',
      'lux': '+352',
      'mac': '+853',
      'mdg': '+261',
      'mwi': '+265',
      'mys': '+60',
      'mdv': '+960',
      'mli': '+223',
      'mlt': '+356',
      'mhl': '+692',
      'mtq': '+596',
      'mrt': '+222',
      'mus': '+230',
      'myt': '+262',
      'mex': '+52',
      'fsm': '+691',
      'mda': '+373',
      'mco': '+377',
      'mng': '+976',
      'mne': '+382',
      'msr': '+1',
      'mar': '+212',
      'moz': '+258',
      'mmr': '+95',
      'nam': '+264',
      'nru': '+674',
      'npl': '+977',
      'nld': '+31',
      'ncl': '+687',
      'nzl': '+64',
      'nic': '+505',
      'ner': '+227',
      'nga': '+234',
      'niu': '+683',
      'nfk': '+672',
      'mkd': '+389',
      'mnp': '+1',
      'nor': '+47',
      'omn': '+968',
      'pak': '+92',
      'plw': '+680',
      'pse': '+970',
      'pan': '+507',
      'png': '+675',
      'pry': '+595',
      'per': '+51',
      'phl': '+63',
      'pcn': '+64',
      'pol': '+48',
      'prt': '+351',
      'pri': '+1',
      'qat': '+974',
      'reu': '+262',
      'rou': '+40',
      'rus': '+7',
      'rwa': '+250',
      'blm': '+590',
      'shn': '+290',
      'kna': '+1',
      'lca': '+1',
      'maf': '+590',
      'spm': '+508',
      'vct': '+1',
      'wsm': '+685',
      'smr': '+378',
      'stp': '+239',
      'sau': '+966',
      'sen': '+221',
      'srb': '+381',
      'syc': '+248',
      'sle': '+232',
      'sgp': '+65',
      'sxm': '+1',
      'svk': '+421',
      'svn': '+386',
      'slb': '+677',
      'som': '+252',
      'zaf': '+27',
      'sgs': '+500',
      'ssd': '+211',
      'esp': '+34',
      'lka': '+94',
      'sdn': '+249',
      'sur': '+597',
      'sjm': '+47',
      'swe': '+46',
      'che': '+41',
      'syr': '+963',
      'twn': '+886',
      'tjk': '+992',
      'tza': '+255',
      'tha': '+66',
      'tls': '+670',
      'tgo': '+228',
      'tkl': '+690',
      'ton': '+676',
      'tto': '+1',
      'tun': '+216',
      'tur': '+90',
      'tkm': '+993',
      'tca': '+1',
      'tuv': '+688',
      'uga': '+256',
      'ukr': '+380',
      'are': '+971',
      'gbr': '+44',
      'usa': '+1',
      'umi': '+1',
      'ury': '+598',
      'uzb': '+998',
      'vut': '+678',
      'ven': '+58',
      'vnm': '+84',
      'vgb': '+1',
      'vir': '+1',
      'wlf': '+681',
      'esh': '+212',
      'yem': '+967',
      'zmb': '+260',
      'zwe': '+263',
      'euz': '',
      'xks': '+383',
      'afg': '+93',
    };

    final String _code = _phoneCodes[countryID];

    return _code;
  }
  // --------------------
  static List<MapModel> getAllCountriesNamesMapModels(BuildContext context) {

    final List<MapModel> _mapModels = <MapModel>[];

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    for (final String id in _allCountriesIDs) {

      final String _countryName = translateCountryName(
        context: context,
        countryID: id,
      );

      _mapModels.add(
          MapModel(
            key: id,
            value: _countryName,
          )
      );

    }

    return _mapModels;
  }
  // --------------------
  static List<String> getAllCountriesIDsSortedByName(BuildContext context){

    final List<String> _allCountriesIDs = getAllCountriesIDs();

    final List<Phrase> _allCountriesPhrasesInCurrentLang = <Phrase>[];

    for (final String id in _allCountriesIDs){

      final String _countryName = translateCountryName(
        context: context,
        countryID: id,
      );

      final Phrase _phrase = Phrase(
        id: id,
        value: _countryName,
      );

      if (_countryName != null){
        _allCountriesPhrasesInCurrentLang.add(_phrase);
      }
    }

    final List<Phrase> _namesSorted = Phrase.sortNamesAlphabetically(_allCountriesPhrasesInCurrentLang);

    final List<String> _sortedCountriesIDs = <String>[];

    for (final Phrase phrase in _namesSorted){

      _sortedCountriesIDs.add(phrase.id);

    }

    return _sortedCountriesIDs;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  void blogCountry({String invoker = 'PRINTING COUNTRY'}) {
    blog('$invoker ------------------------------------------- START');

    blog('  id : $id');
    blog('  region : $region');
    blog('  continent : $continent');
    blog('  isActivated : $isActivated');
    blog('  isGlobal : $isGlobal');
    blog('  citiesIDs : ${citiesIDs.length} cities');
    blog('  language : $language');
    blog('  currency : $currency');
    blog('  iso2 : $iso2');
    blog('  phoneCode : $phoneCode');
    blog('  capital : $capital');
    blog('  langCodes : $langCodes');
    blog('  areaSqKm : $areaSqKm');
    blog('  internetUsers : $internetUsers');
    blog('  gdp : $gdp');

    Phrase.blogPhrases(phrases);

    blog('$invoker ------------------------------------------- END');
  }
  // --------------------
  static void blogCountries(List<CountryModel> countries){

    if (Mapper.checkCanLoopList(countries) == true){

      for (final CountryModel country in countries){

        country.blogCountry();

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// COUNTRY PHRASE CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> _createCountriesPhrasesByLangCode({
    @required String langCode,
    @required List<String> countriesIDs,
  }) async {

    final List<Phrase> _output = <Phrase>[];
    final Map<String, String> _jsonMap = await Localizer.getJSONLangMap(
      langCode: langCode,
    );

    for (final String id in countriesIDs){

      final String _countryName = _jsonMap[id];

      final Phrase _phrase = Phrase(
        id: id,
        value: _countryName,
        langCode: langCode,
        trigram: Stringer.createTrigram(input: _countryName),
      );

      _output.add(_phrase);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> createMixedCountriesPhrases({
    @required List<String> langCodes,
    @required List<String> countriesIDs,
  }) async {

    final List<Phrase> _countriesPhrases = <Phrase>[];

    if (Mapper.checkCanLoopList(langCodes) == true){

      for (final String langCode in langCodes){
        final List<Phrase> _phrases = await _createCountriesPhrasesByLangCode(
          langCode: langCode,
          countriesIDs: countriesIDs,
        );
        _countriesPhrases.addAll(_phrases);
      }

    }

    return _countriesPhrases;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CountryModel){
      _areIdentical = checkCountriesAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      region.hashCode^
      continent.hashCode^
      isActivated.hashCode^
      isGlobal.hashCode^
      citiesIDs.hashCode^
      language.hashCode^
      currency.hashCode^
      phrases.hashCode^
      iso2.hashCode^
      phoneCode.hashCode^
      capital.hashCode^
      langCodes.hashCode^
      areaSqKm.hashCode^
      internetUsers.hashCode^
      gdp.hashCode;
  // -----------------------------------------------------------------------------
}

@immutable
class AmericanState extends CountryModel {
  /// --------------------------------------------------------------------------
  const AmericanState({
    @required this.state,
    @required this.cities,
  });
  /// --------------------------------------------------------------------------
  final String state;
  final List<CityModel> cities;
  /// --------------------------------------------------------------------------
}
