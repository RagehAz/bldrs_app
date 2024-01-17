// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values
import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/x_utilities/badger.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Badger tests', () {

    test('constructs with a valid map', () {
      final map = {'bid1': 42, 'bid2': 'hello'};
      final badger = Badger(map: map);
      expect(badger.map, map);
    });

    test('copyWith creates a new instance with optional map updates', () {
      final initialMap = {'bid1': 10, 'bid2': 'text'};
      final badger = Badger(map: initialMap);

      final updatedMap = {'bid1': 20, 'bid3': 'new'};
      final updatedBadger = badger.copyWith(map: updatedMap);

      expect(updatedBadger.map, isNot(same(initialMap)));
      expect(updatedBadger.map, updatedMap);
    });

    test('copyWith preserves original map if no updates are provided', () {
      final initialMap = {'bid1': 10, 'bid2': 'text'};
      final badger = Badger(map: initialMap);

      final copiedBadger = badger.copyWith();

      expect(copiedBadger.map, same(initialMap));
    });

    test('getBadge returns the correct value for an existing key', () {
      final map = {'bid1': 42, 'bid2': 'hello'};
      final badger = Badger(map: map);

      expect(badger.getBadge('bid1'), 42);
      expect(badger.getBadge('bid2'), 'hello');
    });

    test('getBadge returns null for a non-existent key', () {
      final map = {'bid1': 42};
      final badger = Badger(map: map);

      expect(badger.getBadge('bid2'), null);
    });

  });

  group('insertBadge tests', () {

    test('inserts a string badge correctly', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.insertBadge(
          badger: initialBadger, key: 'bid1', value: 'new');
      expect(updatedBadger.map, {'bid1': 'new'});
    });

    test('inserts a numeric badge correctly', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.insertBadge(
          badger: initialBadger, key: 'bid2', value: 10);
      expect(updatedBadger.map, {'bid2': 10});
    });

    test('increments an existing numeric badge', () {
      final initialBadger = Badger(map: const {'bid1': 5});
      final updatedBadger = Badger.insertBadge(
          badger: initialBadger, key: 'bid1', value: 3);
      expect(updatedBadger.map, {'bid1': 8});
    });

    test('removes a badge when the new value is 0', () {
      final initialBadger = Badger(map: const {'bid1': 5});
      final updatedBadger = Badger.insertBadge(
          badger: initialBadger, key: 'bid1', value: -5);
      expect(updatedBadger.map, {});
    });

    test('handles null keys and values gracefully', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.insertBadge(badger: initialBadger, key: null, value: null);
      expect(updatedBadger.map, {});
    });

    test('preserves original badger if key or value is null', () {
      final initialBadger = Badger(map: const {'bid1': 10});
      final updatedBadger1 = Badger.insertBadge(badger: initialBadger, key: null, value: 5);
      final updatedBadger2 = Badger.insertBadge(badger: initialBadger, key: 'bid2', value: null);
      expect(updatedBadger1.map, {'bid1': 10});
      expect(updatedBadger2.map, {'bid1': 10});
    });

    // Test for potential type errors:
    test('WTF ', () {
      final Badger initialBadger = Badger(map: const {});
      final Badger _result = Badger.insertBadge(badger: initialBadger, key: 'bid1', value: []);
      final Badger _expected = Badger(map: const {});

      final dynamic _a = _result.map['bid1'];
      final dynamic _b = _expected.map['bid1'];
      blog('_a : <${_a.runtimeType}>$_a : _b : <${_b.runtimeType}>$_b : equals ? : ${_a == _b}');
      expect(_result, _expected);
    });

// Test for edge cases with null values:
    test('handles null key and non-null value gracefully', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.insertBadge(badger: initialBadger, key: null, value: 'hello');
      expect(updatedBadger.map, {});
    });

    test('handles non-null key and null value gracefully', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.insertBadge(badger: initialBadger, key: 'bid1', value: null);
      expect(updatedBadger.map, {});
    });

// Test for potential edge cases with numeric values:
    test('xx', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.insertBadge(badger: initialBadger, key: 'bid1', value: 5);
      expect(updatedBadger.map, {'bid1': 5});
    });

    test('xxx', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.insertBadge(badger: initialBadger, key: 'bid1', value: 0);
      expect(updatedBadger.map, {});
    });

  });

  group('removeBadge tests', () {

    test('removes a string badge correctly', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1');
      expect(updatedBadger.map, {});
    });

    test('removes a numeric badge correctly', () {
      final initialBadger = Badger(map: const {'bid2': 10});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid2');
      expect(updatedBadger.map, {});
    });

    test('decrements an existing numeric badge', () {
      final initialBadger = Badger(map: const {'bid1': 5});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1', value: 3);
      expect(updatedBadger.map, {'bid1': 2});
    });

    test('removes a badge when the value becomes 0', () {
      final initialBadger = Badger(map: const {'bid1': 5});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1', value: 5);
      expect(updatedBadger.map, {});
    });

    test('handles null keys and values gracefully', () {
      final initialBadger = Badger(map: const {});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: null, value: null);
      expect(updatedBadger.map, {});
    });

    test('preserves original badger if key is null', () {
      final initialBadger = Badger(map: const {'bid1': 10});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: null, value: 5);
      expect(updatedBadger.map, {'bid1': 10});
    });

    test('txx', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      expect(Badger.removeBadge(badger: initialBadger, key: 'bid1', value: 5), Badger(map: const {}));
    });

    test('aa', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: null, value: 5);
      expect(updatedBadger.map, {'bid1': 'hello'});
    });

    test('handles non-null key and null value gracefully', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1', value: null);
      expect(updatedBadger.map, {});
    });

    test('does not decrement string badges', () {
      final initialBadger = Badger(map: const {'bid1': 'hello'});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1', value: 5);
      expect(updatedBadger.map, {});
    });

    test('does not decrement numeric badges below 0', () {
      final initialBadger = Badger(map: const {'bid1': 5});
      final updatedBadger = Badger.removeBadge(badger: initialBadger, key: 'bid1', value: 10);
      expect(updatedBadger.map, {});
    });

  });

  group('calculateGrandTotal tests', () {

    test('calculates grand total with only numbers', () {
      final badger = Badger(map: const {'bid1': 5, 'bid2': 'hello', 'bid3': 10});
      final grandTotal = Badger.calculateGrandTotal(badger: badger, onlyNumbers: true);
      expect(grandTotal, 15);
    });

    test('calculates grand total with all badges', () {
      final badger = Badger(map: const {'bid1': 5, 'bid2': 'hello', 'bid3': 10});
      final grandTotal = Badger.calculateGrandTotal(badger: badger, onlyNumbers: false);
      expect(grandTotal, 16);
    });

    test('handles empty badger gracefully', () {
      final badger = Badger(map: const {});
      final grandTotal = Badger.calculateGrandTotal(badger: badger, onlyNumbers: true);
      expect(grandTotal, 0);
    });

    test('returns 0 when Lister.checkCanLoop returns false', () {
      final badger = Badger(map: const {}); // Simulate a case where Lister.checkCanLoop returns false
      final grandTotal = Badger.calculateGrandTotal(badger: badger, onlyNumbers: true);
      expect(grandTotal, 0);
    });

    test('handles null values in badges gracefully', () {
      final badger = Badger(map: const {'bid1': null, 'bid2': 10});
      final grandTotal = Badger.calculateGrandTotal(badger: badger, onlyNumbers: true);
      expect(grandTotal, 10); // Only counts the non-null numeric badge
    });

  });

  group('getBadge', () {

    test('returns the badge count for a numeric badge', () {
      final badger = Badger(map: const {'bid1': 5});
      final count = Badger.getBadgeCount(bid: 'bid1', badger: badger);
      expect(count, 5);
    });

    test('returns null for a non-existent badge', () {
      final badger = Badger(map: const {});
      final count = Badger.getBadgeCount(bid: 'bid1', badger: badger);
      expect(count, null);
    });

    test('returns null for a string badge', () {
      final badger = Badger(map: const {'bid1': 'hello'});
      final count = Badger.getBadgeCount(bid: 'bid1', badger: badger);
      expect(count, null);
    });

    test('returns null for a null badge value', () {
      final badger = Badger(map: const {'bid1': null});
      final count = Badger.getBadgeCount(bid: 'bid1', badger: badger);
      expect(count, null);
    });

    test('returns null for a non-existent badge', () {
      final badger = Badger(map: const {});
      final verse = Badger.getBadgeVerse(bid: 'bid1', badger: badger);
      expect(verse, null);
    });

    test('returns null for a numeric badge', () {
      final badger = Badger(map: const {'bid1': 5});
      final verse = Badger.getBadgeVerse(bid: 'bid1', badger: badger);
      expect(verse, null);
    });

    test('returns null for a null badge value', () {
      final badger = Badger(map: const {'bid1': null});
      final verse = Badger.getBadgeVerse(bid: 'bid1', badger: badger);
      expect(verse, null);
    });

    test('returns null for an empty string badge value', () {
      final badger = Badger(map: const {'bid1': ''});
      final verse = Badger.getBadgeVerse(bid: 'bid1', badger: badger);
      expect(verse?.id, '');
    });

  });

}
