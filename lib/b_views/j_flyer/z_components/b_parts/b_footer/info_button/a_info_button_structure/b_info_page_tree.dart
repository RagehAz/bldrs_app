import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/footer_page_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/c_collapsed_info_button_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/e_expanded_info_page_tree.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
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
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _cornerValue = InfoButtonStarter.expandedCornerValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return FooterPageBox(
      width: InfoButtonStarter.expandedWidth(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
      ),
      height: InfoButtonStarter.expandedHeight(
        flyerBoxWidth: flyerBoxWidth,
      ),
      borders: Borderers.superBorderAll(context, _cornerValue),
      alignment: Alignment.center,
      scrollerIsOn: false,
      child: ValueListenableBuilder(
        valueListenable: buttonIsExpanded,
        builder: (_, bool _buttonIsExpanded, Widget expandedInfoPageTree){

          return ListView(
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
                alignment: Aligners.superCenterAlignment(context),
                child: Container(
                  width: InfoButtonStarter.getWidth(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      tinyMode: tinyMode,
                      isExpanded: _buttonIsExpanded,
                      infoButtonType: infoButtonType
                  ),
                  height: tinyMode ?
                  InfoButtonStarter.tinyHeight(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth
                  )
                      :
                  InfoButtonStarter.collapsedHeight(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    // tinyMode: tinyMode,
                    // isExpanded: _buttonIsExpanded,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: InfoButtonStarter.getBorders(
                      context: context,
                      flyerBoxWidth: flyerBoxWidth,
                      tinyMode: tinyMode,
                      isExpanded: _buttonIsExpanded,
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
