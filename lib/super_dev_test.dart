import 'dart:async';
import 'package:basics/bldrs_theme/assets/planet/paths.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

/// SUPER_DEV_TEST
Future<void> superDevTestGo() async {



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


  // blog('aho maw');
  //
  // final UserModel? _user = UsersProvider.proGetMyUserModel(
  //     context: getMainContext(),
  //     listen: false,
  // );
  //
  // final Map<String, dynamic>? _maw = _user?.toMap(toJSON: true);
  //
  // Errorize.throwMap(invoker: 'myUser', map: _maw);
  //
  // blog('function after maw');

  blog('start');

  final Map<String, dynamic> map = await Filers.readLocalJSON(
      path: WorldZoningPaths.populationsFilePath,
  );


  Mapper.blogMap(map);

}
