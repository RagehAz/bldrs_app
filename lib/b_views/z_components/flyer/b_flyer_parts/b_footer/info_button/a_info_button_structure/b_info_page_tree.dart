import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/footer_page.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/c_collapsed_info_button_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/e_expanded_info_page_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoPageTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageTree({
    @required this.flyerBoxWidth,
    @required this.infoButtonType,
    @required this.buttonIsExpanded,
    @required this.flyerModel,
    @required this.flyerZone,
    @required this.tinyMode,
    @required this.inFlight,
    @required this.infoPageVerticalController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final InfoButtonType infoButtonType;
  final ValueNotifier<bool> buttonIsExpanded;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
  final bool tinyMode;
  final bool inFlight;
  final ScrollController infoPageVerticalController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _cornerValue = InfoButtonStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
    );

    return FooterPageBox(
        width: InfoButtonStarter.expandedWidth(context: context, flyerBoxWidth: flyerBoxWidth),
        height: InfoButtonStarter.expandedHeight(flyerBoxWidth: flyerBoxWidth),
        borders: Borderers.superBorderAll(context, _cornerValue),
        alignment: Alignment.center,
        scrollerIsOn: true,
        child: ValueListenableBuilder(
          valueListenable: buttonIsExpanded,
          builder: (_, bool _buttonIsExpanded, Widget child){

            return ListView(
              controller: infoPageVerticalController,
              shrinkWrap: true,
              physics: _buttonIsExpanded == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero, /// ENTA EBN WES5A
              children: <Widget>[

                child

              ],

            );

          },

          child: Column(
            children: <Widget>[

              /// COLLAPSED INFO BUTTON TREE
              CollapsedInfoButtonTree(
                flyerBoxWidth: flyerBoxWidth,
                buttonIsExpanded: buttonIsExpanded,
                infoButtonType: infoButtonType,
                tinyMode: tinyMode,
              ),

              /// EXPANDED INFO PAGE TREE
              if (tinyMode == false && inFlight == false)
                ExpandedInfoPageTree(
                  buttonIsExpanded: buttonIsExpanded,
                  flyerBoxWidth: flyerBoxWidth,
                  flyerModel: flyerModel,
                  flyerZone: flyerZone,
                ),

            ],
          ),
        ),
    );

  }
}
