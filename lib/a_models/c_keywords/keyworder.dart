// ignore_for_file: constant_identifier_names
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/map_pathing.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/c_keywords/zone_phids_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_protocols.dart';
/// => TAMAM
class Keyworder {
  // --------------------------------------------------------------------------

  const Keyworder();

  // --------------------------------------------------------------------------
  static const String phidCut = 'phid';
  static const String phid_kCut = 'phid_k_';
  static const String phid_sCut = 'phid_s_';
  static const String currencyCut = 'currency';
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

      /// SEARCHING KEYS
      final List<String> _foundPaths = findPathsContainingPhid(
        phid: phid,
        keywordsMap: keywordsMap,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsContainingPhid({
    required Map<String, dynamic>? keywordsMap,
    required String? phid,
  }){
    List<String> _output = [];

    if (keywordsMap != null && phid != null) {

      final List<String> _mapPaths = MapPathing.generatePathsFromMap(
          map: keywordsMap
      );

      /// SEARCHING KEYS
      _output = Pathing.findPathsContainingSubstring(
        paths: _mapPaths,
        subString: phid,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllPhids({
    required Map<String, dynamic>? keywordsMap,
  }){
    List<String> _output = [];

    if (keywordsMap != null){

      final List<String> _paths = MapPathing.generatePathsFromMap(map: keywordsMap);

      // Stringer.blogStrings(strings: _paths, invoker: 'x');

      for (final String path in _paths){

        final List<String> _nodes = Pathing.splitPathNodes(path);

        _output = Stringer.addStringsToStringsIfDoNotContainThem(
            listToTake: _output,
            listToAdd: _nodes,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getLastNodesPhids({
    required Map<String, dynamic>? keywordsMap,
  }){
    List<String> _output = [];

    if (keywordsMap != null){

      final List<String> _paths = MapPathing.generatePathsFromMap(
        map: keywordsMap,
      );

      for (final String path in _paths){

        final String _lastNode = Pathing.getLastPathNode(path)!;

        _output = Stringer.addStringToListIfDoesNotContainIt(
            strings: _output,
            stringToAdd: _lastNode,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getAllPhidsByFlyerType({
    required FlyerType flyerType,
    required Map<String, dynamic>? keywordsMap,
  }){
    List<String> _output = [];

    if (keywordsMap != null){

      final String? _rootNode = FlyerTyper.concludeRootIDByFlyerType(
          flyerType: flyerType,
      );

      if (_rootNode != null){

        final Map<String, dynamic>? _subMap = keywordsMap[_rootNode];

          _output = getAllPhids(
            keywordsMap: _subMap,
          );

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

      _output = FlyerTyper.concludeFlyerTypeByRootID(
        rootID: _rootChainID,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNodeIsActiveInZone({
    required Map<String, dynamic>? keywordsMap,
    required ZonePhidsModel? zonePhidsModel,
    required String? path,
  }){
    bool _active = false;

    if (keywordsMap != null && zonePhidsModel != null && path != null){

      final List<String> _phids = ZonePhidsModel.getPhidsFromZonePhidsModel(
        zonePhidsModel: zonePhidsModel,
      );

      final bool _nodeIsLast = !MapPathing.checkPathNodeHasSons(
        map: keywordsMap,
        path: path,
      );

      /// IF LAST NODE
      if (_nodeIsLast == true){
        final String _phid = Pathing.getLastPathNode(path)!;
        _active = Stringer.checkStringsContainString(strings: _phids, string: _phid);
      }

      /// IF MIDDLE NODE
      else {
        /// IS ACTIVE IF ANY OF MY CHILDREN IS ACTIVE
        final List<String> _allPhidsBelow = MapPathing.getAllKeysBelow(
          path: path,
          map: keywordsMap,
        );
        _active = Stringer.checkStringsContainAnyOfThose(
          strings: _phids,
          those: _allPhidsBelow,
        );
      }

    }

    return _active;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic>? onlyShowFlyerTypesTrees({
    required List<FlyerType>? flyerTypes,
    required Map<String, dynamic>? keywordsMap,
  }){
    Map<String, dynamic>? _output = Mapper.cloneMap(keywordsMap);

    if (_output != null && flyerTypes != null){

      final List<String> _rootsIDs = FlyerTyper.getFlyerTypesRootsIDs(
        flyerTypes: flyerTypes,
      );

      if (Lister.checkCanLoop(_rootsIDs) == true){

        _output = Mapper.cloneMap({});

        for (final String rootID in _rootsIDs){

          _output = Mapper.insertPairInMap(
            map: _output,
            key: rootID,
            value: keywordsMap![rootID],
            overrideExisting: true,
          );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>?> onlyShowZonePhidsTrees({
    required Map<String, dynamic>? keywordsMap,
    required ZoneModel? zone,
  }) async {
    Map<String, dynamic>? _output = keywordsMap;

    if (zone != null && _output != null){

      final ZonePhidsModel? _zonePhidsModel = await ZonePhidsProtocols.fetch(
          zoneModel: zone,
      );

      if (_zonePhidsModel != null){

        final List<String> _allPaths = MapPathing.generatePathsFromMap(map: _output);
        List<String> _pathsToShow = [];

        for (final String path in _allPaths){

          final bool _isActive = checkNodeIsActiveInZone(
            keywordsMap: _output,
            path: path,
            zonePhidsModel: _zonePhidsModel,
          );

          final bool _isLastNode = !MapPathing.checkPathNodeHasSons(
            map: _output,
            path: path,
          );

          if (_isActive == true && _isLastNode){
            _pathsToShow = Stringer.addStringsToStringsIfDoNotContainThem(
                listToTake: _pathsToShow,
                listToAdd: [path],
            );
          }

        }

        if (Lister.checkCanLoop(_pathsToShow) == true){

          _output = MapPathing.generateMapFromSomePaths(
              somePaths: _pathsToShow,
              sourceMap: _output,
          );

        }

      }

    }

    return _output;
  }
  // --------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapSonsAreMaps({
    required Map<String, dynamic>? map,
  }){
    bool _output = false;

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        final dynamic _firstSon = map[_keys.first];

        if (_firstSon is bool){
          _output = false;
        }
        else if (_firstSon is Map){
          _output = true;
        }
        else {
          _output = false;
        }


      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkMapSonsAreBools({
    required Map<String, dynamic>? map,
  }){
    bool _output = false;

    if (map != null){

      final List<String> _keys = map.keys.toList();

      if (Lister.checkCanLoop(_keys) == true){

        final dynamic _firstSon = map[_keys.first];

        if (_firstSon is bool){
          _output = true;
        }
        else if (_firstSon is Map){
          _output = false;
        }
        else {
          _output = false;
        }


      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhids(dynamic sons){

    bool _arePhids = false;

    if (sons != null){

      if (sons is List<String>){

        final List<String> _sons = sons;

        if (Lister.checkCanLoop(_sons) == true){
          _arePhids = checkIsPhid(_sons.first);
        }

      }

      else if (ObjectCheck.objectIsMinified(sons) == true){
        if (sons is List && sons.isNotEmpty == true){
          final List<dynamic> dynamics = sons;
          final List<String> _strings = Stringer.getStringsFromDynamics(dynamics);
          if (Lister.checkCanLoop(_strings) == true){
            _arePhids = checkIsPhid(_strings.first);
          }
        }
      }

    }

    return _arePhids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhid(dynamic object){
    bool _isPhid = false;

    if (object != null){

      if (object is String){

        _isPhid = TextCheck.stringStartsExactlyWith(
          text: object,
          startsWith: phidCut,
        );

      }

    }

    return _isPhid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhidK(String? text){
    bool _isPhidK= false;

    if (text != null){

      _isPhidK = TextCheck.stringStartsExactlyWith(
        text: text,
        startsWith: phid_kCut,
      );

      /// SOLUTION 2 : TESTED : WORKS PERFECT
      // final String _phidK = TextMod.removeAllCharactersAfterNumberOfCharacters(
      //   input: Phider.removeIndexFromPhid(phid: text),
      //   numberOfChars: 7, //'ph id _k_'
      // );
      // return _phidK == 'phid_k_';


    }

    return _isPhidK;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhidS(String? text){
    bool _isPhidK= false;

    if (text != null){

      _isPhidK = TextCheck.stringStartsExactlyWith(
        text: text,
        startsWith: phid_sCut,
      );

      /// SOLUTION 2 : TESTED : WORKS PERFECT
      // final String _phids = TextMod.removeAllCharactersAfterNumberOfCharacters(
      //   input: Phider.removeIndexFromPhid(phid: text),
      //   numberOfChars: 7, //'phid_s_'
      // );
      // return _phids == 'phid_s_';


    }

    return _isPhidK;
  }
  // --------------------------------------------------------------------------
}
