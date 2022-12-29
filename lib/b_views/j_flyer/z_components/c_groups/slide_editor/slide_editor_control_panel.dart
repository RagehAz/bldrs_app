import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SlideEditorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorControlPanel({
    @required this.onCancel,
    @required this.onReset,
    @required this.onCrop,
    @required this.onConfirm,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onCancel;
  final Function onReset;
  final Function onCrop;
  final Function onConfirm;
  final double height;
  /// --------------------------------------------------------------------------
  static double getControlPanelHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, screenHeight);
    final double _controlPanelHeight = screenHeight - _slideZoneHeight;
    return _controlPanelHeight;
  }
  // --------------------
  static double getButtonSize(BuildContext context, double controlPanelHeight){
    final double _buttonSize = controlPanelHeight * 0.6;
    return _buttonSize;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _controlPanelHeight = height;
    final double _buttonSize = getButtonSize(context, _controlPanelHeight);
    // --------------------
    return SizedBox(
      width: _screenWidth,
      height: _controlPanelHeight,
      // color: Colorz.white10,
      child: Row(
        // physics: const BouncingScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          /// BACK
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconizer.superBackIcon(context),
            verse: const Verse(
              text: 'phid_cancel',
              translate: true,
            ),
            onTap: onCancel,
          ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.reload,
            verse: const Verse(
              text: 'phid_reset',
              translate: true,
            ),
            onTap: onReset,
          ),

          /// CROP
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.crop,
            verse: const Verse(
              text: 'phid_crop',
              translate: true,
            ),
            onTap: onCrop,
          ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.check,
            verse: const Verse(
              text: 'phid_confirm',
              translate: true,
            ),
            onTap: onConfirm,
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
