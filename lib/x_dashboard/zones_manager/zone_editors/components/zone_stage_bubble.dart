import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:scale/scale.dart';


import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class ZoneStageSwitcherBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneStageSwitcherBubble({
    @required this.zoneName,
    @required this.stageType,
    @required this.onSelectStageType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String zoneName;
  final StageType stageType;
  final ValueChanged<StageType> onSelectStageType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = BldrsAppBar.width(context);

    final double _buttonsBoxWidth = TileBubble.childWidth(context: context);

    final double _buttonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: 4,
      boxWidth: _buttonsBoxWidth,
      spacing: 5,
    );

    return TileBubble(
      bubbleWidth: _bubbleWidth,
      bubbleHeaderVM: BubbleHeaderVM(
        leadingIcon: Iconz.pyramid,
        leadingIconIsBubble: true,
        leadingIconBoxColor: Colorz.grey50,
        headlineVerse: Verse.plain('$zoneName Stage'),
      ),
      bulletPoints: <Verse>[

        Verse.plain('HIDDEN : Zone is not visible to anyone'),
        Verse.plain('INACTIVE : Zone is only visible to authors. when they [create a company] or [Create a Flyer]'),
        Verse.plain('ACTIVE : Zone is visible only to zone users (authors) & (users),  zone gets activated when a company creates a flyer in this zone'),
        Verse.plain('PUBLIC : Zone is visible to everyone, a Zone goes public when it reaches X number of (bzz * flyers / population)'),

      ],
      child: SizedBox(
        width: _buttonsBoxWidth,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            ...List.generate(Staging.zoneStagesList.length, (index){

              final StageType _type = Staging.zoneStagesList[index];
              final bool _isSelected = stageType == _type;

              return DreamBox(
                height: 40,
                width: _buttonWidth,
                verseScaleFactor: 0.6,
                verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                color: _isSelected == true ? Colorz.yellow255 : Colorz.white10,
                verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                verse: Verse(
                  text: Staging.cipherStageType(_type),
                  translate: false,
                  casing: Casing.capitalizeFirstChar,
                ),
                onTap: () => onSelectStageType(_type),
              );

            }),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
