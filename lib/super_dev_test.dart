import 'dart:async';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  // const String _path = '/assets/countries/deu.json';
  // final String _jsonStringValues = await rootBundle.loadString(_path);
  // final Map<String, dynamic> _mappedJson = json.decode(_jsonStringValues);
  //
  // Mapper.blogMap(_mappedJson);

  // final List<String> _countriesIDs = Flag.getAllCountriesIDs();
  //
  // for (int i = 0; i < _countriesIDs.length; i++){
  //
  //   final String countryID = _countriesIDs[i];
  //
  //   final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountry(
  //       countryID: countryID,
  //       // cityStageType:
  //   );
  //
  //   final List<Map<String, dynamic>> _maps = CityModel.cipherCities(
  //       cities: _cities,
  //       toJSON: true,
  //       toLDB: true,
  //   );
  //
  //   final Map<String, dynamic> _map = {
  //     countryID: _maps,
  //   };
  //
  //   final bool _success = await Filers.exportJSON(
  //     context: getMainContext(),
  //     map: _map,
  //     fileName: countryID,
  //     exportToPath: '/storage/emulated/0/Misc/countries',
  //   );
  //
  //   if (_success == true){
  //     unawaited(Dialogs.topNotice(
  //       verse: Verse.plain('$countryID.json is exported'),
  //     ));
  //   }
  //
  //   blog('DONE ( ${i+1} / ${_countriesIDs.length} ) : $countryID');
  //
  // }

}
