import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FetchBzProtocols {
  // -----------------------------------------------------------------------------

  const FetchBzProtocols();

  // -----------------------------------------------------------------------------
  static Future<BzModel> fetchBz({
    @required BuildContext context,
    @required String bzID
  }) async {
    BzModel _bz = await BzLDBOps.readBz(bzID);

    if (_bz != null){
      // blog('FetchBzProtocol.fetchBz : ($bzID) BzModel FOUND in LDB');
    }
    else {

      _bz = await BzFireOps.readBz(
        bzID: bzID,
      );

      if (_bz != null) {
        // blog('FetchBzProtocol.fetchBz : ($bzID) BzModel FOUND in FIREBASE and inserted in LDB');
        await BzLDBOps.insertBz(
          bzModel: _bz,
        );
      }

    }

    // if (_bz == null) {
    //   blog('FetchBzProtocol.fetchBz : ($bzID) BzModel NOT FOUND');
    // }

    if (_bz != null){
      _bz = _bz.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
          context: context,
          incompleteZoneModel: _bz.zone,
        ),
      );
    }

    return _bz;
  }
  // --------------------
  static Future<BzModel> fetchBzByFlyerID({
    @required BuildContext context,
    @required String flyerID,
  }) async {
    BzModel _bzModel;

    if (flyerID != null){

      final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
        context: context,
        flyerID: flyerID,
      );

      if (_flyerModel != null){
        _bzModel = await fetchBz(
            context: context,
            bzID: _flyerModel.bzID,
        );
      }

    }

    return _bzModel;
  }
  // --------------------
  static Future<List<BzModel>> fetchBzz({
    @required BuildContext context,
    @required List<String> bzzIDs
  }) async {
    blog('FetchBzProtocol.fetchBzz : START');

    final List<BzModel> _bzz = <BzModel>[];

    if (Mapper.checkCanLoopList(bzzIDs)) {
      for (final String bzID in bzzIDs) {

        final BzModel _bz = await fetchBz(
          context: context,
          bzID: bzID,
        );

        if (_bz != null) {
          _bzz.add(_bz);
        }

      }
    }

    blog('FetchBzProtocol.fetchBzz : END');
    return _bzz;
  }
  // -----------------------------------------------------------------------------
}
