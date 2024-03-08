part of slide_video_editor;

class VideoEditorScales {
  // --------------------------------------------------------------------------

  const VideoEditorScales();

  // --------------------------------------------------------------------------

  /// BUTTON ID

  // --------------------
  static const String trimButtonID = 'trim';
  static const String cropButtonID = 'crop';
  static const String coverButtonID = 'cover';
  // --------------------------------------------------------------------------

  /// VIDEO ZONE

  // --------------------
  static double getVideoZoneHeight(){
    final double _screenHeight = Scale.screenHeight(getMainContext());
    const double _buttonsBarHeight = VideoEditorScales.navBarHeight;
    const double _panelHeight = VideoEditorScales.editorPanelHeight;
    final double _bodyHeight =  _screenHeight - _buttonsBarHeight - _panelHeight;
    return _bodyHeight;
  }
  // --------------------
  static double getVideoBoxHeight(){
    final double _videoZoneHeight =  VideoEditorScales.getVideoZoneHeight();
    final double _videoHeight = _videoZoneHeight - 10;
    return _videoHeight;
  }
  // --------------------------------------------------------------------------

  /// NAV BAR

  // --------------------
  static const double navBarHeight = 50;
  static const double navBarButtonSize = navBarHeight - 5;
  // --------------------------------------------------------------------------

  /// EDITOR PANEL

  // --------------------
  static const double editorPanelHeight = 100;
  // --------------------------------------------------------------------------
  void x(){}
}
