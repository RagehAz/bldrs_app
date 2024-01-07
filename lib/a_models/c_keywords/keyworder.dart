

import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/map_pathing.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';

class Keyworder {
  // --------------------------------------------------------------------------

  const Keyworder();

  // --------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getRootPhidsOfKeywordsMap({
    required Map<String, dynamic>? keywordsMap,
  }){
    final List<String> _output = [];

    if (keywordsMap != null){
      final List<String> _keys = keywordsMap.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){
        _output.addAll(_keys);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getRootPhidOfAPhidInKeywordsMap({
    required Map<String, dynamic>? keywordsMap,
    required String? phid,
  }){
    String? _output;

    if (keywordsMap != null && phid != null) {

      final List<String> _mapPaths = MapPathing.generatePathsFromMap(map: keywordsMap);

      /// SEARCHING KEYS
      final List<String> _foundPaths = Pathing.findPathsContainingSubstring(
        paths: _mapPaths,
        subString: phid,
      );

      if (Lister.checkCanLoop(_foundPaths) == true){
        final String _firstPath = _foundPaths.first;
        final List<String> _nodes = Pathing.splitPathNodes(_firstPath);
        if (Lister.checkCanLoop(_nodes) == true){
          _output = _nodes.first;
        }
      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// ZONE PHIDS - FLYER TYPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> getFlyerTypesByZonePhids({
    required Map<String, dynamic>? keywordsMap,
    required ZonePhidsModel? zonePhidsModel,
  }){
    final List<FlyerType> _output = [];

    if (keywordsMap != null && zonePhidsModel != null){

      final List<String> _phids = ZonePhidsModel.getPhidsFromZonePhidsModel(
        zonePhidsModel: zonePhidsModel,
      );

      if (Lister.checkCanLoop(_phids) == true){

        for (final String phid in _phids){

          final FlyerType? _flyerType = getFlyerTypeByPhid(
            phid: phid,
            keywordsMap: keywordsMap,
          );


          if (_flyerType != null && _output.contains(_flyerType) == false){
            _output.add(_flyerType);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType? getFlyerTypeByPhid({
    required Map<String, dynamic>? keywordsMap,
    required String? phid,
  }){
    FlyerType? _output;

    if (phid != null && keywordsMap != null){

      final String? _rootChainID = getRootPhidOfAPhidInKeywordsMap(
          keywordsMap: keywordsMap,
          phid: phid
      );

      _output = FlyerTyper.concludeFlyerTypeByChainID(
        chainID: _rootChainID,
      );

    }

    return _output;
  }
  // --------------------------------------------------------------------------
}
