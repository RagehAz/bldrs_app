import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('AppStateModel - appVersionIsValid', () {
    test('Valid app version format', () {
      const version = '1.2.3';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('Invalid app version format: missing version', () {
      const version = '';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: alphabetic characters', () {
      const version = '1.a.3';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: too many numbers', () {
      const version = '1.2.3.4';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: missing dot', () {
      const version = '1.23';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: leading dot', () {
      const version = '.1.2';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });

    test('Invalid app version format: trailing dot', () {
      const version = '1.2.';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, false);
    });
  });

  group('AppStateModel', () {
    test('appVersionIsValid - Valid app version format without build number', () {
      const version = '1.2.3';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('appVersionIsValid - Valid app version format with build number', () {
      const version = '1.2.3+1';
      final isValid = AppStateModel.appVersionIsValid(version);
      expect(isValid, true);
    });

    test('getAppVersionDivisions - Valid app version format without build number', () {
      const version = '1.2.3';
      final divisions = AppStateModel.getAppVersionNumbered(version);
      expect(divisions, 123);
    });

    test('getAppVersionDivisions - Valid app version format with build number', () {
      const version = '1.2.3+1';
      final divisions = AppStateModel.getAppVersionNumbered(version);
      expect(divisions, 123);
    });

    test('getAppVersionDivisions - Invalid app version format: missing version', () {
      const version = '';
      final divisions = AppStateModel.getAppVersionNumbered(version);
      expect(divisions, null);
    });

    test('getAppVersionDivisions - Invalid app version format: alphabetic characters', () {
      const version = '1.a.3';
      final divisions = AppStateModel.getAppVersionNumbered(version);
      expect(divisions, null);
    });

    test('getAppVersionDivisions - Invalid app version format: too many numbers', () {
      const version = '1.2.3.4';
      final divisions = AppStateModel.getAppVersionNumbered(version);
      expect(divisions, null);
    });
  });

  group('AppStateModel - userNeedToUpdateApp', () {

    test('Both versions are valid, local version needs update', () {
      const globalVersion = '2.0.0';
      const localVersion = '1.5.0';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, true);
    });

    test('Both versions are valid, local version does not need update', () {
      const globalVersion = '2.0.0';
      const localVersion = '2.5.0';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Invalid global version format, local version is valid', () {
      const globalVersion = '2.a.0';
      const localVersion = '1.5.0';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Valid global version format, invalid local version format', () {
      const globalVersion = '2.0.0';
      const localVersion = '1.b.0';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('test', () {
      const globalVersion = '2.3.4';
      const localVersion = '2.3.3';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, true);
    });

    test('Missing global version, valid local version', () {
      const globalVersion = null;
      const localVersion = '1.5.0';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, false);
    });

    test('Valid global version, missing local version', () {
      const globalVersion = '1.2.3';
      const localVersion = '2.1.5';
      final shouldUpdate = AppStateModel.userNeedToUpdateApp(
        globalVersion: globalVersion,
        localVersion: localVersion,
      );
      expect(shouldUpdate, false);
    });

  });

}
