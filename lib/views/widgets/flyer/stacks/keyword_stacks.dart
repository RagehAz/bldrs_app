import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:flutter/material.dart';

List<int> otherFlyers = <int>[0,1,2,3,4,5,6,7,8,9,];

    /// this flyers Collection is used in main layouts
    /// Grid of flyers are put in the bubble and showing one main flyer as a cover
class FlyerCoversStack extends StatelessWidget {
  final List<FlyerModel> flyersDataList;
  final String collectionTitle;

  FlyerCoversStack({
    @required this.flyersDataList,
    @required this.collectionTitle,
});
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    const double pageMargin = Ratioz.appBarMargin * 2;


    const double coverFlyerWidth = 100;
    const double coverFlyerHeight = coverFlyerWidth * Ratioz.xxflyerZoneHeight;


    const double gridSpacing = 5;
    double gridWidth = screenWidth - (4*pageMargin) - gridSpacing;
    const double gridHeight = coverFlyerHeight;

    const double otherFlyersHeight = (coverFlyerHeight - gridSpacing)/2;
    const double otherFlyersWidth = otherFlyersHeight / Ratioz.xxflyerZoneHeight;

    int gridLoopLength = flyersDataList.length > 11 ? 11 : flyersDataList.length;

    return InPyramidsBubble(
      centered: true,
      bubbleColor: Colorz.White10,
      title: collectionTitle,
      columnChildren: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              width: coverFlyerWidth,
              height: coverFlyerHeight,
              child: FinalFlyer(
                flyerZoneWidth: coverFlyerWidth,
                flyerModel: flyersDataList[0],
              ),
            ),

            Expanded(
              child: Container(
                width: gridWidth,
                height: gridHeight,
                child: Center(
                  child: GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    addAutomaticKeepAlives: true,
                    padding: const EdgeInsets.all(gridSpacing),

                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                      childAspectRatio: otherFlyersWidth / otherFlyersHeight,
                      maxCrossAxisExtent: otherFlyersWidth,
                    ),
                    children: <Widget>[
                      for (int index = 1; index < gridLoopLength; index++)

                          Container(
                              width: otherFlyersWidth,
                              height: otherFlyersHeight,
                              child: FinalFlyer(
                                flyerZoneWidth: otherFlyersWidth,
                                initialSlideIndex: 0,
                                flyerModel: flyersDataList[index],
                                onSwipeFlyer: (i) => print('swiping to $i'),
                              )
                          )
                    ],

                    // )
                  ),
                ),
              ),
            )

          ],
        ),
      ]
    );
  }
}

class TopFlyersStack extends StatelessWidget {
  final List<FlyerModel> flyersDataList;
  final String collectionTitle;
  final int numberOfFlyers;

  TopFlyersStack({
    @required this.flyersDataList,
    @required this.collectionTitle,
    this.numberOfFlyers = 3,
});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double pageMargin = Ratioz.appBarMargin * 2;

    double gridSpacing = 5;

    double gridWidth = screenWidth - (4*pageMargin);

    double flyerWidth = (gridWidth - (numberOfFlyers*gridSpacing) - gridSpacing)/numberOfFlyers;
    double flyerHeight = flyerWidth * Ratioz.xxflyerZoneHeight;

    double gridHeight = flyerHeight;

    int gridLoopLength = flyersDataList.length > numberOfFlyers ? numberOfFlyers : flyersDataList.length;

    return InPyramidsBubble(
      centered: false,
      bubbleColor: Colorz.White10,
      title: collectionTitle,
      columnChildren: <Widget>[

        Container(
          width: gridWidth,
          height: gridHeight,
          alignment: Alignment.center,
          child: Center(
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              itemExtent: (flyerWidth + gridSpacing),

              children: <Widget>[
                for (int index = 0; index < gridLoopLength; index++)

                    Hero(
                      tag: flyersDataList[index].flyerID,
                      child: Material(
                        type: MaterialType.transparency,
                        child: FinalFlyer(
                          flyerZoneWidth: flyerWidth,
                          flyerModel: flyersDataList[index],
                        ),
                      ),
                    )
              ],
            ),
          ),
        ),
      ]
    );
  }
}

