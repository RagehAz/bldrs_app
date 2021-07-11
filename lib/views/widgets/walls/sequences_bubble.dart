import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/s11_sequence_screen.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SequencesBubble extends StatelessWidget {
  final double gridZoneWidth;
  final int numberOfColumns;
  final Function onTap;

  SequencesBubble({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    final _prof = Provider.of<FlyersProvider>(context, listen: true);
    Section _currentSection = _prof.getCurrentSection;
    List<Sequence> _sequences = Sequence.getActiveSequencesBySection(context: context,section: _currentSection);

    const List<Color> _boxesColors = [Colorz.White30, Colorz.White20, Colorz.White10];

    int _gridColumnsCount = numberOfColumns;
    const double _spacingRatioToGridWidth = 0.1;
    double _buttonWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _buttonHeight = _buttonWidth * 1.65;
    double _gridSpacing = _buttonWidth * _spacingRatioToGridWidth;
    int _buttonsCount = _sequences == <int>[] || _sequences.length == 0 ? _boxesColors.length : _sequences.length;

    int _numOfGridRows(int buttonsCount){
      int _numOfGridRows = (buttonsCount/_gridColumnsCount).ceil();
      // int _numOfGridRows = buttonsCount
      return _numOfGridRows;
    }

    int _numOfRows = _numOfGridRows(_buttonsCount);

    double _gridHeight = _buttonHeight * (_numOfRows + (_numOfRows * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    SliverGridDelegateWithMaxCrossAxisExtent _gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    crossAxisSpacing: _gridSpacing,
    mainAxisSpacing: _gridSpacing,
    childAspectRatio: _buttonWidth / _buttonHeight,
    maxCrossAxisExtent: _buttonWidth,//gridFlyerWidth,
    );

    double _zoneCorners = (_buttonWidth * Ratioz.bzLogoCorner) + _gridSpacing;


    return InPyramidsBubble(
      bubbleColor: Colorz.White10,
      columnChildren: <Widget>[

        /// --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin),
          child: SuperVerse(
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
            color: Colorz.White10,
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

                            String _groupName = Sequence.getSequenceNameBySequenceAndSection(
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
                                      color: Colorz.Black125,
                                      icon: Keyword.getImagePath(sequence.titleID),
                                      onTap: (){

                                        Nav.goToNewScreen(context,
                                          SequenceScreen(
                                            sequence: sequence,
                                            flyersType: FlyerType.Non, // TASK : fix this shit
                                            section: _currentSection,
                                          ),
                                        );

                                      },
                                    ),

                                    /// GROUP NAME
                                    SuperVerse(
                                      verse: _groupName,
                                      centered: true,
                                      maxLines: 3,
                                      margin: Ratioz.appBarPadding,
                                      size: 2,
                                      scaleFactor: 0.95,
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
