import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/views/screens/b_landing/b_2_sequence_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SequencesBubble extends StatelessWidget {
  final double gridZoneWidth;
  final int numberOfColumns;
  final Function onTap;

  const SequencesBubble({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.onTap,
  });

  int _numOfGridRows(int buttonsCount){
    final int _numOfGridRows = (buttonsCount/numberOfColumns).ceil();
    // int _numOfGridRows = buttonsCount
    return _numOfGridRows;
  }

  @override
  Widget build(BuildContext context) {

    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    final Section _currentSection = _generalProvider.currentSection;

    final List<Sequence> _sequences = Sequence.getActiveSequencesBySection(context: context,section: _currentSection);

    const List<Color> _boxesColors = <Color>[Colorz.white30, Colorz.white20, Colorz.white10];

    const double _spacingRatioToGridWidth = 0.1;
    final double _buttonWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    final double _buttonHeight = _buttonWidth * 1.65;
    final double _gridSpacing = _buttonWidth * _spacingRatioToGridWidth;
    final int _buttonsCount = _sequences == <int>[] || _sequences.length == 0 ? _boxesColors.length : _sequences.length;


    final int _numOfRows = _numOfGridRows(_buttonsCount);

    final double _gridHeight = _buttonHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    final SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    crossAxisSpacing: _gridSpacing,
    mainAxisSpacing: _gridSpacing,
    childAspectRatio: _buttonWidth / _buttonHeight,
    maxCrossAxisExtent: _buttonWidth,//gridFlyerWidth,
    );

    final double _zoneCorners = (_buttonWidth * Ratioz.bzLogoCorner) + _gridSpacing;

    return Bubble(
      bubbleColor: Colorz.white10,
      columnChildren: <Widget>[

        /// --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin),
          child: const SuperVerse(
            verse: 'Section Sequences',
            centered: false,
            maxLines: 2,
          ),
        ),

        ClipRRect(
          borderRadius: Borderers.superBorderAll(context, _zoneCorners),
          child: Container(
            width: gridZoneWidth,
            height: _gridHeight,
            color: Colorz.white10,
            child: Stack(
              children: <Widget>[

                if (_sequences.length != 0)
                  GridView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(_gridSpacing),
                    // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                    gridDelegate: _gridDelegate,
                    children: _sequences.map(
                          (sequence) {

                            final String _groupName = Sequence.getSequenceNameBySequenceAndSection(
                              context: context,
                              section: _currentSection,
                              sequence: sequence,
                            );

                            return
                              Container(
                                width: _buttonWidth,
                                height: _buttonHeight,
                                // color: Colorz.BloodTest,
                                child: Column(
                                  children: <Widget>[

                                    /// GROUP ICON
                                    DreamBox(
                                      width: _buttonWidth,
                                      height: _buttonWidth,
                                      color: Colorz.black125,
                                      icon: Sequence.getSequenceImage(sequence.titleID),
                                      onTap: (){

                                        Nav.goToNewScreen(context,
                                          SequenceScreen(
                                            sequence: sequence,
                                            flyersType: FlyerType.non, // TASK : fix this shit
                                            section: _currentSection,
                                          ),
                                        );

                                      },
                                    ),

                                    /// GROUP NAME
                                    Container(
                                      width: _buttonWidth,
                                      height: _buttonHeight - _buttonWidth,
                                      // color: Colorz.BloodTest,
                                      child: SuperVerse(
                                        verse: _groupName,
                                        centered: true,
                                        maxLines: 3,
                                        margin: Ratioz.appBarPadding,
                                        size: 2,
                                        scaleFactor: 0.95,
                                      ),
                                    ),

                                  ],
                                ),
                              );
                          }


                    ).toList(),

                  ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
