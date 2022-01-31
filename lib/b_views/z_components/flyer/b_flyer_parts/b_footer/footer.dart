import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    @required this.footerPageController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final Function onSaveFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  final PageController footerPageController;
  /// --------------------------------------------------------------------------
  static double boxCornersValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius corners({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _bottomCorner = boxCornersValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
      context: context,
      enBottomLeft: _bottomCorner,
      enBottomRight: _bottomCorner,
      enTopLeft: 0,
      enTopRight: 0,
    );

  }
// -----------------------------------------------------------------------------
  static double boxHeight({
    BuildContext context,
    double flyerBoxWidth,
    bool tinyMode,
  }) {

    final double _footerBTMargins = FooterButton.buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _footerBTRadius = FooterButton.buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _flyerFooterHeight =
        (2 * _footerBTMargins) + (2 * _footerBTRadius);

    return _flyerFooterHeight;
  }
// -----------------------------------------------------------------------------
  static Widget boxShadow({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {

    final double _flyerBottomCorners = boxCornersValue(flyerBoxWidth);

    final double _footerHeight = boxHeight(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Container(
      width: flyerBoxWidth,
      height: _footerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(_flyerBottomCorners),
          bottomRight: Radius.circular(_flyerBottomCorners),
        ),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colorz.black0, Colorz.black125, Colorz.black230],
            stops: <double>[0.35, 0.85, 1]),
      ),
    );
  }
// -----------------------------------------------------------------------------
  void _onShareTap(){
    blog('enta feen ya ostaz rashwan');
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _flyerFooterHeight = boxHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    return Align(
      alignment: Alignment.bottomCenter,

      /// --- FLYER FOOTER BOX
      child: SizedBox(
        width: flyerBoxWidth,
        height: _flyerFooterHeight,
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: footerPageController,
          children: <Widget>[

            /// FOOTER
            Stack(
              alignment: Alignment.center,
              children: <Widget>[

                /// BOTTOM SHADOW
                boxShadow(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
                ),

                /// SHARE BUTTON
                if (tinyMode == false)
                  Positioned(
                    right: Aligners.rightPositionInRightAlignmentEn(context, 0),
                    left: Aligners.leftPositionInRightAlignmentEn(context, 0),
                    bottom: 0,
                    child: Row(
                      children: <Widget>[

                        FooterButtonSpacer(
                            flyerBoxWidth: flyerBoxWidth,
                            tinyMode: tinyMode
                        ),

                        /// SHARE
                        FooterButton(
                          flyerBoxWidth: flyerBoxWidth,
                          icon: Iconz.share,
                          verse: Wordz.send(context),
                          isOn: false,
                          tinyMode: tinyMode,
                          onTap: _onShareTap,
                        ),

                        FooterButtonSpacer(
                            flyerBoxWidth: flyerBoxWidth,
                            tinyMode: tinyMode
                        ),

                        /// COMMENT
                        FooterButton(
                          flyerBoxWidth: flyerBoxWidth,
                          icon: Iconz.star,
                          verse: 'Review',
                          isOn: false,
                          tinyMode: tinyMode,
                          onTap: _onShareTap,
                        ),

                        FooterButtonSpacer(
                            flyerBoxWidth: flyerBoxWidth,
                            tinyMode: tinyMode
                        ),

                        /// SAVE BUTTON
                        ValueListenableBuilder(
                          valueListenable: flyerIsSaved,
                          builder: (_, bool isSaved, Widget child){

                            return FooterButton(
                              flyerBoxWidth: flyerBoxWidth,
                              icon: Iconz.save,
                              verse: isSaved == true ? Wordz.saved(context) : Wordz.save(context),
                              isOn: isSaved,
                              tinyMode: tinyMode,
                              onTap: onSaveFlyer,
                            );

                          },
                        ),

                        FooterButtonSpacer(
                            flyerBoxWidth: flyerBoxWidth,
                            tinyMode: tinyMode
                        ),

                      ],
                    ),
                  ),

                // / FLYER COUNTERS
                // if (!_tinyMode && saves != null && shares != null && views != null)
                //   SlideCounters(
                //     saves: saves,
                //     shares: shares,
                //     views: views,
                //     flyerBoxWidth: flyerBoxWidth,
                //     onCountersTap: onCountersTap,
                //   ),

              ],
            ),

            /// FAKE PAGE
            Container(),


          ],
        ),
      ),
    );
  }
}
