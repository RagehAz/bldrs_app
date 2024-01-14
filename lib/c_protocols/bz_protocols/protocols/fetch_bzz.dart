import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';

class FetchBzProtocols {
  // -----------------------------------------------------------------------------

  const FetchBzProtocols();

  // -----------------------------------------------------------------------------

  /// BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> fetch({
    required String? bzID
  }) async {
    BzModel? _bz = await BzLDBOps.readBz(bzID);

    if (_bz != null){
      // blog('FetchBzProtocol.fetchBz : ($bzID) BzModel FOUND in LDB');
    }
    else {

      _bz = await BzFireOps.readBz(
        bzID: bzID,
      );

      if (_bz != null) {
        // blog('FetchBzProtocol.fetchBz : ($bzID) BzModel FOUND in FIREBASE and inserted in LDB');
        await BzLDBOps.insertBz(_bz);
      }

    }

    if (_bz == null) {
      // blog('FetchBzProtocol.fetchBz : ($bzID) BzModel NOT FOUND');
    }

    if (_bz != null){
      _bz = _bz.copyWith(
        zone: await ZoneProtocols.completeZoneModel(
          invoker: 'fetchBz',
          incompleteZoneModel: _bz.zone,
        ),
      );
    }

    return _bz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> refetch({
    required String? bzID
  }) async {
    BzModel? _output;

    if (bzID != null){

      await BzLDBOps.deleteBzOps(
          bzID: bzID
      );

      _output = await fetch(
          bzID: bzID
      );

    }
    else {
      // blog('BzProtocols.refetch : bz id is null');
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> fetchBzByFlyerID({
    required String? flyerID,
  }) async {
    BzModel? _bzModel;

    if (flyerID != null){

      final FlyerModel? _flyerModel = await FlyerProtocols.fetchFlyer(
        flyerID: flyerID,
      );

      if (_flyerModel != null){
        _bzModel = await fetch(
            bzID: _flyerModel.bzID,
        );
      }

    }

    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// BZZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<BzModel>> fetchBzz({
    required List<String>? bzzIDs
  }) async {
    // blog('FetchBzProtocol.fetchBzz : START');

    final List<BzModel> _bzz = <BzModel>[];

    if (Lister.checkCanLoop(bzzIDs) == true) {
      for (final String bzID in bzzIDs!) {

        final BzModel? _bz = await fetch(
          bzID: bzID,
        );

        if (_bz != null) {
          _bzz.add(_bz);
        }

      }
    }

    // blog('FetchBzProtocol.fetchBzz : END');
    return _bzz;
  }
  // -----------------------------------------------------------------------------
}
