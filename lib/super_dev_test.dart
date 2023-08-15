import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'c_protocols/main_providers/ui_provider.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  final List<String> _countriesIDs = Flag.getAllCountriesIDs();

  for (int i = 0; i < _countriesIDs.length; i++){

    final String countryID = _countriesIDs[i];

    final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountry(
        countryID: countryID,
        // cityStageType:
    );

    final List<Map<String, dynamic>> _maps = CityModel.cipherCities(
        cities: _cities,
        toJSON: true,
        toLDB: true,
    );

    final Map<String, dynamic> _map = {
      countryID: _maps,
    };

    final bool _success = await Filers.exportJSON(
      context: getMainContext(),
      map: _map,
      fileName: countryID,
      exportToPath: '/storage/emulated/0/Misc/countries',
    );

    if (_success == true){
      unawaited(Dialogs.topNotice(
        verse: Verse.plain('$countryID.json is exported'),
      ));
    }


    blog('DONE ( ${i+1} / ${_countriesIDs.length} ) : $countryID');

  }


}
