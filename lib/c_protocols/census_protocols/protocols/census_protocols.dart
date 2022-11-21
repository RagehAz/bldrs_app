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

    assert(userModel != null, 'userModel is null');

    /// INCREMENT USER CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: userModel.zone,
      map: CensusModel.createUserCensusMap(
        userModel: userModel,
        isIncrementing: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateUser({
    @required UserModel newUser,
    @required UserModel oldUser,
  }) async {

    assert(newUser != null, 'newUser is null');
    assert(oldUser != null, 'oldUser is null');

    final bool _shouldUpdateCensus = CensusModel.checkShouldUpdateUserCensus(
        oldUser: oldUser,
        newUser: newUser,
    );

    if (_shouldUpdateCensus == true){

      await Future.wait(<Future>[

        /// DECREMENT OLD USER CENSUS
        CensusRealOps.updateAllCensus(
          zoneModel: oldUser.zone,
          map: CensusModel.createUserCensusMap(
            userModel: oldUser,
            isIncrementing: false,
          ),
        ),

        /// INCREMENT NEW USER CENSUS
        CensusRealOps.updateAllCensus(
          zoneModel: newUser.zone,
          map: CensusModel.createUserCensusMap(
            userModel: newUser,
            isIncrementing: true,
          ),
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeUser(UserModel userModel) async {

    assert(userModel != null, 'userModel is null');

    /// DECREMENT USER CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: userModel.zone,
      map: CensusModel.createUserCensusMap(
        userModel: userModel,
        isIncrementing: false,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onComposeBz(BzModel bzModel) async {

    assert(bzModel != null, 'bzModel is null');

    /// INCREMENT USER CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: bzModel.zone,
      map: CensusModel.createBzCensusMap(
        bzModel: bzModel,
        isIncrementing: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateBz({
    @required BzModel newBz,
    @required BzModel oldBz,
  }) async {

    assert(newBz != null, 'newBz is null');
    assert(oldBz != null, 'oldBz is null');

    await Future.wait(<Future>[

      /// DECREMENT BZ CENSUS
      CensusRealOps.updateAllCensus(
        zoneModel: oldBz.zone,
        map: CensusModel.createBzCensusMap(
          bzModel: oldBz,
          isIncrementing: false,
        ),
      ),

      /// INCREMENT BZ CENSUS
      CensusRealOps.updateAllCensus(
        zoneModel: newBz.zone,
        map: CensusModel.createBzCensusMap(
          bzModel: newBz,
          isIncrementing: true,
        ),
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeBz(BzModel bzModel) async {

    assert(bzModel != null, 'bzModel is null');

    /// DECREMENT BZ CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: bzModel.zone,
      map: CensusModel.createBzCensusMap(
        bzModel: bzModel,
        isIncrementing: false,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER CENSUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onComposeFlyer(FlyerModel flyerModel) async {

    assert(flyerModel != null, 'flyerModel is null');

    /// INCREMENT FLYER CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: flyerModel.zone,
      map: CensusModel.createFlyerCensusMap(
        flyerModel: flyerModel,
        isIncrementing: true,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onRenovateFlyer({
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }) async {

    assert(oldFlyer != null, 'oldFlyer is null');
    assert(newFlyer != null, 'newFlyer is null');

    await Future.wait(<Future>[

      /// DECREMENT FLYER CENSUS
      CensusRealOps.updateAllCensus(
        zoneModel: oldFlyer.zone,
        map: CensusModel.createFlyerCensusMap(
          flyerModel: oldFlyer,
          isIncrementing: false,
        ),
      ),

      /// INCREMENT FLYER CENSUS
      CensusRealOps.updateAllCensus(
        zoneModel: newFlyer.zone,
        map: CensusModel.createFlyerCensusMap(
          flyerModel: newFlyer,
          isIncrementing: true,
        ),
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onWipeFlyer(FlyerModel flyerModel) async {

    assert(flyerModel != null, 'flyerModel is null');

    /// DECREMENT FLYER CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: flyerModel.zone,
      map: CensusModel.createFlyerCensusMap(
        flyerModel: flyerModel,
        isIncrementing: false,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// ENGAGEMENT CENSUS

  // --------------------
  /// TASK : WRITE ME
  static Future<void> onCallBz({
    @required BzModel bzModel,
    @required UserModel userModel,
  }) async {

  }
  // --------------------
  /// will be included in user protocols
  static Future<void> onFollowBz({
    @required BzModel bzModel,
    @required UserModel userModel,
  }) async {

}
  // --------------------
  /// will be included in user protocols
  static Future<void> onSaveFlyer() async {

  }
  // -----------------------------------------------------------------------------
  void f (){}
}
