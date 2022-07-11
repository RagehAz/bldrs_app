import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/a_info_button_structure/a_info_button_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_headline.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_main_details.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_paragraph.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_separator.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_specs.dart';
import 'package:flutter/material.dart';

class InfoPageContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageContents({
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.flyerZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final ZoneModel flyerZone;
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

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MAIN DETAILS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Main Details',
          ),

          /// MAIN DETAILS
          InfoPageMainDetails(
            pageWidth: _pageWidth,
            flyerModel: flyerModel,
            flyerZone: flyerZone,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// KEYWORDS HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Flyer Keywords',
          ),

          /// MAIN DETAILS
          InfoPageKeywords(
            pageWidth: _pageWidth,
            keywordsIDs: flyerModel.keywordsIDs,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
            pageWidth: _pageWidth,
            headline: 'Flyer specifications',
          ),

          /// SPECS
          InfoPageSpecs(
            pageWidth: _pageWidth,
            specs: flyerModel.specs,
            flyerType: flyerModel.flyerType,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

          /// MORE INFO HEADLINE
          InfoPageHeadline(
              pageWidth: _pageWidth,
              headline: 'More about this flyer',
          ),

          /// INFO BODY
          InfoPageParagraph(
            pageWidth: _pageWidth,
            flyerInfo: flyerModel.description,
          ),

          /// -------------------------------------------------------- SEPARATOR
          InfoPageSeparator(
            pageWidth: _pageWidth,
          ),

        ],
      ),
    );
  }
}
