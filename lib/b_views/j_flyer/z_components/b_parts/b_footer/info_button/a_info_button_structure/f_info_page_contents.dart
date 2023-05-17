import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/k_statistics/record_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/c_pdf_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/a_info_button_structure/g_flyer_counters_and_records.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_main_details.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_paragraph.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_separator.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/report_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class InfoPageContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageContents({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerCounter,
    @required this.buttonExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ValueNotifier<FlyerCounterModel> flyerCounter;
  final ValueNotifier<bool> buttonExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _pageWidth = FlyerDim.infoButtonWidth(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
      isExpanded: true,
      infoButtonType: null,
    );

    final bool _userIsSignedIn = Authing.userIsSignedIn();

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
            verse: const Verse(
              id: 'phid_main_details',
              translate: true,
            ),
          ),

          /// MAIN DETAILS : FLYER TYPE - PUBLISH TIME - ZONE
          InfoPageMainDetails(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
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
                if (flyerModel.description?.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_more_about_this_flyer',
                      translate: true,
                    ),
                  ),
                /// INFO
                if (flyerModel.description?.isNotEmpty == true)
                  InfoPageParagraph(
                    pageWidth: _pageWidth,
                    flyerInfo: flyerModel.description,
                  ),
                /// INFO LINE
                if (flyerModel.description?.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// PDF BUTTON
                if (flyerModel.pdfPath != null)
                  FutureBuilder(
                    future: PDFProtocols.fetch(flyerModel.pdfPath),
                    builder: (_, AsyncSnapshot<PDFModel> snap){

                      final PDFModel _pdfModel = snap.data;
                      final String _name = _pdfModel == null ? '' : '${_pdfModel.name}.pdf';

                      return BldrsBox(
                        height: 30,
                        width: _pageWidth - 20,
                        color: Colorz.blue80,
                        verse: Verse.plain(_name),
                        verseScaleFactor: 0.6,
                        isDisabled: _pdfModel == null,
                        onTap: () async {

                          await Nav.goToNewScreen(
                            context: context,
                            screen: PDFScreen(
                              pdf: _pdfModel,
                            ),
                          );

                          },

                      );

                    },
                  ),
                /// PDF LINE
                if (flyerModel.pdfPath != null)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// KEYWORDS HEADLINE
                if (flyerModel.phids?.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_keywords',
                      translate: true,
                    ),
                  ),
                /// KEYWORDS
                if (flyerModel.phids?.isNotEmpty == true)
                  PhidsViewer(
                    pageWidth: _pageWidth,
                    phids: flyerModel.phids,
                    onPhidTap: (String phid){
                      blog('info page contents : onPhidTap : phid: $phid');
                    },
                    onPhidLongTap: (String phid){
                      blog('info page contents : onPhidLongTap : phid: $phid');
                    },
                  ),
                /// KEYWORDS LINE
                if (flyerModel.phids?.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// SPECS HEADLINE
                if (flyerModel.specs?.isNotEmpty == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_specs',
                      translate: true,
                    ),
                  ),
                /// SPECS
                if (flyerModel.specs?.isNotEmpty == true)
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
                if (flyerModel.specs?.isNotEmpty == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// COUNTERS
                if (_userIsSignedIn == true)
                  FlyerCountersAndRecords(
                  pageWidth: _pageWidth,
                  flyerModel: flyerModel,
                  flyerCounter: flyerCounter,
                ),
                /// COUNTERS LINE
                if (_userIsSignedIn == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                  pageWidth: _pageWidth,
                ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// REPORT BUTTON
                if (_userIsSignedIn == true)
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
                if (_userIsSignedIn == true)
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
