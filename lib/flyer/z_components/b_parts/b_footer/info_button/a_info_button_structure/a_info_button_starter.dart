import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/b_info_page_tree.dart';
import 'package:bldrs/flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class InfoButtonStarter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoButtonStarter({
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.tinyMode,
    required this.infoButtonExpanded,
    required this.onInfoButtonTap,
    required this.infoButtonType,
    required this.infoPageVerticalController,
    required this.inFlight,
    required this.flyerCounter,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final bool tinyMode;
  final ValueNotifier<bool?> infoButtonExpanded;
  final Function onInfoButtonTap;
  final InfoButtonType infoButtonType;
  final ScrollController infoPageVerticalController;
  final bool inFlight;
  final ValueNotifier<FlyerCounterModel?> flyerCounter;
  // --------------------------------------------------------------------------
  bool _canTapInfoButton(){
    bool _canTap;

    if (tinyMode == true || inFlight == true){
      _canTap = false;
    }

    else {
      _canTap = true;
    }

    return _canTap;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Align(
      /// ALIGNS THE ENTIRE THING TO THE BOTTOM CORNER
      key: const ValueKey<String>('InfoButtonStarter'),
      alignment: BldrsAligners.superBottomAlignment(context),
      child: GestureDetector(
        onTap: _canTapInfoButton() ? () => onInfoButtonTap.call() : null,
        child: ValueListenableBuilder(
          valueListenable: infoButtonExpanded,
          builder: (_, bool? buttonExpanded, Widget? infoPageTree){


            // final Color _color = InfoButtonStarter.getColor(
            //     flyerBoxWidth: flyerBoxWidth,
            //     tinyMode: tinyMode,
            //     isExpanded: buttonExpanded
            // );

            return AnimatedContainer(
              key: const ValueKey<String>('InfoButtonStarter_animated_container'),
              width: FlyerDim.infoButtonWidth(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded,
                infoButtonType: infoButtonType,
              ),
              height: FlyerDim.infoButtonHeight(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded,
              ),
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                // color: _color,
                color: Colorz.black255,
                borderRadius: FlyerDim.infoButtonCorners(
                    flyerBoxWidth: flyerBoxWidth,
                    tinyMode: tinyMode,
                    isExpanded: buttonExpanded
                ),
              ),
              margin: FlyerDim.infoButtonMargins(
                flyerBoxWidth: flyerBoxWidth,
                tinyMode: tinyMode,
                isExpanded: buttonExpanded,
              ),
              alignment: Alignment.center,
              child: infoPageTree,
            );

          },

          child: InfoPageTree(
            key: const ValueKey<String>('InfoButtonStarter_InfoPageTree'),
            flyerModel: flyerModel,
            flyerBoxWidth: flyerBoxWidth,
            infoButtonType: infoButtonType,
            buttonIsExpanded: infoButtonExpanded,
            tinyMode: tinyMode,
            infoPageVerticalController: infoPageVerticalController,
            inFlight: inFlight,
            flyerCounter: flyerCounter,
            onVerticalBounce: _canTapInfoButton() ? () => onInfoButtonTap.call() : null,
          ),

        ),
      ),
    );

  }
  // --------------------------------------------------------------------------
}
