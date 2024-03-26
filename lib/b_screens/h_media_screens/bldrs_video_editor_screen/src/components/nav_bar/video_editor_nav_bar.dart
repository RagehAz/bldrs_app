part of bldrs_video_editor;

class VideoEditorNavBar extends StatelessWidget {
  // --------------------------------------------------------------------------
  const VideoEditorNavBar({
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
  static const String trimButtonID = 'trim';
  static const String cropButtonID = 'crop';
  static const String coverButtonID = 'cover';
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _navButtonSize = EditorScale.navButtonSize();
    // --------------------
    return FloatingList(
      width: _screenWidth,
      height: EditorScale.navZoneHeight(),
      // boxColor: Colorz.blue20,
      scrollDirection: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      columnChildren: <Widget>[

        /// GO BACK
        EditorNavButton(
          size: _navButtonSize,
          icon: Iconz.exit,
          verse: const Verse(id: 'phid_exit', translate: true),
          onTap: onBack,
        ),

        /// TRIM
        EditorNavButton(
          size: _navButtonSize,
          icon: Icons.cut,
          verse: const Verse(id: 'phid_trim', translate: true),
          isSelected: selectedButton == VideoEditorNavBar.trimButtonID,
          onTap: onTrim,
        ),

        /// CROP
        EditorNavButton(
          size: _navButtonSize,
          icon: Iconz.crop,
          verse: const Verse(id: 'phid_crop', translate: true),
          isSelected: selectedButton == VideoEditorNavBar.cropButtonID,
          onTap: onCrop,
        ),

        /// ROTATE
        EditorNavButton(
          size: _navButtonSize,
          icon: Icons.rotate_left,
          verse: const Verse(id: 'phid_rotate', translate: true),
          onTap: onRotate,
        ),

        /// MUTE
        EditorNavButton(
          size: _navButtonSize,
          icon: isMuted ? Icons.volume_off : Icons.volume_up,
          verse: Verse(id: isMuted ? 'phid_un_mute' : 'phid_mute', translate: true),
          onTap: onMute,
        ),

        /// CONFIRM
        EditorNavButton(
          size: _navButtonSize,
          icon: Iconz.arrowWhiteRight,
          verse: const Verse(id: 'phid_confirm', translate: true),
          onTap: onForward,
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
