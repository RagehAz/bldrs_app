import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_counters/bz_counter_model.dart';
import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/zzz_exotic_methods/exotic_methods.dart';
import 'package:flutter/cupertino.dart';
/// => TAMAM
class CensusProtocols {
  // -----------------------------------------------------------------------------

  const CensusProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scanAllDBAndCreateInitialCensuses({
    @required BuildContext context,
  }) async {

    final bool _go = await Dialogs.confirmProceed(
      context: context,
      titleVerse: Verse.plain('This is Dangerous !'),
      bodyVerse: Verse.plain('This will read all Users - All Bzz - All Flyers and create a Census for each of them'),
      invertButtons: true,
    );

    if (_go == true){

      /// ALL USERS
      await ExoticMethods.readAllUserModels(
        limit: 900,
        onRead: (int index, UserModel _userModel) async {

          await CensusProtocols.onComposeUser(_userModel);
          blog('DONE : $index : UserModel: ${_userModel.name}');

        },
      );

      /// ALL BZZ
      await ExoticMethods.readAllBzzModels(
        limit: 900,
        onRead: (int i, BzModel _bzModel) async {

          blog('DONE : $i : BzModel: ${_bzModel.name}');
          await CensusProtocols.onComposeBz(_bzModel);

          final BzCounterModel _bzCounter = await BzRecordRealOps.readBzCounters(
              bzID: _bzModel.id,
          );

          if (_bzCounter != null){
            await Future.wait(<Future>[

              if (_bzCounter?.calls != null && _bzCounter.calls > 0)
                onCallBz(
                  bzModel: _bzModel,
                  count: _bzCounter.calls,
                ),

              if (_bzCounter?.follows != null && _bzCounter.follows > 0)
                onFollowBz(
                  bzModel: _bzModel,
                  isFollowing: true,
                  count: _bzCounter.follows,
                ),

            ]);
          }

        },
      );

      /// ALL FLYERS
      await ExoticMethods.readAllFlyers(
        limit: 1000,
        onRead: (int index, FlyerModel _flyerModel) async {

          blog('DONE : $index : FlyerModel: ${_flyerModel.id}');
          await CensusProtocols.onComposeFlyer(_flyerModel);

          final FlyerCounterModel _flyerCounter = await FlyerRecordRealOps.readFlyerCounters(
              flyerID: _flyerModel.id,
          );

          if (_flyerCounter != null){

            await onSaveFlyer(
              flyerModel: _flyerModel,
              isSaving: true,
              count: _flyerCounter.saves,
            );

          }


        },
      );

    }


  }
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

    final Map<String, dynamic> _censusMap = CensusModel.createBzCensusMap(
      bzModel: bzModel,
      isIncrementing: false,
    );

    final Map<String, dynamic> _callsMap = await CensusModel.createCallsWipeMap(bzModel);

    final Map<String, dynamic> _mergedMap = Mapper.insertMapInMap(
        baseMap: _censusMap,
        insert: _callsMap,
    );

    /// DECREMENT BZ CENSUS
    await CensusRealOps.updateAllCensus(
      zoneModel: bzModel.zone,
      map: _mergedMap,
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
  /// TESTED : WORKS PERFECT
  static Future<void> onCallBz({
    @required BzModel bzModel,
    int count = 1,
  }) async {

    assert(bzModel != null, 'bzModel is null');

    await CensusRealOps.updateAllCensus(
      zoneModel: bzModel.zone,
      map: CensusModel.createCallCensusMap(
        bzModel: bzModel,
        isIncrementing: true,
        count: count,
      ),
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onFollowBz({
    @required BzModel bzModel,
    @required bool isFollowing,
    int count = 1,
  }) async {

    assert(bzModel != null, 'bzModel is null');

    await CensusRealOps.updateAllCensus(
      zoneModel: bzModel.zone, // should be bz zone to be wiped with bz wipe
      map: CensusModel.createFollowCensusMap(
        bzModel: bzModel,
        isIncrementing: isFollowing,
        count: count,
      ),
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSaveFlyer({
    @required FlyerModel flyerModel,
    @required bool isSaving,
    int count = 1,
  }) async {

    assert(flyerModel != null, 'flyerModel is null');

    await CensusRealOps.updateAllCensus(
      zoneModel: flyerModel.zone, // should be user zone to delete it on wipe user protocols
      map: CensusModel.createFlyerSaveCensusMap(
        flyerModel: flyerModel,
        isIncrementing: isSaving,
        count: count,
      ),
    );


  }
  // -----------------------------------------------------------------------------
}
