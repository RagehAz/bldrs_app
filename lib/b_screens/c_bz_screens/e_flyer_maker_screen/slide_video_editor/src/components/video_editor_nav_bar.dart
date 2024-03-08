part of slide_video_editor;

class VideoEditorButtonsBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorButtonsBar({
    required this.onBack,
    required this.selectedButton,
    required this.isMuted,
    required this.onCrop,
    required this.onForward,
    required this.onMute,
    required this.onRotate,
    required this.onTrim,
    super.key
  });
  // --------------------
  final Function onBack;
  final Function onForward;
  final Function onTrim;
  final Function onCrop;
  final Function onRotate;
  final Function onMute;
  final bool isMuted;
  final String? selectedButton;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    return FloatingList(
      width: _screenWidth,
      height: VideoEditorScales.navBarHeight,
      // boxColor: Colorz.blue20,
      scrollDirection: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      columnChildren: <Widget>[

        /// GO BACK
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: Iconz.arrowWhiteLeft,
          verse: Verse.plain('Back'),
          isSelected: false,
          onTap: onBack,
        ),

        const Spacing(size: 5),

        /// TRIM
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: Icons.cut,
          verse: Verse.plain('Trim'),
          isSelected: selectedButton == VideoEditorScales.trimButtonID,
          onTap: onTrim,
        ),

        const Spacing(size: 5),

        /// CROP
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: Iconz.crop,
          verse: Verse.plain('Crop'),
          isSelected: selectedButton == VideoEditorScales.cropButtonID,
          onTap: onCrop,
        ),

        const Spacing(size: 5),

        /// ROTATE
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: Icons.rotate_left,
          verse: Verse.plain('Rotate'),
          isSelected: false,
          onTap: onRotate,
        ),

        const Spacing(size: 5),

        /// MUTE
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: isMuted ? Icons.volume_off : Icons.volume_up,
          verse: Verse.plain('Mute'),
          isSelected: false,
          onTap: onMute,
        ),

        const Spacing(size: 5),

        /// CONFIRM
        PanelCircleButton(
          size: VideoEditorScales.navBarButtonSize,
          icon: Iconz.arrowWhiteRight,
          verse: Verse.plain('Confirm'),
          isSelected: false,
          onTap: onForward,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
