import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class SlideEditorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorControlPanel({
    @required this.onCropTap,
    @required this.onFitTap,
    @required this.onBack,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onCropTap;
  final Function onFitTap;
  final Function onBack;
  final double height;
  /// --------------------------------------------------------------------------
  static double getControlPanelHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, screenHeight);
    final double _controlPanelHeight = screenHeight - _slideZoneHeight;
    return _controlPanelHeight;
  }
// -----------------------------------------------------------------------------
  static double getButtonSize(BuildContext context, double controlPanelHeight){
    final double _buttonSize = controlPanelHeight * 0.6;
    return _buttonSize;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _controlPanelHeight = height;
    final double _buttonSize = getButtonSize(context, _controlPanelHeight);

    return SizedBox(
      width: _screenWidth,
      height: _controlPanelHeight,
      // color: Colorz.white10,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          /// CROP
          SlideEditorButton(
            size: _buttonSize,
            icon: superBackIcon(context),
            verse: 'Back',
            onTap: onBack,
          ),

          /// CROP
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.gears,
            verse: 'Crop',
            onTap: onCropTap,
          ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.fingerTap,
            verse: 'Fit',
            onTap: onFitTap,
          ),

        ],
      ),
    );
  }
}
