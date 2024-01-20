// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, avoid_redundant_argument_values
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('ScopeModel Tests', () {

    test('toMap should return a valid map', () {
      final Map<String, dynamic> result = ScopeModel.dummyScope.toMap();
      expect(result, isNotNull);
      // Add more specific expectations for the result if needed.
    });

    test('decipher should return null when provided with null map', () {
      final ScopeModel? result = ScopeModel.decipher(null);
      expect(result, isNull);
    });

    test('decipher should return a valid ScopeModel when provided with a valid map', () {
      final Map<String, dynamic> validMap = {
        'phid_key': ['idA', 'idB', 'idC'],
        'phid_key2': ['idD', 'idE', 'idF'],
      };
      final ScopeModel? result = ScopeModel.decipher(validMap);
      expect(result, isNotNull);
      // Add more specific expectations for the result if needed.
    });

    test('decipher should handle an empty map gracefully', () {
      final Map<String, dynamic> emptyMap = {};
      final ScopeModel? result = ScopeModel.decipher(emptyMap);
      expect(result, null);
      // Add more specific expectations for the result if needed.
    });

    test('decipher should handle invalid map values gracefully', () {
      final Map<String, dynamic> invalidMap = {
        'phid_key': 'invalid_value',
      };
      final ScopeModel? result = ScopeModel.decipher(invalidMap);
      expect(result, isNull);
    });

    test('decipher should handle null values within the map gracefully', () {
      final Map<String, dynamic> mapWithNull = {
        'phid_key': null,
      };
      final ScopeModel? result = ScopeModel.decipher(mapWithNull);
      expect(result, null);
      // Add more specific expectations for the result if needed.
    });

    test('decipher should handle missing keys within the map gracefully', () {
      final Map<String, dynamic> mapWithoutKey = {
        'missing_key': ['idX', 'idY'],
      };
      final ScopeModel? result = ScopeModel.decipher(mapWithoutKey);
      expect(result, isNotNull);
      // Add more specific expectations for the result if needed.
    });

    test('getPhids should return an empty list when provided with null ScopeModel', () {
      final List<String> result = ScopeModel.getPhids(null);
      expect(result, isEmpty);
    });

    test('getPhids should return a list of keys from ScopeModel', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final List<String> result = ScopeModel.getPhids(scopeModel);
      expect(result, isNotEmpty);
      expect(result, equals(['phid_key', 'phid_key2']));
    });

    test('getPhids should return an empty list when provided with an empty ScopeModel', () {
      final ScopeModel emptyScopeModel = ScopeModel(map: {});
      final List<String> result = ScopeModel.getPhids(emptyScopeModel);
      expect(result, isEmpty);
    });

    test('getPhids should return a list with one key from a ScopeModel with one key', () {
      final ScopeModel singleKeyScopeModel = ScopeModel(map: {
        'phid_key': ['idA', 'idB']
      });
      final List<String> result = ScopeModel.getPhids(singleKeyScopeModel);
      expect(result, isNotEmpty);
      expect(result, hasLength(1));
      expect(result, contains('phid_key'));
    });

    test('getFlyersIDsByPhid should return an empty list when provided with null ScopeModel', () {
      final List<String> result = ScopeModel.getFlyersIDsByPhid(scope: null, phid: 'phid_key');
      expect(result, isEmpty);
    });

    test('getFlyersIDsByPhid should return an empty list when provided with null phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final List<String> result = ScopeModel.getFlyersIDsByPhid(scope: scopeModel, phid: null);
      expect(result, isEmpty);
    });

    test('getFlyersIDsByPhid should return an empty list for a non-existing phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final List<String> result =
          ScopeModel.getFlyersIDsByPhid(scope: scopeModel, phid: 'non_existing_phid');
      expect(result, isEmpty);
    });

    test('getFlyersIDsByPhid should return a list of IDs for an existing phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final List<String> result =
          ScopeModel.getFlyersIDsByPhid(scope: scopeModel, phid: 'phid_key');
      expect(result, isNotEmpty);
      expect(result, equals(['idA', 'idB', 'idC']));
    });

    test('getAllFlyersIDs should return an empty list when provided with null ScopeModel', () {
      final List<String> result = ScopeModel.getAllFlyersIDs(null);
      expect(result, isEmpty);
    });

    test('getAllFlyersIDs should return an empty list when provided with an empty ScopeModel', () {
      final ScopeModel emptyScopeModel = ScopeModel(map: {});
      final List<String> result = ScopeModel.getAllFlyersIDs(emptyScopeModel);
      expect(result, isEmpty);
    });

    test('getAllFlyersIDs should return a list of all flyers IDs from a valid ScopeModel', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final List<String> result = ScopeModel.getAllFlyersIDs(scopeModel);
      expect(result, isNotEmpty);
      expect(result, containsAll(['idA', 'idB', 'idC', 'idD', 'idE', 'idF']));
    });

    test('addFlyerIDToPhid should return null when provided with null flyerID', () {
      final ScopeModel? result = ScopeModel.addFlyerIDToPhid(
          flyerID: null, phid: 'phid_key', scope: ScopeModel.dummyScope);
      expect(result, ScopeModel.dummyScope);
    });

    test('addFlyerIDToPhid should return null when provided with null phid', () {
      final ScopeModel? result = ScopeModel.addFlyerIDToPhid(
          flyerID: 'idX', phid: null, scope: ScopeModel.dummyScope);
      expect(result, ScopeModel.dummyScope);
    });

    test('addFlyerIDToPhid should return null when provided with null scope', () {
      final ScopeModel? result =
          ScopeModel.addFlyerIDToPhid(flyerID: 'idX', phid: 'phid_key', scope: null);
      expect(result, isNull);
    });

    test('addFlyerIDToPhid should return the updated ScopeModel with a new flyerID added', () {
      final ScopeModel initialScopeModel = ScopeModel.dummyScope;
      final String flyerIDToAdd = 'idX';
      final String phidToUpdate = 'phid_key';

      final ScopeModel? result = ScopeModel.addFlyerIDToPhid(
        flyerID: flyerIDToAdd,
        phid: phidToUpdate,
        scope: initialScopeModel,
      );

      expect(result, isNotNull);
      expect(result!.map, isNot(equals(initialScopeModel.map)));
      expect(result.map[phidToUpdate], contains(flyerIDToAdd));
    });

    test('checkScopeContainPhid should return false when provided with null ScopeModel', () {
      final bool result = ScopeModel.checkScopeContainPhid(scope: null, phid: 'phid_key');
      expect(result, isFalse);
    });

    test('checkScopeContainPhid should return false when provided with null phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final bool result = ScopeModel.checkScopeContainPhid(scope: scopeModel, phid: null);
      expect(result, isFalse);
    });

    test('checkScopeContainPhid should return true for an existing phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final bool result = ScopeModel.checkScopeContainPhid(scope: scopeModel, phid: 'phid_key');
      expect(result, isTrue);
    });

    test('checkScopeContainPhid should return false for a non-existing phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final bool result =
          ScopeModel.checkScopeContainPhid(scope: scopeModel, phid: 'non_existing_phid');
      expect(result, isFalse);
    });

    test('checkScopeContainsFlyerID should return false when provided with null ScopeModel', () {
      final bool result =
          ScopeModel.checkScopeContainsFlyerID(scope: ScopeModel.dummyScope, flyerID: 'idX');
      expect(result, isFalse);
    });

    test('checkScopeContainsFlyerID should return true for an existing flyerID', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final bool result = ScopeModel.checkScopeContainsFlyerID(scope: scopeModel, flyerID: 'idA');
      expect(result, isTrue);
    });

    test('checkScopeContainsFlyerID should return false for a non-existing flyerID', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final bool result =
          ScopeModel.checkScopeContainsFlyerID(scope: scopeModel, flyerID: 'non_existing_id');
      expect(result, isFalse);
    });

    test('checkScopesAreIdentical should return true for two identical ScopeModels', () {
      final ScopeModel scopeModel1 = ScopeModel.dummyScope;
      final ScopeModel scopeModel2 = ScopeModel.dummyScope;

      final bool result =
          ScopeModel.checkScopesAreIdentical(scope1: scopeModel1, scope2: scopeModel2);
      expect(result, isTrue);
    });

    test('checkScopesAreIdentical should return true for two null ScopeModels', () {
      final bool result = ScopeModel.checkScopesAreIdentical(scope1: null, scope2: null);
      expect(result, isTrue);
    });

    test('checkScopesAreIdentical should return false for one null and one non-null ScopeModels',
        () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;

      final bool result1 = ScopeModel.checkScopesAreIdentical(scope1: null, scope2: scopeModel);
      expect(result1, isFalse);

      final bool result2 = ScopeModel.checkScopesAreIdentical(scope1: scopeModel, scope2: null);
      expect(result2, isFalse);
    });

    test('checkScopesAreIdentical should return true for two empty ScopeModels', () {
      final ScopeModel emptyScopeModel1 = ScopeModel(map: {});
      final ScopeModel emptyScopeModel2 = ScopeModel(map: {});

      final bool result =
          ScopeModel.checkScopesAreIdentical(scope1: emptyScopeModel1, scope2: emptyScopeModel2);
      expect(result, isTrue);
    });

    test('checkScopesAreIdentical should return false for one empty and one non-empty ScopeModels',
        () {
      final ScopeModel emptyScopeModel = ScopeModel(map: {});
      final ScopeModel nonEmptyScopeModel = ScopeModel.dummyScope;

      final bool result1 =
          ScopeModel.checkScopesAreIdentical(scope1: emptyScopeModel, scope2: nonEmptyScopeModel);
      expect(result1, isFalse);

      final bool result2 =
          ScopeModel.checkScopesAreIdentical(scope1: nonEmptyScopeModel, scope2: emptyScopeModel);
      expect(result2, isFalse);
    });

    test('addFlyerToScope should return null when provided with null ScopeModel', () {
      final ScopeModel? result =
          ScopeModel.addFlyerToScope(scope: null, flyer: FlyerModel.dummyFlyer());
      expect(result, isNull);
    });

    test('addFlyerToScope should return null when provided with null FlyerModel', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final ScopeModel? result = ScopeModel.addFlyerToScope(scope: scopeModel, flyer: null);
      expect(result, scopeModel);
    });

    test('addFlyerToScope should return the updated ScopeModel with a new flyer added', () {
      final ScopeModel initialScopeModel = ScopeModel.dummyScope;
      final FlyerModel flyerToAdd = FlyerModel.dummyFlyer().copyWith(phids: ['phid_c']);

      final ScopeModel? result =
          ScopeModel.addFlyerToScope(scope: initialScopeModel, flyer: flyerToAdd);

      final ScopeModel _shouldBe = ScopeModel.addFlyerIDToPhid(
        flyerID: 'flyerID_dummy',
        phid: 'phid_c',
        scope: initialScopeModel,
      )!;

      expect(result, _shouldBe);
    });

    test('addFlyerToScope should handle null values within the FlyerModel gracefully', () {
      final ScopeModel initialScopeModel = ScopeModel.dummyScope;
      final FlyerModel flyerWithNullValues = FlyerModel(
        id: null,
        headline: null,
        trigram: null,
        description: null,
        authorID: null,
        flyerType: null,
        publishState: PublishState.published,
        phids: null,
        showsAuthor: null,
        bzID: null,
        position: null,
        slides: null,
        // specs: null,
        times: null,
        hasPriceTag: null,
        hasPDF: null,
        shareLink: null,
        price: null,
        isAmazonFlyer: null,
        zone: null,
        score: null,
        pdfPath: null,
        affiliateLink: null,
        gtaLink: null,
      );

      final ScopeModel? result =
          ScopeModel.addFlyerToScope(scope: initialScopeModel, flyer: flyerWithNullValues);

      expect(result, isNotNull);
      expect(result!.map, equals(initialScopeModel.map));
    });

    test('removeFlyer should return null when provided with null ScopeModel', () {
      final ScopeModel? result =
          ScopeModel.removeFlyer(scope: null, flyer: FlyerModel.dummyFlyer());
      expect(result, isNull);
    });

    test('removeFlyer should return null when provided with null FlyerModel', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final ScopeModel? result = ScopeModel.removeFlyer(scope: scopeModel, flyer: null);
      expect(result, ScopeModel.dummyScope);
    });

    test('removeFlyer should return the updated ScopeModel with the flyer removed', () {
      final ScopeModel initialScopeModel = ScopeModel.dummyScope;
      final FlyerModel flyerToRemove = FlyerModel.dummyFlyer();

      final ScopeModel _modified = ScopeModel.addFlyerToScope(scope: initialScopeModel, flyer: flyerToRemove)!;

      final bool _checkA = ScopeModel.checkScopeContainsFlyerID(
          scope: _modified,
          flyerID: flyerToRemove.id!
      );

      final ScopeModel? result = ScopeModel.removeFlyer(scope: _modified, flyer: flyerToRemove);

      final bool _check = ScopeModel.checkScopeContainsFlyerID(
          scope: result!,
          flyerID: flyerToRemove.id!
      );

      expect(_checkA, true);
      expect(_check, false);

    });

    test('removeFlyer should handle null values within the FlyerModel gracefully', () {
      final ScopeModel initialScopeModel = ScopeModel.dummyScope;
      final FlyerModel flyerWithNullValues = FlyerModel(
        id: null,
        headline: null,
        trigram: null,
        description: null,
        authorID: null,
        flyerType: null,
        publishState: PublishState.published,
        phids: null,
        showsAuthor: null,
        bzID: null,
        position: null,
        slides: null,
        // specs: null,
        times: null,
        hasPriceTag: null,
        hasPDF: null,
        shareLink: null,
        price: null,
        isAmazonFlyer: null,
        zone: null,
        score: null,
        pdfPath: null,
        affiliateLink: null,
        gtaLink: null,
      );

      final ScopeModel? result =
          ScopeModel.removeFlyer(scope: initialScopeModel, flyer: flyerWithNullValues);

      expect(result, isNotNull);
      expect(result!.map, equals(initialScopeModel.map));
    });

    test('getScopePhidUsage should return 0 when provided with null ScopeModel', () {
      final int result = ScopeModel.getScopePhidUsage(scope: null, phid: 'phid_key');
      expect(result, equals(0));
    });

    test('getScopePhidUsage should return 0 when provided with null phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final int result = ScopeModel.getScopePhidUsage(scope: scopeModel, phid: null);
      expect(result, equals(0));
    });

    test('getScopePhidUsage should return the number of flyers using the provided phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final String phidToCheck = 'phid_key';

      final int result = ScopeModel.getScopePhidUsage(scope: scopeModel, phid: phidToCheck);

      expect(result, equals(scopeModel.map[phidToCheck]?.length ?? 0));
    });

    test('getScopePhidUsage should return 0 for a non-existing phid', () {
      final ScopeModel scopeModel = ScopeModel.dummyScope;
      final String nonExistingPhid = 'non_existing_phid';

      final int result = ScopeModel.getScopePhidUsage(scope: scopeModel, phid: nonExistingPhid);

      expect(result, equals(0));
    });

    test('removeFlyerFromBz', () {
      final BzModel? oldBz = BzModel.dummyBz('x');
      final FlyerModel flyerToRemove = FlyerModel.dummyFlyer();

      final ScopeModel? newScope = ScopeModel.addFlyerToScope(
          scope: oldBz?.scopes,
          flyer: flyerToRemove
      );

      final BzModel? _bz = oldBz?.copyWith(
        scopes: newScope,
      );

      expect(oldBz != _bz, true);


      final BzModel? _newBz = ScopeModel.removeFlyerFromBz(
          bzModel: oldBz,
          flyerModel: flyerToRemove,
      );


      expect(_newBz == oldBz, true);
    });

     test('clean should return null when provided with null ScopeModel', () {
      final ScopeModel? result = ScopeModel.clean(null);
      expect(result, isNull);
    });

     test('ScopeModel clean', () {

      final ScopeModel? a = ScopeModel(
        map: {
          'phid1': ['a', 'b'],
          'phid2': ['x'],
          'phid3': [],
        },
      );

      final ScopeModel? b = ScopeModel(
        map: {
          'phid1': ['a', 'b'],
          'phid2': ['x'],
        },
      );

      final ScopeModel? _clean = ScopeModel.clean(a);

      expect(_clean, b);
    });

  });

}
