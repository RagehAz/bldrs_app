import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  blog('a77a');

  // final List<FlyerModel> flyers = await  readAllFlyers(limit: 1000);
  //
  // for (final FlyerModel flyer in flyers){
  //
  //
  //   blog('done with ${flyer.id} : ${flyer.bzModel?.name}');
  //
  // }

}
  // -----------------------------------------------------------------------------

  /// READ ALL FLYERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<FlyerModel>> readAllFlyers({
    required int limit,
    Future Function(int index, FlyerModel flyerModel)? onRead,
  }) async {
    blog('readAllFlyers : START');

    final List<FlyerModel> _allFlyerModels = <FlyerModel>[];

    for (int i = 0; i < limit; i++){

      final List<Map<String, dynamic>> _maps = await Fire.readColl(
        queryModel: FireQueryModel(
          coll: FireColl.flyers,
          limit: limit,
          orderBy: const QueryOrderBy(
            fieldName: 'id',
            descending: true,
          ),
        ),
        startAfter: _allFlyerModels.isEmpty ? null : _allFlyerModels.last.docSnapshot,
        addDocSnapshotToEachMap: true,
      );

      if (_maps.isEmpty){
        break;
      }

      else {

        final FlyerModel? _flyerModel = FlyerModel.decipherFlyer(
          map: _maps.first,
          fromJSON: false,
        );

        if (_flyerModel != null){

          _allFlyerModels.add(_flyerModel);

          if (onRead != null){
            await onRead(i, _flyerModel);
          }

        }


      }

    }

    blog('readAllFlyers : END');
    return _allFlyerModels;
  }
  // -----------------------------------------------------------------------------
