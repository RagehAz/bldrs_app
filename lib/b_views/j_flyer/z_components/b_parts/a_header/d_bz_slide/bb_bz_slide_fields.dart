import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/z_black_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/info_button/expanded_info_page_parts/phids_wrapper.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgFields({
    required this.flyerBoxWidth,
    required this.bzScope,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final List<String> bzScope;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BlackBox(
      width: flyerBoxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          const BldrsText(
            verse: Verse(
              id: 'phid_scopeOfServices',
              translate: true,
            ),
            weight: VerseWeight.thin,
            margin: 10,
            color: Colorz.grey255,
            maxLines: 2,
          ),

          PhidsWrapper(
            width: flyerBoxWidth,
            phids: bzScope,
            onPhidTap: (String phid){
              blog('bzAboutPage : onPhidTap : phid: $phid');
              },
            onPhidLongTap: (String phid){
              blog('bzAboutPage : onPhidLongTap : phid: $phid');
              },
            margins: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
