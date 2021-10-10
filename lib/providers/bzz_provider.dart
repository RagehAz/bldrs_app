import 'package:bldrs/db/firestore/bz_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BzzProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// FETCHING BZZ
  /// 1 - search in entire LDBs for this bzModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase bz ops
  ///   2.2 if found on firebase, store in ldb sessionBzz
  Future<BzModel> fetchBzModel({@required BuildContext context, @required  String bzID}) async {

    BzModel _bz;

    /// 1 - search in entire LDBs for this bzModel
    for (String doc in LDBDoc.bzModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchMap(
        docName: doc,
        fieldToSortBy: 'bzID',
        searchField: 'bzID',
        searchValue: bzID,
      );

      if (_map != null && _map != {}){
        _bz = BzModel.decipherBzMap(_map);
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_bz == null){

      /// 2.1 read firebase bz ops
      _bz = await BzOps.readBzOps(
        context: context,
        bzID: bzID,
      );

      /// 2.2 if found on firebase, store in ldb sessionBzz
      if (_bz != null){
        await LDBOps.insertMap(
          input: _bz.toMap(),
          docName: LDBDoc.sessionBzz,
        );
      }

    }

    return _bz;
  }
// -------------------------------------
  Future<List<BzModel>> fetchBzzModels({@required BuildContext context, @required List<String> bzzIDs}) async {

    List<BzModel> _bzz = <BzModel>[];

    if (bzzIDs != null && bzzIDs.isNotEmpty){

      for (String bzID in bzzIDs){

        final BzModel _bz = await fetchBzModel(context: context, bzID: bzID);

        if (_bz != null){

          _bzz.add(_bz);

        }

      }

    }

    return _bzz;
  }
// -----------------------------------------------------------------------------
  /// SPONSORS
  List<TinyBz> _sponsors = <TinyBz>[];
// -------------------------------------
  List<TinyBz> get getSponsors {
    return <TinyBz> [..._sponsors];
  }
// -------------------------------------
  /// FETCH SPONSORS
  /// 1 - get sponsors from app state
  /// 2 - fetch each bzID if found
  Future<void> fetchSponsors(BuildContext context) async {

    /// 1 - get sponsorsIDs from app state
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final List<String> _sponsorsBzzIDs = _generalProvider.appState.sponsors;

    /// 2 - fetch bzz
    List<BzModel> _bzzSponsors = await fetchBzzModels(context: context, bzzIDs: _sponsorsBzzIDs);

    List<TinyBz> _tinyBzz = TinyBz.getTinyBzzFromBzzModels(_bzzSponsors);

    _sponsors = _tinyBzz;
    notifyListeners();
  }
// -----------------------------------------------------------------------------

}
