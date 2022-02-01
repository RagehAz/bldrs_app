import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_buttons.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_shadow.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    @required this.footerPageController,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool tinyMode;
  final Function onSaveFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  final PageController footerPageController;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  void _onShareFlyer(){
    blog('enta feen ya ostaz rashwan');
  }
// -----------------------------------------------------------------------------
  void _onReviewFlyer(){
    blog('rouuuuuuuge');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: headerIsExpanded,
      builder: (_, bool isExpanded, Widget child){

        return AnimatedOpacity(
          opacity: isExpanded ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: child,
        );

        },
      child: FooterBox(
        key: const ValueKey<String>('Flyer_footer_box'),
        flyerBoxWidth: flyerBoxWidth,
        footerPageController: footerPageController,
        pageViewChildren: <Widget>[

          /// FOOTER
          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BOTTOM SHADOW
              FooterShadow(
                key: const ValueKey<String>('FooterShadow'),
                flyerBoxWidth: flyerBoxWidth,
              ),

              /// BUTTONS
              if (tinyMode == false)
                FooterButtons(
                    key: const ValueKey<String>('FooterButtons'),
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: tinyMode,
                    onSaveFlyer: onSaveFlyer,
                    onReviewFlyer: _onReviewFlyer,
                    onShareFlyer: _onShareFlyer,
                    flyerIsSaved: flyerIsSaved
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

          /// FAKE PAGE TO SLIDE FOOTER WHEN OUT OF SLIDES EXTENTS
          const SizedBox(),

        ],
      ),
    );

  }
}
