// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('ScreenName', () {

    test('checkIsScreen', () {

      expect(ScreenName.checkIsScreen(routeName: ScreenName.logo), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.home), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.userPreview), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.bzPreview), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.flyerPreview), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.flyerReviews), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.underConstruction), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.banner), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.privacy), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.terms), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.deleteMyData), true);
      expect(ScreenName.checkIsScreen(routeName: ScreenName.dashboard), true);

      expect(ScreenName.checkIsScreen(routeName: TabName.bid_MyBz_Info), false);
      expect(ScreenName.checkIsScreen(routeName: 'phid_k_thing/phid_k_this/'), false);

    });

    test('checkIsScreen 2', () {

      expect(ScreenName.checkIsScreen(routeName: 'phid_k_thing/phid_k_this/'), false);

      // final bool _contains = TextCheck.stringContainsSubString(
      //     string: '/',
      //     subString: 'phid_k_thing/phid_k_this/'
      // );

      // expect(_contains, false);

    });

  });


}
