import 'package:basics/components/sensors/app_version_builder.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('AppStateModel - appVersionIsValid', () {
    test('Valid app version format', () {
      const version = '1.2.3';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('Invalid app version format: missing version', () {
      const version = '';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: alphabetic characters', () {
      const version = '1.a.3';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: too many numbers', () {
      const version = '1.2.3.4';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: missing dot', () {
      const version = '1.23';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: leading dot', () {
      const version = '.1.2';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: trailing dot', () {
      const version = '1.2.';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, false);
    });
  });

  group('AppStateModel', () {
    test('appVersionIsValid - Valid app version format without build number', () {
      const version = '1.2.3';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('appVersionIsValid - Valid app version format with build number', () {
      const version = '1.2.3+1';
      final isValid = AppVersionBuilder.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('getAppVersionDivisions - Valid app version format without build number', () {
      const version = '1.2.3';
      final divisions = AppVersionBuilder.getAppVersionNumbered(version);
      expect(divisions, 123);
    });

    test('getAppVersionDivisions - Valid app version format with build number', () {
      const version = '1.2.3+1';
      final divisions = AppVersionBuilder.getAppVersionNumbered(version);
      expect(divisions, 123);
    });

    test('getAppVersionDivisions - Invalid app version format: missing version', () {
      const version = '';
      final divisions = AppVersionBuilder.getAppVersionNumbered(version);
      expect(divisions, null);
    });

    test('getAppVersionDivisions - Invalid app version format: alphabetic characters', () {
      const version = '1.a.3';
      final divisions = AppVersionBuilder.getAppVersionNumbered(version);
      expect(divisions, null);
    });

    test('getAppVersionDivisions - Invalid app version format: too many numbers', () {
      const version = '1.2.3.4';
      final divisions = AppVersionBuilder.getAppVersionNumbered(version);
      expect(divisions, null);
    });
  });

  group('AppStateModel - userNeedToUpdateApp', () {

    test('Both versions are valid, local version needs update', () {
      const globalVersion = '2.0.0';
      const localVersion = '1.5.0';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, true);
    });

    test('Both versions are valid, local version does not need update', () {
      const globalVersion = '2.0.0';
      const localVersion = '2.5.0';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Invalid global version format, local version is valid', () {
      const globalVersion = '2.a.0';
      const localVersion = '1.5.0';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Valid global version format, invalid local version format', () {
      const globalVersion = '2.0.0';
      const localVersion = '1.b.0';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('test', () {
      const globalVersion = '2.3.4';
      const localVersion = '2.3.3';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, true);
    });

    test('Missing global version, valid local version', () {
      const globalVersion = null;
      const localVersion = '1.5.0';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Valid global version, missing local version', () {
      const globalVersion = '1.2.3';
      const localVersion = '2.1.5';
      final shouldUpdate = AppVersionBuilder.versionIsBigger(
        thisIsBigger: globalVersion,
        thanThis: localVersion,
      );
      expect(shouldUpdate, false);
    });

  });

  group('getRouteSettingsNameFromFullPath', () {

    test('a', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('http://localhost:63065/#/home');
      expect(_is, '/home');
    });

    test('b', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('http://localhost:63065');
      expect(_is, '/');
    });

    test('c', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('http://localhost:63065/#/privacy');
      expect(_is, '/privacy');
    });

    test('d', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('http://localhost:63385/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P');
      expect(_is, '/flyerPreview:0Vyr4hWSwdbH1EsbOC4P');
    });

    test('e', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('https://www.bldrs.net/');
      expect(_is, '/');
    });

    test('f', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('https://www.bldrs.net/#/home');
      expect(_is, '/home');
    });

    test('g', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('https://www.bldrs.net/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P');
      expect(_is, '/flyerPreview:0Vyr4hWSwdbH1EsbOC4P');
    });

    test('h', () {
      final String? _is = RoutePather.getRouteSettingsNameFromFullPath('https://bldrs.net/redirect#access_token=EAAGFEb3LTB8BOZBWIefBYOCXlNYjVK4TDeJZCLQb7Rieme7EpOcoQ67B5wVSYZBhO4WIP6d1cGfuh3eEndsgE32pK5c4WGhCOHIICVLBmXsXExvV865YEXguZA4pKEOxEnIfChGwumm681uLARP87RxjmHj7LaaeoYe1LWXg5XPyEz2WnNMDBXGVoQZDZD&data_access_expiration_time=1716677812&expires_in=0');
      expect(_is, '/redirect#access_token=EAAGFEb3LTB8BOZBWIefBYOCXlNYjVK4TDeJZCLQb7Rieme7EpOcoQ67B5wVSYZBhO4WIP6d1cGfuh3eEndsgE32pK5c4WGhCOHIICVLBmXsXExvV865YEXguZA4pKEOxEnIfChGwumm681uLARP87RxjmHj7LaaeoYe1LWXg5XPyEz2WnNMDBXGVoQZDZD&data_access_expiration_time=1716677812&expires_in=0');
    });

  });

}
