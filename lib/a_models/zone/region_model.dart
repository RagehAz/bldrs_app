import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/foundation.dart';

@immutable
class Region {
  /// --------------------------------------------------------------------------
  const Region({
    @required this.continent,
    @required this.name,
    @required this.countriesIDs,
  });
  /// --------------------------------------------------------------------------
  final String continent;
  final String name;
  final List<String> countriesIDs;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'continent': continent,
      'name': name,
      'countriesIDs': countriesIDs,
    };
  }
  // --------------------
  static Region decipherRegion(Map<String, dynamic> map) {
    return Region(
      name: map['name'],
      continent: map['continent'],
      countriesIDs: Stringer.getStringsFromDynamics(dynamics: map['countriesIDs']),
    );
  }
  // --------------------
  static Map<String, dynamic> cipherRegions(List<Region> regions) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(regions)) {
      for (final Region region in regions) {
        _map = Mapper.insertPairInMap(
          map: _map,
          value: region.toMap(),
          key: region.name,
        );
      }
    }

    return _map;
  }
  // --------------------
  static List<Region> decipherRegions(Map<String, dynamic> map) {
    final List<Region> _regions = <Region>[];

    final List<String> _keys = map.keys.toList();

    if (Mapper.checkCanLoopList(_keys)) {
      for (final String key in _keys) {
        _regions.add(decipherRegion(map[key]));
      }
    }

    return _regions;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool regionsIncludeRegion({
    @required List<Region> regions,
    @required String name,
  }) {
    bool _includes = false;

    for (final Region region in regions) {
      if (region.name == name) {
        _includes = true;
        break;
      }
    }

    return _includes;
  }
  // -----------------------------------------------------------------------------
}
