import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/c_collapsed_info_button_content.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/d_info_page_contents.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/info_button_type.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
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
  final ScrollController infoPageVerticalController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _cornerValue = InfoButtonStarter.expandedCornerValue(context: context, flyerBoxWidth: flyerBoxWidth);
    final BorderRadius _borders = Borderers.superBorderAll(context, _cornerValue);

    return ListView(
      key: const ValueKey<String>('InfoButtonContent'),
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[

        ClipRRect(
          borderRadius: _borders,
          child: Container(
            width: InfoButtonStarter.expandedWidth(context: context, flyerBoxWidth: flyerBoxWidth),
            height: InfoButtonStarter.expandedHeight(flyerBoxWidth: flyerBoxWidth),
            alignment: Alignment.center,
            child: Scroller(
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

                    /// COLLAPSED INFO BUTTON CONTENT
                    ValueListenableBuilder(
                        valueListenable: buttonIsExpanded,
                        child: CollapsedInfoButtonContent(
                          infoButtonType: infoButtonType,
                          flyerBoxWidth: flyerBoxWidth,
                          buttonIsExpanded: buttonIsExpanded,
                        ),
                        builder: (_, bool _buttonIsExpanded, Widget collapsedInfoButtonContent){

                          final double _paddingValue = _buttonIsExpanded ? 10 : 0;

                          return AnimatedAlign(
                              alignment: _buttonIsExpanded ? Alignment.center : superCenterAlignment(context),
                              duration: const Duration(milliseconds: 100),
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 100),
                                scale: _buttonIsExpanded ? 1.4 : 1,
                                child: AnimatedPadding(
                                  duration: const Duration(milliseconds: 100),
                                  padding: EdgeInsets.only(top: _paddingValue),
                                  child: collapsedInfoButtonContent,
                                ),
                              )
                          );

                        }
                    ),

                    /// INFO PAGE CONTENTS
                    if (tinyMode == false)
                      ValueListenableBuilder(
                        valueListenable: buttonIsExpanded,
                        builder: (_, bool buttonExpanded, Widget infoPageContents){

                          return AnimatedOpacity(
                            opacity: buttonExpanded == true ? 1 : 0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                            child: infoPageContents,
                          );

                        },

                        child: InfoPageContents(
                          flyerBoxWidth: flyerBoxWidth,
                          flyerModel: flyerModel,
                          flyerZone: flyerZone,
                        ),

                      ),


                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
