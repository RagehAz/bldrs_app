import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class FlyerSelectionStack extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSelectionStack({
    @required this.flyerModel,
    @required this.onSelectFlyer,
    @required this.onFlyerOptionsTap,
    @required this.flyerBoxWidth,
    @required this.heroPath,
    @required this.isSelected,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onSelectFlyer;
  final Function onFlyerOptionsTap;
  final FlyerModel flyerModel;
  final double flyerBoxWidth;
  final String heroPath;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel == null){
      return const SizedBox();
    }

    else {
      // --------------------
      final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
      final BorderRadius _corners = FlyerDim.flyerCorners(context, flyerBoxWidth);
      final double _checkIconSize = FlyerDim.flyerBottomCornerValue(flyerBoxWidth) * 2;
      final bool _isSelectionMode = onSelectFlyer != null;
      // --------------------
      final bool _tinyMode = FlyerDim.isTinyMode(context, flyerBoxWidth);
      // --------------------
      return Stack(
        // alignment: Alignment.center,
        children: <Widget>[

          AbsorbPointer(
            absorbing: _isSelectionMode,
            child: Flyer(
              key: ValueKey<String>('FlyerSelectionStack${flyerModel.id}'),
              flyerModel: flyerModel,
              flyerBoxWidth: flyerBoxWidth,
              screenName: heroPath,
            ),
          ),

          /// NOT VERIFIED
          if (flyerModel.auditState != AuditState.verified && _tinyMode == true)
            WidgetFader(
              fadeType: FadeType.fadeIn,
              child: IgnorePointer(
                child: FlyerBox(
                  flyerBoxWidth: flyerBoxWidth,
                  boxColor: Colorz.black80,
                  stackWidgets: <Widget>[

                    Transform.scale(
                      scale: 2,
                      child: Transform.rotate(
                        angle: Numeric.degreeToRadian(-45),
                        child: Center(
                          child: WidgetFader(
                            fadeType: FadeType.repeatAndReverse,
                            duration: const Duration(seconds: 2),
                            child: SuperVerse(
                              verse: const Verse(
                                pseudo: 'Waiting\nVerification',
                                text: 'phid_waiting_verification',
                                translate: true,
                              ),
                              weight: VerseWeight.black,
                              italic: true,
                              scaleFactor: flyerBoxWidth * 0.008,
                              maxLines: 2,
                              color: Colorz.white125,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

          /// BLACK COLOR OVERRIDE
          if (isSelected == true)
            DreamBox(
              width: flyerBoxWidth,
              height: _flyerBoxHeight,
              color: Colorz.black150,
              corners: _corners,
            ),

          /// SELECTED TEXT
          if (isSelected == true)
            Container(
              width: flyerBoxWidth,
              height: _flyerBoxHeight,
              alignment: Alignment.center,
              child: SuperVerse(
                verse: const Verse(
                  text: 'phid_selected',
                  casing: Casing.upperCase,
                  translate: true,
                ),
                weight: VerseWeight.black,
                italic: true,
                scaleFactor: flyerBoxWidth / 100,
                shadow: true,
              ),
            ),

          /// CHECK ICON
          if (isSelected == true)
            Container(
              width: flyerBoxWidth,
              height: _flyerBoxHeight,
              alignment: Aligners.superInverseBottomAlignment(context),
              decoration: BoxDecoration(
                border: Border.all(color: Colorz.white20,),
                borderRadius: _corners,
              ),
              child: DreamBox(
                height: _checkIconSize,
                width: _checkIconSize,
                corners: _checkIconSize / 2,
                color: Colorz.green255,
                icon: Iconz.check,
                iconSizeFactor: 0.4,
                iconColor: Colorz.white255,
              ),
            ),

          /// TAP LAYER
          if (_isSelectionMode == true)
            DreamBox(
              height: _flyerBoxHeight,
              width: flyerBoxWidth,
              corners: _corners,
              bubble: false,
              splashColor: Colorz.yellow125,
              onTap: onSelectFlyer,
            ),

          /// FLYER OPTIONS BUTTON
          if (onFlyerOptionsTap != null)
            SuperPositioned(
              enAlignment: Alignment.bottomRight,
              verticalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
              horizontalOffset: FlyerDim.footerButtonMarginValue(flyerBoxWidth,),
              child: FooterButton(
                icon: Iconz.more,
                phid: 'phid_more',
                flyerBoxWidth: flyerBoxWidth,
                onTap: onFlyerOptionsTap,
                isOn: false,
                canTap: true,
                count: null,
              ),

              // child: DreamBox(
              //   width: FooterButton.,
              //   height: _footerHeight,
              //   // verse: superPhrase(context, 'phid_edit'),
              //   // verseScaleFactor: 0.7,
              //   // verseWeight: VerseWeight.thin,
              //   icon: Iconz.more,
              //   iconSizeFactor: 0.7,
              //   color: Colorz.black255,
              //   corners: superBorderAll(context, FooterBox.boxCornersValue(_gridFlyerWidth)),
              //   bubble: false,
              //   onTap: () => onFlyerOptionsTap(_flyer),
              // ),

            ),

        ],
      );
    }

  }
/// --------------------------------------------------------------------------
}
