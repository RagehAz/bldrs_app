import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/g_flyer_counters_and_records.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_main_details.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_paragraph.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_separator.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_specs.dart';
import 'package:bldrs/b_views/z_components/flyer/e_flyer_special_widgets/report_button.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:flutter/material.dart';

class InfoPageContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageContents({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerCounter,
    @required this.flyerZone,
    @required this.buttonExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  final ZoneModel flyerZone;
  final ValueNotifier<bool> buttonExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _pageWidth = InfoButtonStarter.expandedWidth(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    return Container(
      key: const ValueKey<String>('InfoPageContents'),
      width: _pageWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[

          InfoPageSeparator( /// ------------------------- SEPARATOR
            pageWidth: _pageWidth,
          ),

          /// MAIN DETAILS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Main Details',
          ),

          /// MAIN DETAILS : FLYER TYPE - PUBLISH TIME - ZONE
          InfoPageMainDetails(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
            flyerZone: flyerZone,
          ),

          InfoPageSeparator( /// ------------------------- SEPARATOR
            pageWidth: _pageWidth,
          ),

          ValueListenableBuilder(
              valueListenable: buttonExpanded,
              builder: (_, bool expanded, Widget child){

                if (expanded == false){
                  return const SizedBox();
                }
                else {
                  return Column(
                    children: <Widget>[

                      /// KEYWORDS HEADLINE
                      if (flyerModel.keywordsIDs.isNotEmpty == true)
                        InfoPageHeadline(
                          pageWidth: _pageWidth,
                          headline: 'Flyer Keywords',
                        ),

                      /// KEYWORDS
                      if (flyerModel.keywordsIDs.isNotEmpty == true)
                        InfoPageKeywords(
                          pageWidth: _pageWidth,
                          keywordsIDs: flyerModel.keywordsIDs,
                        ),

                      if (flyerModel.keywordsIDs.isNotEmpty == true)
                        InfoPageSeparator( /// ------------------------- SEPARATOR
                          pageWidth: _pageWidth,
                        ),

                      /// SPECS HEADLINE
                      if (flyerModel.specs.isNotEmpty == true)
                        InfoPageHeadline(
                          pageWidth: _pageWidth,
                          headline: 'Flyer specifications',
                        ),

                      /// SPECS
                      if (flyerModel.specs.isNotEmpty == true)
                        InfoPageSpecs(
                          pageWidth: _pageWidth,
                          specs: flyerModel.specs,
                          flyerType: flyerModel.flyerType,
                        ),

                      if (flyerModel.specs.isNotEmpty == true)
                        InfoPageSeparator( /// ------------------------- SEPARATOR
                          pageWidth: _pageWidth,
                        ),

                      /// DESCRIPTION HEADLINE
                      if (flyerModel.description.isNotEmpty == true)
                        InfoPageHeadline(
                          pageWidth: _pageWidth,
                          headline: 'More about this flyer',
                        ),

                      /// INFO BODY
                      if (flyerModel.description.isNotEmpty == true)
                        InfoPageParagraph(
                          pageWidth: _pageWidth,
                          flyerInfo: flyerModel.description,
                        ),

                      FlyerCountersAndRecords(
                        pageWidth: _pageWidth,
                        flyerModel: flyerModel,
                        flyerCounter: flyerCounter,
                      ),

                      if (flyerModel.description.isNotEmpty == true)
                        InfoPageSeparator( /// ------------------------- SEPARATOR
                          pageWidth: _pageWidth,
                        ),

                      Align(
                        alignment: Aligners.superCenterAlignment(context),
                        child: ReportButton(
                          modelType: ModelType.flyer,
                          onTap: () => FlyerFireOps.onReportFlyer(
                            context: context,
                            flyer: flyerModel,
                          ),
                        ),
                      ),

                      InfoPageSeparator(
                        pageWidth: _pageWidth,
                      ),

                    ],
                  );
                }

              },
          ),

        ],
      ),
    );
  }
}
