import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

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
    if (DeviceChecker.deviceIsAndroid() == true){
      return _packageInfo.version;
    }
    else if (DeviceChecker.deviceIsIOS() == true){
      return _packageInfo.buildNumber;
    }
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

    blog('appVersionNeedUpdate : _global : $_global | _user : $_user');

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

    blog('_getAppVersionDivisions : version : $version');

    if (version != null){
      final String _removedBuildNumber = TextMod.removeTextAfterLastSpecialCharacter(version, '+');

      final List<String> _strings = _removedBuildNumber.split('.');

      for (final String string in _strings){

        final int _int = Numeric.transformStringToInt(string);

        _divisions.add(_int);
      }
    }

    return _fixDivisions(_divisions);
  }
  // --------------------
  static List<int> _fixDivisions(List<int> divs){
    List<int> _output = <int>[];

    if (Mapper.checkCanLoopList(divs) == true){

      if (divs.length == 3){
        _output = divs;
      }
      else if (divs.length > 3){
        _output = [divs[0], divs[1], divs[2]];
      }
      else {
        _output = <int>[0,0,0];
        for (int i = 0; i < divs.length; i++){
          _output.removeAt(i);
          _output.insert(i, divs[i]);
        }
      }

    }
    else {
      _output = [0,0,0];
    }

    return _output;
  }
  // --------------------
}

