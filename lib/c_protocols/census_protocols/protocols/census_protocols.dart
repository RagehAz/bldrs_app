
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/c_protocols/census_protocols/real/census_real_ops.dart';
import 'package:flutter/cupertino.dart';

class CensusProtocols {
  /// --------------------------------------------------------------------------

  const CensusProtocols();

  // -----------------------------------------------------------------------------

  /// USER CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onComposeUser(UserModel userModel) async {

    final Map<String, dynamic> _map = CensusModel.createUserCensusMap(
        userModel: userModel,
        isIncrementing: true,
    );

    await CensusRealOps.updateAllCensus(
      map: _map,
      zoneModel: userModel.zone,
    );

  }
  // --------------------
  ///
  static Future<void> onUserRenovation({
    @required UserModel updatedUser,
    @required UserModel oldUser,
  }) async {

    // if (updatedUser != null && oldUser != null){
    //
    //   Map<String, dynamic> _map = {};
    //
    //   /// UPDATE NEED
    //   if (NeedModel.checkNeedsAreIdentical(updatedUser.need, oldUser.need) == false){
    //
    //     /// REMOVE OLD NEED
    //     _map = Mapper.insertPairInMap(
    //         map: _map,
    //         key: CensusModel.getNeedTypeFieldName(oldUser?.need?.needType),
    //         value: fireDB.ServerValue.increment(-1)
    //     );
    //
    //     /// ADD NEW NEED
    //     _map = Mapper.insertPairInMap(
    //         map: _map,
    //         key: CensusModel.getNeedTypeFieldName(updatedUser?.need?.needType),
    //         value: fireDB.ServerValue.increment(1)
    //     );
    //
    //   }
    //
    //   /// ZONE HAS CHANGED
    //   if (ZoneModel.checkZonesIDsAreIdentical(zone1: oldUser.zone, zone2: updatedUser.zone) == false){
    //
    //   }
    //
    //   /// ZONE IS THE SAME
    //   else {
    //
    //   }
    //
    // }

    await Future.wait(<Future>[

      CensusRealOps.updateAllCensus(
        zoneModel: oldUser.zone,
        map: CensusModel.createUserCensusMap(
          userModel: oldUser,
          isIncrementing: false,
        ),
      ),

      CensusRealOps.updateAllCensus(
        zoneModel: updatedUser.zone,
        map: CensusModel.createUserCensusMap(
          userModel: updatedUser,
          isIncrementing: true,
        ),
      ),

    ]);

  }
  // --------------------
  ///
  static Future<void> onWipeUser(UserModel userModel) async {

  }
  // -----------------------------------------------------------------------------

  /// BZ CENSUS

  // --------------------
  ///
  static Future<void> onComposeBz(BzModel bzModel) async {

  }
  // --------------------
  ///
  static Future<void> onRenovateBz({
    @required BzModel updatedBz,
    @required BzModel oldBz,
  }) async {

  }
  // --------------------
  ///
  static Future<void> onWipeBz(BzModel bzModel) async {

  }
  // -----------------------------------------------------------------------------

  /// FLYER CENSUS

  // --------------------
  static Future<void> onComposeFlyer(FlyerModel flyerModel) async {

  }
  // --------------------
  ///
  static Future<void> onRenovateFlyer({
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }) async {

  }
  // --------------------
  ///
  static Future<void> onWipeFlyer(FlyerModel flyerModel) async {

  }
  /// --------------------------------------------------------------------------
  void f(){}
}
