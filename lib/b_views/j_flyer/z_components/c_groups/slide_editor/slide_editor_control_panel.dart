import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/slide_editor/slide_editor_slide_part.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:scale/scale.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SlideEditorControlPanel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorControlPanel({
    @required this.onCancel,
    @required this.onResetMatrix,
    @required this.onCrop,
    @required this.onConfirm,
    @required this.height,
    @required this.canResetMatrix,
    @required this.draftNotifier,
    @required this.onTriggerAnimation,
    @required this.onToggleFilter,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onCancel;
  final Function onResetMatrix;
  final Function onCrop;
  final Function onConfirm;
  final double height;
  final ValueNotifier<bool> canResetMatrix;
  final ValueNotifier<DraftSlide> draftNotifier;
  final Function onTriggerAnimation;
  final Function onToggleFilter;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getControlPanelHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = SlideEditorSlidePart.getSlideZoneHeight(context, screenHeight);
    final double _controlPanelHeight = screenHeight - _slideZoneHeight;
    return _controlPanelHeight;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 5),
        children: <Widget>[

          /// BACK
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconizer.superBackIcon(context),
            verse: const Verse(
              id: 'phid_cancel',
              translate: true,
            ),
            onTap: onCancel,
          ),

          /// RESET MATRIX
          ValueListenableBuilder(
              valueListenable: canResetMatrix,
              builder: (_, bool _canResetMatrix, Widget child){

                return SlideEditorButton(
                  size: _buttonSize,
                  icon: Iconz.reload,
                  verse: const Verse(
                    id: 'phid_reset',
                    translate: true,
                  ),
                  isDisabled: !_canResetMatrix,
                  onTap: onResetMatrix,
                );

              }
          ),

          /// ANIMATE
          ValueListenableBuilder(
              valueListenable: draftNotifier,
              builder: (_, DraftSlide draftSlide, Widget child){

                final bool animate = draftSlide.animationCurve != null;

                return ValueListenableBuilder(
                    valueListenable: canResetMatrix,
                    builder: (_, bool canReset, Widget child) {
                      return SlideEditorButton(
                        size: _buttonSize,
                        icon: animate == true ? Iconz.flyerScale : Iconz.flyer,
                        verse: Verse(
                          id: animate == true ? 'phid_animated' : 'phid_static',
                          translate: true,
                        ),
                        isDisabled: !canReset,
                        onTap: onTriggerAnimation,
                      );
                    });
              }),

          ///  PLAN : SLIDE COLOR FILTER FEATURE
          // ValueListenableBuilder(
          //     valueListenable: draftNotifier,
          //     builder: (_, DraftSlide draftSlide, Widget child){
          //
          //       return SlideEditorButton(
          //         size: _buttonSize,
          //         icon: Iconz.colors,
          //         verse: const Verse(
          //           text: 'phid_filter',
          //           translate: true,
          //         ),
          //         onTap: onToggleFilter,
          //       );
          //     }
          //     ),

          // /// CROP
          // SlideEditorButton(
          //   size: _buttonSize,
          //   icon: Iconz.crop,
          //   verse: const Verse(
          //     text: 'phid_crop',
          //     translate: true,
          //   ),
          //   onTap: onCrop,
          // ),

          /// BOX FIT
          SlideEditorButton(
            size: _buttonSize,
            icon: Iconz.check,
            verse: const Verse(
              id: 'phid_confirm',
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
