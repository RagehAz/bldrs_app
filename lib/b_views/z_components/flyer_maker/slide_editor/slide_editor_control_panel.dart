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
    @required this.onEditorTap,
    @required this.onReset,
    @required this.onFlip,
    @required this.onBack,
    @required this.onBlend,
    @required this.onColor,
    @required this.onFilterTrigger,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onEditorTap;
  final Function onReset;
  final Function onFlip;
  final Function onBack;
  final Function onBlend;
  final Function onColor;
  final Function onFilterTrigger;
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

          /// BACK
          SlideEditorButton(
            size: _buttonSize,
            icon: superBackIcon(context),
            verse: 'Back',
            onTap: onBack,
          ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.fingerTap,
            verse: 'Reset',
            onTap: onReset,
          ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.fingerTap,
            verse: 'Flip',
            onTap: onFlip,
          ),

          /// BLEND
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.lab,
            verse: 'Blend',
            onTap: onBlend,
          ),

          /// COLOR
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.dvDonaldDuck,
            verse: 'Color',
            onTap: onColor,
          ),


          /// IMAGE EDITOR
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.cleopatra,
            verse: 'Filters',
            onTap: onFilterTrigger,
          ),

          /// IMAGE EDITOR
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.gears,
            verse: 'Image Editor',
            onTap: onEditorTap,
          ),

        ],
      ),
    );
  }
}
