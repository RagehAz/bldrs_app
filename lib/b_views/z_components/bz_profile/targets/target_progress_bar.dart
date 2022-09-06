import 'package:bldrs/a_models/bz/target/target_model.dart';
import 'package:bldrs/a_models/bz/target/target_progress.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class TargetProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TargetProgressBar({
    @required this.target,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TargetModel target;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context) - 10;
    const double _titleBoxHeight = 30;
    final double _progressBoxWidth = _bubbleClearWidth / 2 - 30;
    const double _barHeight = 12;
    const double _iconsHeight = 15;
    const EdgeInsets _barMargin = EdgeInsets.only(top: 9);
    final TargetProgress _progress = target.progress;
    // --------------------
    return Container(
      width: _progressBoxWidth,
      height: _titleBoxHeight,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5),
      child: Stack(

        children: <Widget>[
          /// BAR
          Align(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                /// BASE BAR
                Container(
                  width: _progressBoxWidth,
                  height: _barHeight,
                  margin: _barMargin,
                  decoration: BoxDecoration(
                    color: Colorz.white20,
                    borderRadius: Borderers.superBorderAll(context, 3),
                  ),
                ),

                /// PROGRESS BAR
                Align(
                  alignment: Aligners.superCenterAlignment(context),
                  child: Container(
                    width: _progressBoxWidth *
                        (_progress.current / _progress.objective),
                    height: _barHeight,
                    margin: _barMargin,
                    decoration: BoxDecoration(
                      color: Colorz.yellow255,
                      borderRadius: Borderers.superBorderAll(context, 3),
                    ),
                  ),
                ),

                /// PROGRESS TEXT
                Container(
                  width: _progressBoxWidth,
                  height: _barHeight,
                  margin: const EdgeInsets.only(top: 9, left: 3, right: 3),
                  child: SuperVerse(
                    verse:  '${_progress?.current}/${_progress?.objective}',
                    size: 1,
                    scaleFactor: 0.8,
                    color: Colorz.black255,
                    centered: false,
                  ),
                ),
              ],
            ),
          ),

          /// ICONS
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: _progressBoxWidth,
              height: _iconsHeight,
              // color: Colorz.Black255,
              child: Row(
                children: <Widget>[
                  /// SLIDES
                  DreamBox(
                    height: _iconsHeight,
                    icon: Iconz.flyer,
                    verse:  '${target.reward.slides} ${xPhrase( context, '##Slides')}',
                    iconSizeFactor: 0.75,
                    verseScaleFactor: 0.55,
                    verseWeight: VerseWeight.thin,
                    verseItalic: true,
                    bubble: false,
                  ),

                  /// ANKHS
                  DreamBox(
                    height: _iconsHeight,
                    icon: Iconz.save,
                    verse:  '${target.reward.ankh} ${xPhrase( context, '##Ankhs')}',
                    iconSizeFactor: 0.75,
                    verseScaleFactor: 0.55,
                    verseWeight: VerseWeight.thin,
                    verseItalic: true,
                    bubble: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
