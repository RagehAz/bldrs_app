import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_buttons.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_shadow.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyerFooter({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    @required this.tinyMode,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    @required this.footerPageController,
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  final bool tinyMode;
  final Function onSaveFlyer;
  final ValueNotifier<bool> flyerIsSaved;
  final PageController footerPageController;
  final ValueNotifier<bool> headerIsExpanded;

  @override
  State<FlyerFooter> createState() => _FlyerFooterState();
}

class _FlyerFooterState extends State<FlyerFooter> {
// -----------------------------------------------------------------------------
  void _onShareFlyer(){
    blog('YALLA YA BDAN');
  }
// -----------------------------------------------------------------------------
  void _onReviewFlyer(){
    blog('KOS OMMEK');
  }
// -----------------------------------------------------------------------------
  ValueNotifier<bool> infoButtonExpanded = ValueNotifier(false);
// ----------------------------------------
  void onInfoButtonTap(){
    infoButtonExpanded.value = ! infoButtonExpanded.value;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: widget.headerIsExpanded,
      builder: (_, bool _headerIsExpanded, Widget child){

        return AnimatedOpacity(
          opacity: _headerIsExpanded ? 0 : 1,
          duration: Ratioz.duration150ms,
          child: child,
        );

        },
      child: FooterBox(
        key: const ValueKey<String>('Flyer_footer_box'),
        flyerBoxWidth: widget.flyerBoxWidth,
        footerPageController: widget.footerPageController,
        infoButtonExpanded: infoButtonExpanded,
        footerPageViewChildren: <Widget>[

          /// FOOTER
          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BOTTOM SHADOW
              FooterShadow(
                key: const ValueKey<String>('FooterShadow'),
                flyerBoxWidth: widget.flyerBoxWidth,
              ),

              /// BUTTONS
              if (widget.tinyMode == false)
                FooterButtons(
                    key: const ValueKey<String>('FooterButtons'),
                    flyerBoxWidth: widget.flyerBoxWidth,
                    tinyMode: widget.tinyMode,
                    onSaveFlyer: widget.onSaveFlyer,
                    onReviewFlyer: _onReviewFlyer,
                    onShareFlyer: _onShareFlyer,
                    flyerIsSaved: widget.flyerIsSaved
                ),

              /// PRICE BUTTON
              if (widget.tinyMode == false)
                InfoButton(
                  flyerBoxWidth: widget.flyerBoxWidth,
                  flyerModel: widget.flyerModel,
                  flyerZone: widget.flyerZone,
                  tinyMode: widget.tinyMode,
                  infoButtonExpanded: infoButtonExpanded,
                  onInfoButtonTap: onInfoButtonTap,
                  infoButtonType: InfoButtonType.info,
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
