import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class ScopeSelectorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ScopeSelectorBubble({
    @required this.bzTypes,
    @required this.headlineVerse,
    @required this.selectedSpecs,
    @required this.onAddScope,
    @required this.bulletPoints,
    this.addButtonVerse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<BzType> bzTypes;
  final Verse headlineVerse;
  final List<SpecModel> selectedSpecs;
  final Function onAddScope;
  final List<Verse> bulletPoints;
  final Verse addButtonVerse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _phids = SpecModel.getSpecsIDs(selectedSpecs);

    return WidgetFader(
      fadeType: Mapper.checkCanLoopList(bzTypes) == true ?
      FadeType.stillAtMax
          :
      FadeType.stillAtMin,
      min: 0.35,
      absorbPointer: Mapper.checkCanLoopList(bzTypes) == false,
      child: Bubble(
        headerViewModel: BubbleHeaderVM(
          headlineVerse: headlineVerse,
        ),
        width: Bubble.bubbleWidth(context),
        columnChildren: <Widget>[

          BulletPoints(
            bulletPoints: bulletPoints,
          ),

          if (Mapper.checkCanLoopList(_phids) == true)
            PhidsViewer(
              pageWidth: Bubble.clearWidth(context),
              phids: _phids,
            ),

          DreamBox(
            height: PhidButton.getHeight(),
            // width: Bubble.clearWidth(context),
            verse: addButtonVerse ?? Verse(
              text: Mapper.checkCanLoopList(_phids) ?
              'phid_edit_scope'
                  :
              'phid_add_scope',
              translate: true,
            ),
            bubble: false,
            color: Colorz.white20,
            verseScaleFactor: 1.5,
            verseWeight: VerseWeight.thin,
            icon: Iconz.plus,
            iconSizeFactor: 0.4,
            iconColor: Colorz.white20,
            onTap: onAddScope,
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
