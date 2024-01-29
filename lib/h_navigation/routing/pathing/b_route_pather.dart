part of bldrs_routing;

class RoutePather {
  // -----------------------------------------------------------------------------

  const RoutePather();

  // -----------------------------------------------------------------------------

  /// PATHS - ARGS - EXTRACTORS

  // --------------------
  /// BRIEFING
  /*
  .......................
  TEMPLATE :
  https://www.bldrs.net/#/screenName/pageName:someID
  PATH :
  /screenName/pageName
  ARG :
  someID
  DOMAIN :
  https://www.bldrs.net/
  FULL PATH :
  https://www.bldrs.net/#/screenName/pageName:someID
  ROUTE SETTINGS NAME :
  /screenName/pageName:someID
  .......................
  DEBUG DOMAIN :
  http://localhost:62861/
  RELEASE DOMAIN :
  https://www.bldrs.net/
  .......................
  DEBUG EXAMPLES
  http://localhost:60214/#/home
  http://localhost:60214/#/privacy
  http://localhost:60214/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
  .......................
  RELEASE EXAMPLES
  https://www.bldrs.net/
  https://www.bldrs.net/#/home
  https://www.bldrs.net/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
  .......................
  */
  // -----------------------------------------------------------------------------

  /// FROM ROUTE SETTINGS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPathFromRouteSettingsName(String? settingsName){

    return TextMod.removeTextAfterLastSpecialCharacter(
      text: settingsName,
      specialCharacter: ':',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getArgFromRouteSettingsName(String? settingsName){
    return TextMod.removeTextBeforeFirstSpecialCharacter(
      text: settingsName,
      specialCharacter: ':',
    );
  }
  // -----------------------------------------------------------------------------

  /// FROM WINDOW URL

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPathFromWindowURL(String? fullPath){
    final String? settingsName = getRouteSettingsNameFromFullPath(fullPath);
    return getPathFromRouteSettingsName(settingsName);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getArgFromWindowURL(String? fullPath){
    final String? settingsName = getRouteSettingsNameFromFullPath(fullPath);
    return getArgFromRouteSettingsName(settingsName);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getRouteSettingsNameFromFullPath(String? fullPath){
    String? _routeSettingsName;
    // .......................
    // DEBUG EXAMPLES
    // http://localhost:50356/#/home
    // http://localhost:50356/#/privacy
    // http://localhost:50356/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
    // .......................
    // RELEASE EXAMPLES
    // https://www.bldrs.net/
    // https://www.bldrs.net/#/home
    // https://www.bldrs.net/#/flyerPreview:0Vyr4hWSwdbH1EsbOC4P
    // .......................

    if (fullPath != null){

      _routeSettingsName = _removeExtraSlashAtTheEndIfExisted(fullPath);

      for (int i = 0; i < 4; i ++){

        final String _was = _routeSettingsName!;

        final String? _is = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _routeSettingsName,
          specialCharacter: '/',
        );

        blog('$i was : $_was : is : $_is : equals : ${_was == _is}');

        /// NOT CHANGED ( had no more slashes )
        if (_is == _was){
          _routeSettingsName = '';
          break;
        }

        /// SHRUNK ( had slash )
        else {
          _routeSettingsName = _is;
        }

      }

      _routeSettingsName = '/$_routeSettingsName';

    }

    return _routeSettingsName;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _removeExtraSlashAtTheEndIfExisted(String fullPath){
    String _output = fullPath;

    if (TextCheck.isEmpty(fullPath) == false){

      final String _lastChar = fullPath[fullPath.length-1];

      if (_lastChar == '/'){
        _output = TextMod.removeNumberOfCharactersFromEndOfAString(
          string: fullPath,
          numberOfCharacters: 1,
        )!;
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSettings(RouteSettings settings){
    blog('blogSettings : START');
    blog('settings.name : ${settings.name}');
    blog('settings.arguments : ${settings.arguments}');
  }
  // -----------------------------------------------------------------------------
}