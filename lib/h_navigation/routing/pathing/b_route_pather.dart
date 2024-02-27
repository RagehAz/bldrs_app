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

    // blog('getPathFromRouteSettingsName : settingsName : $settingsName');
    final bool _isRedirect = TextCheck.stringContainsSubString(string: settingsName, subString: 'redirect');

    final String _separator = _isRedirect ? '#' : ':';

    return TextMod.removeTextAfterLastSpecialCharacter(
      text: settingsName,
      specialCharacter: _separator,
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getArgFromRouteSettingsName(String? settingsName){

    final bool _isRedirect = TextCheck.stringContainsSubString(string: settingsName, subString: 'redirect');
    final String _separator = _isRedirect ? '#' : ':';

    if (TextCheck.stringContainsSubString(string: settingsName, subString: _separator)){
      return TextMod.removeTextBeforeFirstSpecialCharacter(
        text: settingsName,
        specialCharacter: _separator,
      );
    }

    else {
      return null;
    }

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

      _routeSettingsName = Linker.removeExtraSlashAtTheEndIfExisted(fullPath);

      final bool _hasSharp = TextCheck.stringContainsSubString(string: _routeSettingsName, subString: '/#/');
      final int _numberOfSlashes = _hasSharp == true ? 4 : 3;

      for (int i = 0; i < _numberOfSlashes; i ++){

        final String _was = _routeSettingsName!;

        final String? _is = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _routeSettingsName,
          specialCharacter: '/',
        );

        // blog('$i was : $_was : is : $_is : equals : ${_was == _is}');

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
