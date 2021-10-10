import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/db/firestore/flyer_ops.dart';
import 'package:bldrs/db/firestore/search_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
  /// FETCHING FLYERS
  /// 1 - search in entire LDBs for this flyerModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase flyer ops
  ///   2.2 if found on firebase, store in ldb sessionFlyers
  Future<FlyerModel> fetchFlyerByID({BuildContext context, String flyerID}) async {

    FlyerModel _flyer;

    /// 1 - search in entire LDBs for this flyerModel
    for (String doc in LDBDoc.flyerModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchMap(
        docName: doc,
        fieldToSortBy: 'flyerID',
        searchField: 'flyerID',
        searchValue: flyerID,
      );

      if (_map != null && _map != {}){
        _flyer = FlyerModel.decipherFlyerMap(_map);
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_flyer == null){

      /// 2.1 read firebase flyer ops
      _flyer = await FlyerOps().readFlyerOps(
        context: context,
        flyerID: flyerID,
      );

      /// 2.2 if found on firebase, store in ldb sessionFlyers
      if (_flyer != null){
        await LDBOps.insertMap(
          input: _flyer.toMap(),
          docName: LDBDoc.sessionFlyers,
        );
      }

    }

    return _flyer;
  }
  // -------------------------------------
  Future<List<FlyerModel>> fetchFlyersByIDs({BuildContext context, List<String> flyersIDs}) async {
    List<FlyerModel> _flyers = <FlyerModel>[];

    if (flyersIDs != null && flyersIDs.isNotEmpty){

      for (String flyerID in flyersIDs){

        final FlyerModel _flyer = await fetchFlyerByID(context: context, flyerID: flyerID);

        if (_flyer != null){

          _flyers.add(_flyer);

        }

      }

    }

    return _flyers;
  }
  // -----------------------------------------------------------------------------
  /// WALL FLYERS
  List<TinyFlyer> _wallTinyFlyers;
// -------------------------------------
  List<TinyFlyer> get wallTinyFlyers {
    return <TinyFlyer>[..._wallTinyFlyers];
  }
// -------------------------------------
  Future<void> fetchFlyersBySection(BuildContext context, Section section) async {
    final OldCountryProvider _countryPro =  Provider.of<OldCountryProvider>(context, listen: false);
    final Zone _currentZone = _countryPro.currentZone;

    // final String _zoneString = TextGenerator.zoneStringer(
    //   context: context,
    //   zone: _currentZone,
    // );


    await tryAndCatch(
        context: context,
        methodName: 'fetchAndSetTinyFlyersBySectionType',
        functions: () async {

          final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

          // print('_flyerType is : ${_flyerType.toString()}');

          /// READ data from cloud Firestore flyers collection


          final List<TinyFlyer> _foundTinyFlyers = await FireSearch.flyersByZoneAndFlyerType(
            context: context,
            zone: _currentZone,
            flyerType: _flyerType,
          );


          // print('${(TinyFlyer.cipherTinyFlyers(_foundTinyFlyers)).toString()}');

          _wallTinyFlyers = _foundTinyFlyers;

          notifyListeners();
          // print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');

        }
    );


  }
}