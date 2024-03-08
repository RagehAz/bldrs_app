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

    final double _bodyHeight =
              Scale.screenHeight(getMainContext())
            - editorPlayBarHeight
            - editorPanelHeight
            - navBarHeight;

    return _bodyHeight;
  }
  // --------------------
  static double videoZoneMargin = 10;
  // --------------------
  static double getVideoBoxHeight(){
    final double _videoZoneHeight =  VideoEditorScales.getVideoZoneHeight();
    final double _videoHeight = _videoZoneHeight - (videoZoneMargin * 2);
    return _videoHeight;
  }
  // --------------------------------------------------------------------------

  /// PLAY BAR

  // --------------------
  static const double editorPlayBarHeight = 30;
  // --------------------------------------------------------------------------

  /// EDITOR PANEL

  // --------------------
  static const double editorPanelHeight = 120;
  // --------------------------------------------------------------------------

  /// NAV BAR

  // --------------------
  static const double navBarHeight = 50;
  static const double navBarButtonSize = navBarHeight - 5;
  // --------------------------------------------------------------------------
  void x(){}
}
