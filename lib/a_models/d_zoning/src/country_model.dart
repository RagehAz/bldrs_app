part of world_zoning;

/// => TAMAM
@immutable
class CountryModel {
  /// --------------------------------------------------------------------------
  const CountryModel({
    required this.id,
    required this.citiesIDs,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final StagingModel? citiesIDs;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CountryModel copyWith({
    String? id,
    StagingModel? citiesIDs,
  }){
    return CountryModel(
      id: id ?? this.id,
      citiesIDs: citiesIDs ?? this.citiesIDs,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toLDB,
  }) {
    return <String, dynamic>{
      'id': id,
      'citiesIDs': citiesIDs?.toMap(
        toLDB: toLDB,
      ),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CountryModel? decipherCountryMap({
    required Map<String, dynamic>? map,
  }) {
    CountryModel? _countryModel;

    if (map != null) {

      _countryModel = CountryModel(
        id: map['id'],
        citiesIDs: StagingModel.decipher(
          id: map['id'],
          map: map['citiesIDs'],
        ),
      );
    }

    return _countryModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CountryModel> decipherCountriesMaps({
    required List<Map<String, dynamic>>? maps,
  }) {
    final List<CountryModel> _countries = <CountryModel>[];

    if (Lister.checkCanLoop(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {

        final CountryModel? _map = decipherCountryMap(
          map: map,
        );

        if (_map != null){
          _countries.add(_map);
        }

      }
    }

    return _countries;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCountry({String invoker = 'PRINTING COUNTRY'}) {
    blog('$invoker ------------------------------------------- START');

    blog('  id : $id');
    citiesIDs?.blogStaging();

    blog('$invoker ------------------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCountries(List<CountryModel> countries){

    if (Lister.checkCanLoop(countries) == true){

      for (final CountryModel country in countries){

        country.blogCountry();

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool countriesIDsAreIdentical(CountryModel? country1, CountryModel? country2) {
    bool _identical = false;

    if (country1 == null && country2 == null){
      _identical = true;
    }
    else if (country1 != null && country2 != null) {
      if (country1.id == country2.id) {
        _identical = true;
      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCountriesAreIdentical(CountryModel? country1, CountryModel? country2) {
    bool _identical = false;

    if (country1 == null && country2 == null){
      _identical = true;
    }
    else if (country1 != null && country2 != null) {
      if (
          country1.id == country2.id &&
          StagingModel.checkStagingsAreIdentical(country1.citiesIDs, country2.citiesIDs) == true
      ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Phrase? getCountryPhrase({
    required String? countryID,
    required String langCode,
  }){
    Phrase? _output;

    if (countryID != null) {

      if (countryID == Flag.planetID){
        _output = Phrase(
          id: Flag.planetID,
          value: ZoneModel.planetZone.countryName,
          langCode: langCode,
        );
      }

      else if (America.checkCountryIDIsStateID(countryID) == true){
        return Phrase(
          value: America.getStateName(
            stateID: countryID,
            withISO2: America.useISO2,
          ),
          id: countryID,
          langCode: 'en',
        );
      }

      else {
        final Flag? _flag = Flag.getFlagFromFlagsByCountryID(
          flags: allFlags,
          countryID: countryID,
        );

        _output = Phrase.searchPhraseByIDAndLangCode(
            phrases: _flag?.phrases,
            phid: _flag?.id,
            langCode: langCode
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? translateCountry({
    required String? countryID,
    required String langCode,
  }){

    if (countryID == Flag.planetID){
      return ZoneModel.planetZone.countryName;
    }
    else {
      final Phrase? _phrase = getCountryPhrase(
        countryID: countryID,
        langCode: langCode,
      );

      return _phrase?.value;
    }

  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllCountriesIDsSortedByName({
    required String langCode,
    required bool addUSAStates,
  }){

    final List<String> _allCountriesIDs = Flag.getAllCountriesIDs();
    if (addUSAStates == true){
      _allCountriesIDs.addAll(America.getStatesIDs());
    }

    final List<Phrase> _allCountriesPhrasesInCurrentLang = <Phrase>[];

    for (final String id in _allCountriesIDs){

      final String? _countryName = translateCountry(
        langCode: langCode,
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

      if (phrase.id != null){
        _sortedCountriesIDs.add(phrase.id!);
      }

    }

    return _sortedCountriesIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> sortCountriesNamesAlphabetically({
    required List<String>? countriesIDs,
    required String langCode,
  }){
    final List<String> _output = <String>[];

    if (Lister.checkCanLoop(countriesIDs) == true){

      final List<String> _allIDsSorted = getAllCountriesIDsSortedByName(
        langCode: langCode,
        addUSAStates: true,
      );

      for (final String sortedID in _allIDsSorted){

        final bool _isInList = Stringer.checkStringsContainString(
            strings: countriesIDs,
            string: sortedID,
        );

        if (_isInList == true){
          _output.add(sortedID);
        }

      }

    }


    return _output;
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
      citiesIDs.hashCode;
  // -----------------------------------------------------------------------------
}
