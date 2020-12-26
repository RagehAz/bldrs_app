import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/pro_flyer/pro_flyer.dart';
import 'package:flutter/material.dart';

List<int> otherFlyers = [0,1,2,3,4,5,6,7,8,9,];

    /// this flyers Collection is used in main layouts
    /// Grid of flyers are put in the bubble and showing one main flyer as a cover
class CollectionWithCover extends StatelessWidget {
  final List<CoFlyer> flyersDataList;
  final String collectionTitle;

  CollectionWithCover({
    @required this.flyersDataList,
    @required this.collectionTitle,
});
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double pageMargin = Ratioz.ddAppBarMargin * 2;


    double coverFlyerWidth = 100;
    double coverFlyerHeight = coverFlyerWidth * Ratioz.xxflyerZoneHeight;


    double gridSpacing = 5;
    double gridWidth = screenWidth - (4*pageMargin) - gridSpacing;
    double gridHeight = coverFlyerHeight;

    double otherFlyersHeight = (coverFlyerHeight - gridSpacing)/2;
    double otherFlyersWidth = otherFlyersHeight / Ratioz.xxflyerZoneHeight;

    int gridLoopLength = flyersDataList.length > 11 ? 11 : flyersDataList.length;

    return InPyramidsBubble(
      centered: true,
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[

        BubbleTitle(verse: collectionTitle),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              width: coverFlyerWidth,
              height: coverFlyerHeight,
              child: ProFlyer(
                flyerSizeFactor: coverFlyerWidth/screenWidth,
                // flyerID: flyersDataList[0].flyer.flyerID,
                slidingIsOn: false,
                tappingFlyerZone: (){},
                currentSlideIndex: 0,
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
                    padding: EdgeInsets.all(gridSpacing),

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
                              child: ProFlyer(
                                flyerSizeFactor: otherFlyersWidth/screenWidth,
                                // flyerID: flyersDataList[index].flyer.flyerID,
                                slidingIsOn: false,
                                tappingFlyerZone: (){},
                                currentSlideIndex: 0,
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

class CollectionTopFlyers extends StatelessWidget {
  final List<CoFlyer> flyersDataList;
  final String collectionTitle;
  final int numberOfFlyers;

  CollectionTopFlyers({
    @required this.flyersDataList,
    @required this.collectionTitle,
    this.numberOfFlyers = 3,
});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double pageMargin = Ratioz.ddAppBarMargin * 2;

    double gridSpacing = 5;

    double gridWidth = screenWidth - (4*pageMargin);

    double flyerWidth = (gridWidth - (numberOfFlyers*gridSpacing) - gridSpacing)/numberOfFlyers;
    double flyerHeight = flyerWidth * Ratioz.xxflyerZoneHeight;

    double gridHeight = flyerHeight;

    int gridLoopLength = flyersDataList.length > numberOfFlyers ? numberOfFlyers : flyersDataList.length;

    return InPyramidsBubble(
      centered: false,
      bubbleColor: Colorz.WhiteAir,
      columnChildren: <Widget>[

        BubbleTitle(verse: collectionTitle),

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
                      tag: flyersDataList[index].flyer.flyerID,
                      child: Material(
                        type: MaterialType.transparency,
                        child: ProFlyer(
                          flyerSizeFactor: flyerWidth/screenWidth,
                          // flyerID: flyersDataList[index].flyer.flyerID,
                          slidingIsOn: false,
                          tappingFlyerZone: (){},
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

