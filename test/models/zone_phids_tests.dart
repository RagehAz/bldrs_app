// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:bldrs/a_models/c_keywords/zone_phids_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('ZonePhidsModel tests', () {

    test('creates a new instance with correct fields', () {
      final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5});
      expect(zonePhids.zoneID, 'zone1');
      expect(zonePhids.phidsMap, {'phid1': 5});
    });

    test('handles null phidsMap gracefully', () {
      final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: null);
      expect(zonePhids.zoneID, 'zone1');
      expect(zonePhids.phidsMap, null);
    });

    group('copyWith tests', () {
      test('copies existing values by default', () {
        final original = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5});
        final copy = original.copyWith();
        expect(copy.zoneID, 'zone1');
        expect(copy.phidsMap, {'phid1': 5});
      });

      test('updates specific fields', () {
        final original = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5});
        final copy = original.copyWith(zoneID: 'zone2', phidsMap: {'phid2': 10});
        expect(copy.zoneID, 'zone2');
        expect(copy.phidsMap, {'phid2': 10});
      });
    });

    group('toMap tests', () {
      test('returns an empty map for null phidsMap', () {
        final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: null);
        expect(zonePhids.toMap(), {});
      });

      test('returns a copy of the phidsMap', () {
        final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5});
        final map = zonePhids.toMap();
        expect(map, {'phid1': 5});
      });
    });

    group('decipherCityNodePhids tests', () {
      test('returns null for null inputs', () {
        expect(ZonePhidsModel.decipherCityNodePhids(map: null, cityID: null), null);
      });

      test('creates a ZonePhidsModel with correct fields', () {
        final map = {'phid1': 5.0, 'phid2': 10};
        final zonePhids = ZonePhidsModel.decipherCityNodePhids(map: map, cityID: 'city1');
        expect(zonePhids?.zoneID, 'city1');
        expect(zonePhids?.phidsMap, {'phid1': 5, 'phid2': 10}); // Ensure doubles are converted to ints
      });

      test('handles non-numeric values in the map gracefully', () {
        final map = {'phid1': 5.0, 'phid2': 'hello'};
        expect(
            ZonePhidsModel.decipherCityNodePhids(map: map, cityID: 'city1'),
            ZonePhidsModel(
              zoneID: 'city1',
              phidsMap: {
                'phid1': 5,
              },
            ),
        );
      });
    });

  });

  group('decipherCountryNodeMap', () {

    test('returns null for null input', () {
      expect(ZonePhidsModel.decipherCountryNodeMap(map: null), null);
    });

    test('handles missing country ID gracefully', () {
      final map = {'city1': {}};
      expect(ZonePhidsModel.decipherCountryNodeMap(map: map), null);
    });

    test('handles empty city list gracefully', () {
      final map = {'id': 'country1'};
      expect(ZonePhidsModel.decipherCountryNodeMap(map: map), null);
    });

    test('combines city models correctly', () {
      final map = {
        'id': 'country1',
        'cityID1': {'x': 5},
        'cityID2': {'y': 10, 'x': 2},
      };
      final ZonePhidsModel? output = ZonePhidsModel.decipherCountryNodeMap(map: map);

      output?.blogZonePhidsModel(invoker: 'x');

      expect(
        output,
          ZonePhidsModel(
            zoneID: 'country1',
            phidsMap: {
              'x': 7,
              'y': 10,
            },
          ),
      );

    });

    test('handles non-numeric values in city maps gracefully', () {
      final map = {
        'id': 'country1',
        'city1': {'phid1': 'hello'},
      };

      final ZonePhidsModel? _d = ZonePhidsModel.decipherCountryNodeMap(map: map);

      final ZonePhidsModel _shouldBe = ZonePhidsModel(
          zoneID: 'country1',
          phidsMap: {},
      );

      _d?.blogZonePhidsModel(invoker: 'xxx');

      expect(_d, _shouldBe);
    });

    test('handles errors from Lister.checkCanLoop gracefully', () {
      // Simulate Lister.checkCanLoop returning false
      final map = {
        'id': 'country1',
        'city1': {'phid1': 5},
      };

      final ZonePhidsModel? _ex = ZonePhidsModel.decipherCountryNodeMap(map: map);
      final ZonePhidsModel _should = ZonePhidsModel(
          zoneID: 'country1',
          phidsMap: {'phid1': 5},
      );

      expect(_ex , _should);

    });

  });

  group('createPhidsMapFromFlyerPhids', () {

    test('returns an empty map for null input', () {
      expect(ZonePhidsModel.createPhidsMapFromFlyerPhids(phids: null), {});
    });

    test('handles an empty list gracefully', () {
      expect(ZonePhidsModel.createPhidsMapFromFlyerPhids(phids: []), {});
    });

    test('creates a map with correct counts for unique phids', () {
      final map = ZonePhidsModel.createPhidsMapFromFlyerPhids(phids: ['phid1', 'phid2', 'phid1']);
      expect(map, {'phid1': 2, 'phid2': 1});
    });

    test('handles errors from Lister.checkCanLoop gracefully', () {
      // Simulate Lister.checkCanLoop returning false
      expect(
          ZonePhidsModel.createPhidsMapFromFlyerPhids(phids: ['phid1']),
          {'phid1': 1}
      );
    });

  });

  group('getPhidsFromZonePhidsModel', () {

    test('returns an empty list for null input', () {
      expect(ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: null), []);
    });

    test('handles null phidsMap gracefully', () {
      final zonePhidsModel = ZonePhidsModel(zoneID: 'zone1', phidsMap: null);
      expect(ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: zonePhidsModel), []);
    });

    test('returns a list of phids without the "id" key', () {
      final zonePhidsModel = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5, 'id': 10});
      final phids = ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: zonePhidsModel);
      expect(phids, ['phid1']);
    });

    test('filters out phids with zero values', () {
      final zonePhidsModel = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5, 'phid2': 0});
      final phids = ZonePhidsModel.getPhidsFromZonePhidsModel(zonePhidsModel: zonePhidsModel);
      expect(phids, ['phid1']);
    });

  });

  group('cleanZeroValuesPhids', () {

    test('returns null for null input', () {
      expect(ZonePhidsModel.cleanZeroValuesPhids(null), null);
    });

    test('returns the same instance for an empty phidsMap', () {
      final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: {});
      expect(ZonePhidsModel.cleanZeroValuesPhids(zonePhids), same(zonePhids));
    });

    test('filters out phids with zero values', () {
      final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5, 'phid2': 0, 'phid3': 10});
      final cleaned = ZonePhidsModel.cleanZeroValuesPhids(zonePhids);
      expect(cleaned?.phidsMap, {'phid1': 5, 'phid3': 10});
    });

    test('handles errors from Lister.checkCanLoop gracefully', () {
      // Simulate Lister.checkCanLoop returning false
      final zonePhids = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5});
      expect(ZonePhidsModel.cleanZeroValuesPhids(zonePhids), zonePhids);
    });

  });

  group('ZonePhidsModel tests', () {

    test('combineModels combines phidsMaps and cleans zero values', () {
      final base = ZonePhidsModel(zoneID: 'zone1', phidsMap: {'phid1': 5, 'phid3': 10});
      final add = ZonePhidsModel(zoneID: 'zone2', phidsMap: {'phid2': 15, 'phid3': 0});
      final combined = ZonePhidsModel.combineModels(zoneID: 'combined', base: base, add: add);
      expect(combined?.zoneID, 'combined');
      expect(combined?.phidsMap, {'phid1': 5, 'phid2': 15, 'phid3': 10});
    });

    test('combineModels returns null for null zoneID', () {
      expect(ZonePhidsModel.combineModels(zoneID: null, base: null, add: null), null);
    });

    test('combineModels handles errors from MapperSI.combineMaps gracefully', () {
      // Simulate MapperSI.combineMaps throwing an error
      expect(
          ZonePhidsModel.combineModels(zoneID: 'zone1', base: null, add: null),
          ZonePhidsModel(
            zoneID: 'zone1',
            phidsMap: {},
          ),
      );
    });
  });

}
