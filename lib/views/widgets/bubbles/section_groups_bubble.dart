import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/screens/s11_group_screen.dart';
import 'package:bldrs/views/screens/s52_bz_card_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/bz_grid.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'in_pyramids_bubble.dart';

class SectionGroupsBubble extends StatelessWidget {
  final double gridZoneWidth;
  final int numberOfColumns;
  final Function onTap;

  SectionGroupsBubble({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    final _prof = Provider.of<FlyersProvider>(context, listen: true);
    Section _currentSection = _prof.getCurrentSection;
    FlyerType _flyerType =
    _currentSection == Section.RealEstate ? FlyerType.Property :
    _currentSection == Section.Construction ? FlyerType.Design :
    _currentSection == Section.Supplies ? FlyerType.Product :
        FlyerType.General;

    List<GroupModel> _groups = GroupModel.getGroupsByFlyerType(flyerType: _flyerType);

    const List<Color> _boxesColors = [Colorz.White30, Colorz.WhiteGlass, Colorz.WhiteAir];

    int _gridColumnsCount = numberOfColumns;
    const double _spacingRatioToGridWidth = 0.1;
    double _buttonWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);
    double _buttonHeight = _buttonWidth * 1.4;
    double _gridSpacing = _buttonWidth * _spacingRatioToGridWidth;
    int _buttonsCount = _groups == <int>[] || _groups.length == 0 ? _boxesColors.length : _groups.length;

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
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[

        // --- Title
        Padding(
          padding: const EdgeInsets.only(bottom: Ratioz.appBarPadding, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin),
          child: SuperVerse(
            verse: 'Section groups',
            centered: false,
            maxLines: 2,
          ),
        ),

        ClipRRect(
          borderRadius: Borderers.superBorderAll(context, _zoneCorners),
          child: Container(
            width: gridZoneWidth,
            height: _gridHeight,
            color: Colorz.WhiteAir,
            child: Stack(
              children: <Widget>[

                if (_groups.length != 0)
                  GridView(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(_gridSpacing),
                    // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
                    gridDelegate: _gridDelegate,
                    children: _groups.map(
                          (sectionGroup) =>


                              Container(
                                width: _buttonWidth,
                                height: _buttonHeight,
                                // color: Colorz.BloodTest,
                                child: Column(
                                  children: <Widget>[

                                    DreamBox(
                                      width: _buttonWidth,
                                      height: _buttonWidth,
                                      color: Colorz.BlackPlastic,
                                      icon: KeywordModel.getImagePath(sectionGroup.firstKeyword),
                                      boxFunction: (){

                                        Nav.goToNewScreen(context,
                                            GroupScreen(
                                              groupModel: sectionGroup,
                                              flyersType: FlyerType.General,
                                            ),
                                        );

                                      },
                                    ),

                                    SuperVerse(
                                      verse: sectionGroup.firstKeyword,
                                      centered: true,
                                      maxLines: 3,
                                    ),

                                  ],
                                ),
                              ),

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
