import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/footer_page_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/c_collapsed_info_button_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/e_expanded_info_page_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageTree({
    @required this.flyerBoxWidth,
    @required this.infoButtonType,
    @required this.buttonIsExpanded,
    @required this.flyerModel,
    @required this.tinyMode,
    @required this.inFlight,
    @required this.infoPageVerticalController,
    @required this.flyerCounter,
    @required this.onVerticalBounce,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final InfoButtonType infoButtonType;
  final ValueNotifier<bool> buttonIsExpanded;
  final FlyerModel flyerModel;
  final bool tinyMode;
  final bool inFlight;
  final ScrollController infoPageVerticalController;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  final Function onVerticalBounce;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FooterPageBox(
      width: FlyerDim.infoButtonWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        isExpanded: true,
        tinyMode: false,
        infoButtonType: infoButtonType,
      ),
      height: FlyerDim.infoButtonHeight(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false,
        isExpanded: true,
      ),
      borders: FlyerDim.infoButtonCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          tinyMode: false,
          isExpanded: true,
      ),
      alignment: Alignment.center,
      scrollerIsOn: false,
      child: ValueListenableBuilder(
        valueListenable: buttonIsExpanded,
        builder: (_, bool _buttonIsExpanded, Widget expandedInfoPageTree){

          return MaxBounceNavigator(
            boxDistance: FlyerDim.infoButtonHeight(
              context: context,
              flyerBoxWidth: flyerBoxWidth,
              tinyMode: false,
              isExpanded: true,
            ),
            isOn: _buttonIsExpanded,
            onNavigate: onVerticalBounce,
            slideLimitRatio: 0.22,
            child: ListView(
              controller: infoPageVerticalController,
              // shrinkWrap: false,
              physics: _buttonIsExpanded == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero, /// ENTA EBN WES5A
              children: <Widget>[

                // Column(
                //   // mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //
                //
                //   ],
                // )

                /// COLLAPSED INFO BUTTON TREE
                Align(
                  alignment: BldrsAligners.superCenterAlignment(context),
                  child: Container(
                    width: FlyerDim.infoButtonWidth(
                        context: context,
                        flyerBoxWidth: flyerBoxWidth,
                        tinyMode: tinyMode,
                        isExpanded: false,
                        infoButtonType: infoButtonType
                    ),
                    height: FlyerDim.infoButtonHeight(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      tinyMode: tinyMode,
                      isExpanded: false,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: FlyerDim.infoButtonCorners(
                        context: context,
                        flyerBoxWidth: flyerBoxWidth,
                        tinyMode: tinyMode,
                        isExpanded: false,
                      ),
                      // color: Colorz.blue255,
                    ),
                    child: CollapsedInfoButtonTree(
                      flyerBoxWidth: flyerBoxWidth,
                      buttonIsExpanded: buttonIsExpanded,
                      infoButtonType: infoButtonType,
                      tinyMode: tinyMode,
                    ),
                  ),
                ),

                /// EXPANDED INFO PAGE TREE
                if (tinyMode == false && inFlight == false)
                  expandedInfoPageTree,


              ],

            ),
          );

        },

        child: ExpandedInfoPageTree(
          buttonIsExpanded: buttonIsExpanded,
          flyerBoxWidth: flyerBoxWidth,
          flyerModel: flyerModel,
          flyerCounter: flyerCounter,
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
