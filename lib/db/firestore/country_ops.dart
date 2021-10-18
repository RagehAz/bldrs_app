import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/continent_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/material.dart';


class CountryOps{

// -----------------------------------------------------------------------------
  static Future<CountryModel> readCountryOps({@required BuildContext context, @required String countryID}) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.zones,
      docName: countryID,
    );

    final CountryModel _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: false);

    return _countryModel;
  }
// -----------------------------------------------------------------------------
  static Future<List<Continent>> readContinentsOps({@required BuildContext context}) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireColl.admin,
      docName: 'continents',
    );

    final List<Continent> _allContinents = Continent.decipherContinents(_map);

    return _allContinents;
  }
// -----------------------------------------------------------------------------
//   Future<void> updateCountryDoc() async {}
// // -----------------------------------------------------------------------------

}
