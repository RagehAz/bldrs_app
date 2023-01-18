// import 'package:bldrs/a_models/x_ui/ui_image_cache_model.dart';
// import 'package:flutter_test/flutter_test.dart';

/// TAMAM
// void main() {
//
// TO TEST : YOU HAVE TO CHANGE image Type to String
//
//   const Cacher cacher1 = Cacher(id: '1', image: 'image1');
//   const Cacher cacher2 = Cacher(id: '2', image: 'image2');
//   const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//   final List<Cacher> cachers = [cacher1, cacher2];
//
//   group('AddCacherToCachers', () {
//     test('testAddCacherToCachers_validInput', () async {
//       final List<Cacher> result = await Cacher.addCacherToCachers(
//         cachers: cachers,
//         cacher: cacher3,
//       );
//
//       expect(result.length, 3);
//       expect(result[2].id, cacher3.id);
//       expect(result[2].image, cacher3.image);
//     });
//
//     test('testAddCacherToCachers_nullCacher', () async {
//       final List<Cacher> result = await Cacher.addCacherToCachers(
//         cachers: cachers,
//         cacher: null,
//       );
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testAddCacherToCachers_emptyCachers', () async {
//       final List<Cacher> result = await Cacher.addCacherToCachers(
//         cachers: [],
//         cacher: cacher3,
//       );
//
//       expect(result.length, 1);
//       expect(result[0].id, cacher3.id);
//       expect(result[0].image, cacher3.image);
//     });
//
//     test('testAddCacherToCachers_duplicateCacher', () async {
//       const Cacher cacher4 = Cacher(id: '2', image: 'image4');
//       final List<Cacher> result =
//           await Cacher.addCacherToCachers(cachers: cachers, cacher: cacher4);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testAddCacherToCachers_validInput', () async {
//       const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> result =
//           await Cacher.addCacherToCachers(cachers: cachers, cacher: cacher3);
//
//       expect(result.length, 3);
//       expect(result[2].id, cacher3.id);
//       expect(result[2].image, cacher3.image);
//     });
//
//     test('testAddCacherToCachers_nullCacher', () async {
//       final List<Cacher> result = await Cacher.addCacherToCachers(cachers: cachers, cacher: null);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testAddCacherToCachers_emptyCachers', () async {
//       const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> result = await Cacher.addCacherToCachers(cachers: [], cacher: cacher3);
//
//       expect(result.length, 1);
//       expect(result[0].id, cacher3.id);
//       expect(result[0].image, cacher3.image);
//     });
//
//     test('testAddCacherToCachers_nullCachers', () async {
//       const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> result = await Cacher.addCacherToCachers(cachers: null, cacher: cacher3);
//
//       expect(result, <Cacher>[cacher3]);
//     });
//   });
//
//   group('removeCacherFromCachers', () {
//     test('testRemoveCacherFromCachers_validInput', () {
//       final Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> cachersWithCacher3 = [cacher1, cacher2, cacher3];
//       final List<Cacher> result =
//           Cacher.removeCacherFromCachers(cachers: cachersWithCacher3, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_notContain', () {
//       final Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> result = Cacher.removeCacherFromCachers(cachers: cachers, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_nullCachers', () {
//       const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//
//       final List<Cacher> result = Cacher.removeCacherFromCachers(
//         cachers: null,
//         cacher: cacher3,
//       );
//
//       expect(result, <Cacher>[]);
//     });
//
//     test('testRemoveCacherFromCachers_emptyCachers', () {
//       final Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> result = Cacher.removeCacherFromCachers(cachers: [], cacher: cacher3);
//
//       expect(result, []);
//     });
//
//     test('testRemoveCacherFromCachers_nullCacher', () {
//       final List<Cacher> result = Cacher.removeCacherFromCachers(cachers: cachers, cacher: null);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_validInput_mismatchStringAndInt', () {
//       const Cacher cacher3 = Cacher(id: '3', image: 'image3');
//       final List<Cacher> cachersWithCacher3 = [cacher1, cacher2, cacher3];
//       final List<Cacher> result =
//           Cacher.removeCacherFromCachers(cachers: cachersWithCacher3, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_validInput_lowercase', () {
//       final Cacher cacher3 = Cacher(id: '3'.toLowerCase(), image: 'image3');
//       final List<Cacher> cachersWithCacher3 = [cacher1, cacher2, cacher3];
//       final List<Cacher> result =
//           Cacher.removeCacherFromCachers(cachers: cachersWithCacher3, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_validInput_uppercase', () {
//       final Cacher cacher3 = Cacher(id: '3'.toUpperCase(), image: 'image3');
//       final List<Cacher> cachersWithCacher3 = [cacher1, cacher2, cacher3];
//       final List<Cacher> result =
//           Cacher.removeCacherFromCachers(cachers: cachersWithCacher3, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//
//     test('testRemoveCacherFromCachers_validInput_spacedString', () {
//       const Cacher cacher3 = Cacher(id: '   3  ', image: 'image3');
//       final List<Cacher> cachersWithCacher3 = [cacher1, cacher2, cacher3];
//       final List<Cacher> result =
//           Cacher.removeCacherFromCachers(cachers: cachersWithCacher3, cacher: cacher3);
//
//       expect(result.length, 2);
//       expect(result, cachers);
//     });
//   });
//
//   group('cachersContainCacher', () {
//     test('testCachersContainCacher_validInput', () {
//       final bool result = Cacher.cachersContainCacher(cachers: cachers, cacherID: '2');
//       expect(result, true);
//     });
//
//     test('testCachersContainCacher_notContain', () {
//       final bool result = Cacher.cachersContainCacher(cachers: cachers, cacherID: '3');
//       expect(result, false);
//     });
//
//     test('testCachersContainCacher_nullCachers', () {
//       final bool result = Cacher.cachersContainCacher(cachers: null, cacherID: '3');
//       expect(result, false);
//     });
//
//     test('testCachersContainCacher_emptyCachers', () {
//       final bool result = Cacher.cachersContainCacher(cachers: [], cacherID: '3');
//       expect(result, false);
//     });
//
//     test('testCachersContainCacher_nullCacherID', () {
//       final bool result = Cacher.cachersContainCacher(cachers: cachers, cacherID: null);
//       expect(result, false);
//     });
//
//     test('testCachersContainCacher_validInput_lowercase', () {
//       final bool result =
//           Cacher.cachersContainCacher(cachers: cachers, cacherID: '2'.toLowerCase());
//       expect(result, true);
//     });
//
//     test('testCachersContainCacher_validInput_uppercase', () {
//       final bool result =
//           Cacher.cachersContainCacher(cachers: cachers, cacherID: '2'.toUpperCase());
//       expect(result, true);
//     });
//
//     test('testCachersContainCacher_validInput_spacedString', () {
//       final bool result = Cacher.cachersContainCacher(cachers: cachers, cacherID: '   2  ');
//
//       expect(result, false);
//     });
//
//     test('testCachersContainCacher_validInput_mismatchStringAndInt', () {
//       final bool result = Cacher.cachersContainCacher(cachers: cachers, cacherID: '2');
//
//       expect(result, true);
//     });
//   });
//
// }
