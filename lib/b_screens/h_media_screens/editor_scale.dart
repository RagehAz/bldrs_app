import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';

class EditorScale {
  // -----------------------------------------------------------------------------

  const EditorScale();

  // -----------------------------------------------------------------------------

  /// RATIOS

  // --------------------
  static const double _navHeightRatio = 0.15;
  static const double _panelHeightRatio = 0.25;
  // --------------------
  static double _mediaHeightRatio({
    required bool hasPanel,
  }){
    return hasPanel == true ?
    (1 - _panelHeightRatio - _navHeightRatio)
        :
    (1 - _navHeightRatio);
  }
  // -----------------------------------------------------------------------------

  /// NAV ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double navZoneHeight(){
    final double _screenHeight = Scale.screenHeight(getMainContext());
    return _screenHeight * _navHeightRatio;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double navButtonBoxHeight(){
    return navZoneHeight() - (2 * Ratioz.appBarMargin);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double navButtonSize(){
    return navButtonBoxHeight() * 0.6;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double navButtonTextHeight(){
    return navButtonBoxHeight() * 0.4;
  }
  // -----------------------------------------------------------------------------

  /// PANEL ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double panelZoneHeight({
    required bool isOn,
  }){
    final double _screenHeight = Scale.screenHeight(getMainContext());
    return (_screenHeight * _panelHeightRatio) - subPanelHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double subPanelHeight = 40;
  // -----------------------------------------------------------------------------

  /// MEDIA ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double mediaZoneHeight({
    required bool panelIsOn,
  }){
    final double _screenHeight = Scale.screenHeight(getMainContext());
    return _screenHeight * _mediaHeightRatio(hasPanel: panelIsOn);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double mediaHeight({
    required bool panelIsOn,
  }){
    final double _videoZoneHeight =  mediaZoneHeight(panelIsOn: panelIsOn);
    final double _videoHeight = _videoZoneHeight - (10 * 2);
    return _videoHeight;
  }
  // -----------------------------------------------------------------------------
}
