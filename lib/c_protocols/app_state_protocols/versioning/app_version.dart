import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  // -----------------------------------------------------------------------------

  const AppVersion();

  // -----------------------------------------------------------------------------

  /// APP VERSION

  // --------------------
  /// TESTED : WORKS PERFECTLY
  static Future<String> getAppVersion() async {
    final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
    return _packageInfo.version;
  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static bool appVersionNeedUpdate({
    @required String globalVersion,
    @required String userVersion,
  }){
    bool _needUpdate = false;

    // blog('appVersionNeedUpdate : globalVersion : $globalVersion : userVersion : $userVersion');

    final List<int> _global = _getAppVersionDivisions(globalVersion);
    final List<int> _user = _getAppVersionDivisions(userVersion);

    for (int i = 0; i < _global.length; i++){
      if (_global[i] > _user[i]){
        _needUpdate = true;
        break;
      }
    }

    return _needUpdate;
  }
  // --------------------
  /// TESTED : WORKS PERFECTLY
  static List<int> _getAppVersionDivisions(String version){
    final List<int> _divisions = <int>[];

    if (version != null){
      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(version, '+');

      final List<String> _strings = _removedBuildNumber.split('.');

      for (final String string in _strings){

        final int _int = Numeric.transformStringToInt(string);

        _divisions.add(_int);
      }
    }

    return _divisions;
  }
  // --------------------
}
