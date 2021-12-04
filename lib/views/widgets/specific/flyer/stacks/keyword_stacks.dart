import 'package:bldrs/controllers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    const double pageMargin = Ratioz.appBarMargin * 2;


    const double coverFlyerWidth = 100;
    const double coverFlyerHeight = coverFlyerWidth * Ratioz.xxflyerZoneHeight;


    const double gridSpacing = 5;
    final double gridWidth = screenWidth - (4*pageMargin) - gridSpacing;
    const double gridHeight = coverFlyerHeight;

    const double otherFlyersHeight = (coverFlyerHeight - gridSpacing)/2;
    const double otherFlyersWidth = otherFlyersHeight / Ratioz.xxflyerZoneHeight;

    final int gridLoopLength = flyersDataList.length > 11 ? 11 : flyersDataList.length;

    return Bubble(
      centered: true,
      bubbleColor: Colorz.white10,
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
                flyerBoxWidth: coverFlyerWidth,
                flyerModel: flyersDataList[0],
                goesToEditor: false,
                onSwipeFlyer: (Sliders.SwipeDirection direction){
                  // print('Direction is ${direction}');
                },
              ),
            ),

            Expanded(
              child: Container(
                width: gridWidth,
                height: gridHeight,
                child: Center(
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    addAutomaticKeepAlives: true,
                    padding: const EdgeInsets.all(gridSpacing),

                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                flyerBoxWidth: otherFlyersWidth,
                                initialSlideIndex: 0,
                                flyerModel: flyersDataList[index],
                                goesToEditor: false,
                                onSwipeFlyer: (Sliders.SwipeDirection direction){
                                  // print('Direction is ${direction}');
                                },
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

  const TopFlyersStack({
    @required this.flyersDataList,
    @required this.collectionTitle,
    this.numberOfFlyers = 3,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    const double pageMargin = Ratioz.appBarMargin * 2;

    const double gridSpacing = 5;

    final double gridWidth = screenWidth - (4*pageMargin);

    final double flyerWidth = (gridWidth - (numberOfFlyers*gridSpacing) - gridSpacing)/numberOfFlyers;
    final double flyerHeight = flyerWidth * Ratioz.xxflyerZoneHeight;

    final double gridHeight = flyerHeight;

    final int gridLoopLength = flyersDataList.length > numberOfFlyers ? numberOfFlyers : flyersDataList.length;

    return Bubble(
      centered: false,
      bubbleColor: Colorz.white10,
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
                      tag: flyersDataList[index].id,
                      child: Material(
                        type: MaterialType.transparency,
                        child: FinalFlyer(
                          flyerBoxWidth: flyerWidth,
                          goesToEditor: false,
                          flyerModel: flyersDataList[index],
                          onSwipeFlyer: (Sliders.SwipeDirection direction){
                            // print('Direction is ${direction}');
                          },
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

