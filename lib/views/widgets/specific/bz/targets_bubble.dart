import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/targetz.dart' as Targetz;
import 'package:bldrs/models/bz/target/target_model.dart';
import 'package:bldrs/models/bz/target/target_progress.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/bz/dialogs/dialog_of_target_achievement.dart';
import 'package:flutter/material.dart';

class TargetsBubble extends StatelessWidget {

  const TargetsBubble({
    Key key
  }) : super(key: key);



// -----------------------------------------------------------------------------
  static List<TargetModel> getAllTargets(){

    final List<TargetModel> _allTargets = Targetz.insertTargetsProgressIntoTargetsModels(
      allTargets: Targetz.allTargets(),
      targetsProgress: Targetz.dummyTargetsProgress(),
    );

    return _allTargets;
  }
// -----------------------------------------------------------------------------
  Future<void> _onClaimTap({BuildContext context, TargetModel target}) async {

    await DialogOfTargetAchievement.show(
      context: context,
      target: target,
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleClearWidth = Bubble.clearWidth(context);
    final double _titleBoxWidth = _bubbleClearWidth / 2 + 20;
    const double _titleBoxHeight = 30;
    final double _progressBoxWidth = _bubbleClearWidth / 2 - 30;
    const double _barHeight = 12;
    const double _iconsHeight = 15;
    const EdgeInsets _barMargin = const EdgeInsets.only(top: 9);

    final List<TargetModel> _allTargets = getAllTargets();

    return Bubble(
      title: 'Targets',
      leadingIcon: Iconz.Achievement,

      columnChildren: <Widget>[

        SuperVerse(
          verse: 'Achieving the below targets will put you on track, and will give you an idea how to use Bldrs.net to acquire new customers and boost potential sales.',
          size: 2,
          maxLines: 10,
          centered: false,
          margin: 5,
          color: Colorz.yellow255,
          weight: VerseWeight.thin,
        ),

        ...List<Widget>.generate(
            _allTargets.length,
                (int index) {

              final TargetModel _target = _allTargets[index];
              final TargetProgress _progress = _target.progress;//_allProgress.singleWhere((prog) => prog.targetID == _target.id, orElse: () => null);

              final bool _targetReached = _progress.current == _progress.objective;

              return

                Container(
                  width: _bubbleClearWidth,
                  decoration: BoxDecoration(
                    color: Colorz.white10,
                    borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue),
                  ),
                  margin: const EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// TITLE AND PROGRESS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          /// TITLE
                          Container(
                            width: _titleBoxWidth,
                            height: _titleBoxHeight,
                            // color: Colorz.BloodTest,
                            child: SuperVerse(
                              verse: _target.name,
                              centered: false,
                              size: 2,
                              weight: VerseWeight.bold,
                              italic: false,
                              margin: 5,
                              color: Colorz.yellow255,
                            ),
                          ),
                          /// PROGRESS
                          Container(
                            width: _progressBoxWidth,
                            height: _titleBoxHeight,
                            alignment: Alignment.center,
                            // color: Colorz.BloodTest,
                            child: Stack(
                              children: <Widget>[

                                /// bar
                                Align(
                                  alignment: Alignment.center,
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
                                          width: _progressBoxWidth * (_progress.current/_progress.objective),
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
                                          weight: VerseWeight.bold,
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
                                  child: Container(
                                    width: _progressBoxWidth,
                                    height: _iconsHeight,
                                    // color: Colorz.Black255,
                                    child: Row(
                                      children: <Widget>[
                                        /// SLIDES
                                        DreamBox(
                                          height: _iconsHeight,
                                          icon: Iconz.Flyer,
                                          verse: '${_target.reward.slides} Slides',
                                          iconSizeFactor: 0.75,
                                          verseScaleFactor: 0.55,
                                          verseWeight: VerseWeight.thin,
                                          verseItalic: true,
                                          bubble: false,
                                        ),
                                        /// ANKHS
                                        DreamBox(
                                          height: _iconsHeight,
                                          icon: Iconz.Save,
                                          verse: '${_target.reward.ankh} Ankhs',
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
                          ),
                        ],
                  ),

                      /// DESCRIPTION
                      SuperVerse(
                    verse: _target.description,
                    centered: false,
                    size: 2,
                    weight: VerseWeight.thin,
                    italic: false,
                    maxLines: 10,
                    margin: 5,
                  ),

                      /// INSTRUCTIONS
                      if (_target.instructions != null && _target.instructions.length > 0 && _targetReached == false)
                        ... List<Widget>.generate(_target.instructions.length, (int index){

                          return
                            SuperVerse(
                              verse: _target.instructions[index],
                              leadingDot: true,
                              size: 1,
                              centered: false,
                              maxLines: 5,
                              margin: 2,
                              weight: VerseWeight.thin,
                              italic: true,
                              color: Colorz.blue225,
                            );

                        }),

                      /// CLAIM BUTTON
                      if (_targetReached == true)
                        DreamBox(
                          width: _bubbleClearWidth - 10,
                          height: 70,
                          verse: 'CLAIM',
                          verseWeight: VerseWeight.black,
                          verseItalic: true,
                          color: Colorz.yellow255,
                          verseColor: Colorz.black255,
                          onTap: () async {
                            _onClaimTap(
                              context: context,
                              target: _target,
                            );
                            },
                        ),

                ],
              ),
            );

        }),

      ],
    );
  }
}
