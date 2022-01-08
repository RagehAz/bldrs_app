import 'package:bldrs/a_models/bz/target/target_model.dart';
import 'package:bldrs/a_models/bz/target/target_progress.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class TargetProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TargetProgressBar({@required this.target, Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  final TargetModel target;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _bubbleClearWidth = Bubble.clearWidth(context) - 10;
    const double _titleBoxHeight = 30;
    final double _progressBoxWidth = _bubbleClearWidth / 2 - 30;
    const double _barHeight = 12;
    const double _iconsHeight = 15;
    const EdgeInsets _barMargin = EdgeInsets.only(top: 9);

    final TargetProgress _progress = target.progress;

    return Container(
      width: _progressBoxWidth,
      height: _titleBoxHeight,
      alignment: Alignment.center,
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
                    verse: '${_progress?.current}/${_progress?.objective}',
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
                    verse: '${target.reward.slides} Slides',
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
                    verse: '${target.reward.ankh} Ankhs',
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
  }
}