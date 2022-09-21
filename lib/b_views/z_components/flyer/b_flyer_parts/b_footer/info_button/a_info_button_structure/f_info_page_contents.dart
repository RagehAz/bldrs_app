import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/c_pdf_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/g_flyer_counters_and_records.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_main_details.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_paragraph.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_separator.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/z_components/flyer/e_flyer_special_widgets/report_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/ops/flyer_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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

          /// SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MAIN DETAILS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headlineVerse: const Verse(
              text: 'phid_main_details',
              translate: true,
            ),
          ),

          /// MAIN DETAILS : FLYER TYPE - PUBLISH TIME - ZONE
          InfoPageMainDetails(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
            flyerZone: flyerZone,
          ),

          /// SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          ValueListenableBuilder(
              valueListenable: buttonExpanded,
              builder: (_, bool expanded, Widget column){

                if (expanded == false){
                  return const SizedBox();
                }
                else {
                  return column;
                }

              },
            child: Column(
              children: <Widget>[
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// INFO HEADLINE
                if (flyerModel.description.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    headlineVerse: const Verse(
                      text: 'phid_more_about_this_flyer',
                      translate: true,
                    ),
                  ),
                /// INFO
                if (flyerModel.description.isNotEmpty == true)
                  InfoPageParagraph(
                    pageWidth: _pageWidth,
                    flyerInfo: flyerModel.description,
                  ),
                /// INFO LINE
                if (flyerModel.description.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// PDF BUTTON
                if (flyerModel.pdf != null)
                  DreamBox(
                    height: 30,
                    width: _pageWidth - 20,
                    color: Colorz.blue80,
                    verse: Verse.plain('${flyerModel.pdf.fileName}.pdf'),
                    verseScaleFactor: 0.6,
                    onTap: () async {

                      await Nav.goToNewScreen(
                        context: context,
                        screen: PDFScreen(
                          pdf: flyerModel.pdf,
                        ),
                      );

                    },
                  ),
                /// PDF LINE
                if (flyerModel.pdf != null)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// KEYWORDS HEADLINE
                if (flyerModel.keywordsIDs.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    headlineVerse: const Verse(
                      text: 'phid_flyer_keywords',
                      translate: true,
                    ),
                  ),
                /// KEYWORDS
                if (flyerModel.keywordsIDs.isNotEmpty == true)
                  PhidsViewer(
                    pageWidth: _pageWidth,
                    phids: flyerModel.keywordsIDs,
                  ),
                /// KEYWORDS LINE
                if (flyerModel.keywordsIDs.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// SPECS HEADLINE
                if (flyerModel.specs.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    headlineVerse: const Verse(
                      text: 'phid_specs',
                      translate: true,
                    ),
                  ),
                /// SPECS
                if (flyerModel.specs.isNotEmpty == true)
                  SpecsBuilder(
                    pageWidth: _pageWidth,
                    specs: flyerModel.specs,
                    onSpecTap: ({SpecModel value, SpecModel unit}){
                      blog('Flyer : InfoPageContents : onSpecTap');
                      value.blogSpec();
                      unit?.blogSpec();
                    },
                    onDeleteSpec: ({SpecModel value, SpecModel unit}){
                      blog('Flyer : InfoPageContents : onDeleteSpec');
                      value.blogSpec();
                      unit?.blogSpec();
                    },
                  ),
                /// SPECS LINE
                if (flyerModel.specs.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// COUNTERS
                FlyerCountersAndRecords(
                  pageWidth: _pageWidth,
                  flyerModel: flyerModel,
                  flyerCounter: flyerCounter,
                ),
                /// COUNTERS LINE
                InfoPageSeparator( /// ------------------------- SEPARATOR
                  pageWidth: _pageWidth,
                ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// REPORT BUTTON
                if (AuthModel.userIsSignedIn() == true)
                Align(
                  // alignment: Alignment.center,//Aligners.superCenterAlignment(context),
                  child: ReportButton(
                    modelType: ModelType.flyer,
                    onTap: () => FlyerFireOps.onReportFlyer(
                      context: context,
                      flyer: flyerModel,
                    ),
                  ),
                ),
                /// REPORT LINE
                if (AuthModel.userIsSignedIn() == true)
                  InfoPageSeparator(
                  pageWidth: _pageWidth,
                ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
              ],
            ),
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
