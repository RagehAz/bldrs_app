import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:flutter/material.dart';


class CountryOps{

// -----------------------------------------------------------------------------
  static Future<CountryModel> readCountryOps({@required BuildContext context, @required String countryID}) async {

    final Map<String, dynamic> _map = await Fire.readDoc(
      context: context,
      collName: FireCollection.zones,
      docName: countryID,
    );

    final CountryModel _countryModel = CountryModel.decipherCountryMap(map: _map, fromJSON: false);

    return _countryModel;
  }
// -----------------------------------------------------------------------------
//   Future<void> updateCountryDoc() async {}
// // -----------------------------------------------------------------------------

}
