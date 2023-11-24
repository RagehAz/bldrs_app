import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/g_statistics/counters/flyer_counter_model.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/l_pdf_screen/c_pdf_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/g_flyer_counters_and_records.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_main_details.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_paragraph.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/info_page_separator.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/report_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/specs_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_fire_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/protocols/pdf_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class InfoPageContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageContents({
    required this.flyerBoxWidth,
    required this.flyerModel,
    required this.flyerCounter,
    required this.buttonExpanded,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel? flyerModel;
  final ValueNotifier<FlyerCounterModel?> flyerCounter;
  final ValueNotifier<bool?> buttonExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _pageWidth = FlyerDim.infoButtonWidth(
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: false,
      isExpanded: true,
      infoButtonType: null,
    );

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _userIsSignedIn = Authing.userIsSignedUp(_user?.signInMethod) ;

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
              builder: (_, bool? expanded, Widget? column){

                if (expanded == false){
                  return const SizedBox();
                }
                else {
                  return column!;
                }

              },
            child: Column(
              children: <Widget>[

                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// INFO HEADLINE
                if (TextCheck.isEmpty(flyerModel?.description) == false)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_more_about_this_flyer',
                      translate: true,
                    ),
                  ),
                /// INFO
                if (TextCheck.isEmpty(flyerModel?.description) == false)
                  InfoPageParagraph(
                    pageWidth: _pageWidth,
                    flyerInfo: flyerModel!.description!,
                  ),
                /// INFO LINE
                if (TextCheck.isEmpty(flyerModel?.description) == false)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// PDF BUTTON
                if (flyerModel?.pdfPath != null)
                  FutureBuilder(
                    future: PDFProtocols.fetch(flyerModel?.pdfPath),
                    builder: (_, AsyncSnapshot<PDFModel?> snap){

                      final PDFModel? _pdfModel = snap.data;
                      final String _name = _pdfModel == null ? '' : '${_pdfModel.name}.pdf';

                      return BldrsBox(
                        height: 40,
                        width: _pageWidth - 20,
                        color: Colorz.blue20,
                        verse: Verse(
                          id: _name,
                          translate: false,
                          casing: Casing.capitalizeFirstChar,
                        ),
                        // verseScaleFactor: 0.6,
                        icon: Iconz.pdf,
                        iconSizeFactor: 0.6,
                        verseCentered: false,
                        isDisabled: _pdfModel == null,
                        verseScaleFactor: 0.7/0.6,
                        secondLine: const Verse(
                          id: 'phid_pdf_attachment',
                          translate: true,
                        ),
                        onTap: () async {

                          await BldrsNav.goToNewScreen(
                            screen: PDFScreen(
                              pdf: _pdfModel,
                            ),
                          );

                          },

                      );

                    },
                  ),
                /// PDF LINE
                if (flyerModel?.pdfPath != null)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),

                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// KEYWORDS HEADLINE
                if (Mapper.checkCanLoopList(flyerModel?.phids) == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_keywords',
                      translate: true,
                    ),
                  ),
                /// KEYWORDS
                if (Mapper.checkCanLoopList(flyerModel?.phids) == true)
                  PhidsViewer(
                    pageWidth: _pageWidth,
                    phids: flyerModel!.phids!,
                    onPhidTap: (String phid){
                      blog('info page contents : onPhidTap : phid: $phid');
                    },
                    onPhidLongTap: (String phid){
                      blog('info page contents : onPhidLongTap : phid: $phid');
                    },
                  ),
                /// KEYWORDS LINE
                if (Mapper.checkCanLoopList(flyerModel?.phids) == true)
                  InfoPageSeparator( /// ------------------------- SEPARATOR
                    pageWidth: _pageWidth,
                  ),
                // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~0
                /// SPECS HEADLINE
                if (Mapper.checkCanLoopList(flyerModel?.specs) == true)
                  InfoPageHeadline(
                    pageWidth: _pageWidth,
                    verse: const Verse(
                      id: 'phid_specs',
                      translate: true,
                    ),
                  ),
                /// SPECS
                if (Mapper.checkCanLoopList(flyerModel?.specs) == true)
                  SpecsBuilder(
                    pageWidth: _pageWidth,
                    specs: flyerModel!.specs,
                    onSpecTap: ({SpecModel? value, SpecModel? unit}){
                      blog('Flyer : InfoPageContents : onSpecTap');
                      value?.blogSpec();
                      unit?.blogSpec();
                    },
                    onDeleteSpec: ({SpecModel? value, SpecModel? unit}){
                      blog('Flyer : InfoPageContents : onDeleteSpec');
                      value?.blogSpec();
                      unit?.blogSpec();
                    },
                  ),
                /// SPECS LINE
                if (Mapper.checkCanLoopList(flyerModel?.specs) == true)
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
                    width: flyerBoxWidth * 0.7,
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
