import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/providers/combined_models/co_flyer.dart';
import 'package:bldrs/providers/combined_models/coflyer_provider.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_main.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/pro_flyer.dart';
import 'package:bldrs/views/widgets/pyramids/pyramids.dart';
import 'package:bldrs/views/widgets/space/skies/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:provider/provider.dart';

class ProFlyersGridView extends StatefulWidget {

  @override
  _ProFlyersGridViewState createState() => _ProFlyersGridViewState();
}

class _ProFlyersGridViewState extends State<ProFlyersGridView> {
  // ScrollController _controller;
  var _showAnkhsOnly = false;
  FlyerType currentFlyerType = FlyerType.General;

  List<FlyerType> flyerFilers = [
    FlyerType.General,
    FlyerType.Property,
    FlyerType.Design,
    FlyerType.Project,
    FlyerType.Product,
    FlyerType.Craft,
    FlyerType.Equipment,
  ];


  @override
  Widget build(BuildContext context) {
    final flyersData = Provider.of<CoFlyersProvider>(context, listen: true); // this is the FlyersProvider data wormHole
    // final flyers = _showAnkhsOnly ? flyersData.savedFlyers : flyersData.allFlyers;

    List<CoFlyer> propertyFlyers       = flyersData.hatCoFlyersByFlyerType(FlyerType.Property);
    // List<CoFlyer> savedPropertyFlyers  = flyersData.findSavedFlyers(propertyFlyers);

    List<CoFlyer> designFlyers         = flyersData.hatCoFlyersByFlyerType(FlyerType.Design);
    // List<CoFlyer> savedDesignFlyers    = flyersData.findSavedFlyers(designFlyers);

    List<CoFlyer> productFlyers        = flyersData.hatCoFlyersByFlyerType(FlyerType.Product);
    // List<CoFlyer> savedProductFlyers   = flyersData.findSavedFlyers(productFlyers);

    List<CoFlyer> projectFlyers        = flyersData.hatCoFlyersByFlyerType(FlyerType.Project);
    // List<CoFlyer> savedProjectFlyers   = flyersData.findSavedFlyers(projectFlyers);

    List<CoFlyer> craftFlyers          = flyersData.hatCoFlyersByFlyerType(FlyerType.Craft);
    // List<CoFlyer> savedCraftFlyers     = flyersData.findSavedFlyers(craftFlyers);

    List<CoFlyer> equipmentFlyers      = flyersData.hatCoFlyersByFlyerType(FlyerType.Equipment);
    // List<CoFlyer> savedEquipmentFlyers = flyersData.findSavedFlyers(equipmentFlyers);

        final flyers =
    currentFlyerType == FlyerType.Property &&  !_showAnkhsOnly? propertyFlyers :
    // currentFlyerType == FlyerType.Property &&  _showAnkhsOnly? savedPropertyFlyers :

    currentFlyerType == FlyerType.Design &&  !_showAnkhsOnly? designFlyers :
    // currentFlyerType == FlyerType.Design &&  _showAnkhsOnly? savedDesignFlyers :

    currentFlyerType == FlyerType.Project &&  !_showAnkhsOnly? projectFlyers :
    // currentFlyerType == FlyerType.Project &&  _showAnkhsOnly? savedProjectFlyers :

    currentFlyerType == FlyerType.Product &&  !_showAnkhsOnly? productFlyers :
    // currentFlyerType == FlyerType.Product &&  _showAnkhsOnly? savedProductFlyers :

    currentFlyerType == FlyerType.Craft &&  !_showAnkhsOnly? craftFlyers :
    // currentFlyerType == FlyerType.Craft &&  _showAnkhsOnly? savedCraftFlyers :

    currentFlyerType == FlyerType.Equipment &&  !_showAnkhsOnly? equipmentFlyers :
    // currentFlyerType == FlyerType.Equipment &&  _showAnkhsOnly? savedEquipmentFlyers :

    // _showAnkhsOnly ? flyersData.savedFlyers :
    flyersData.hatAllCoFlyers ;

      // int flyerIndex = 0;
// -------------------------------------------------------------------------
    double screenWidth = MediaQuery.of(context).size.width;

    int gridColumnsCount = currentFlyerType == FlyerType.General ? 4 : 2;
    int numberOfColumns = gridColumnsCount;
    double gridZoneWidth = screenWidth;
    // double flyerHeight = (gridZoneWidth * Ratioz.xxflyerZoneHeight);

    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    // double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;

    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;

    // int flyersCount = flyers.length;

    // int numOfGridRows(int flyersCount){
    //   return
    //     (flyersCount/gridColumnsCount).ceil();
    // }

    // int _numOfRows = numOfGridRows(flyersCount);

    // double gridBottomSpacing = gridZoneWidth * 0.15;
    // double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
        // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;

    // double flyerMainMargins = screenWidth - gridZoneWidth;

    double flyerSizeFactor = (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            NightSky(),

            GridView.builder(
              // physics: NeverScrollableScrollPhysics(),
              addAutomaticKeepAlives: true,
              padding: EdgeInsets.only(right: gridSpacing, left: gridSpacing, top: ((10 )+Ratioz.stratosphere), bottom: gridSpacing * 5 ),
              // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
                maxCrossAxisExtent: gridFlyerWidth,//gridFlyerWidth,
              ),
              itemCount: flyers.length,
              itemBuilder: (ctx, i) =>
                  ChangeNotifierProvider.value(
                      value: flyers[i],
                      // or we can use other syntax like :-
                      // ChangeNotifierProvider(//     create: (c) => flyers[i],
                      child: Padding(
                        key: Key(flyers[i].flyer.flyerID),
                        padding: const EdgeInsets.only(bottom: 0),
                        child: ProFlyer(
                          // flyerID: flyers[i].flyer.flyerID,
                          flyerSizeFactor: flyerSizeFactor,
                          currentSlideIndex: 0,
                          slidingIsOn: true,
                          tappingFlyerZone: (){
                            // Navigator.of(context).pushNamed(
                            //   FlyerScreen.routeName,
                            //   arguments: flyers[i],
                            // );
                            },
                        ),
                      )
                  ),
            ),

            Pyramids(whichPyramid: Iconz.PyramidsYellow),

            ABStrip(
              scrollable: true,
              rowWidgets:[

                DreamBox(
                  height: 40,
                  width: 40,
                  boxMargins: EdgeInsets.all(5),
                  icon: Iconz.SavedFlyers,
                  iconSizeFactor: 0.8,
                  // verse: 'Saved\nFlyers',
                  // verseScaleFactor: 0.7,
                  // verseMaxLines: 2,
                  // verseColor: _showAnkhsOnly == true ? Colorz.BlackBlack : Colorz.White,
                  color: _showAnkhsOnly == true ? Colorz.Yellow : Colorz.Nothing,
                  boxFunction: (){
                    setState(() {
                      _showAnkhsOnly = !_showAnkhsOnly;
                    });
                    },
                ),

                // --- Property filter
                // DreamBox(
                //   height: 40,
                //   width: 40,
                //   boxMargins: EdgeInsets.all(5),
                //   icon: flyerTypeFilter == FlyerType.Property ? Iconz.BxPropertiesOn : Iconz.BxPropertiesOff,
                //   iconSizeFactor: 0.8,
                //   color: flyerTypeFilter == FlyerType.Property ? Colorz.Yellow : Colorz.Nothing,
                //   boxFunction: (){
                //     setState(() {
                //       flyerTypeFilter != FlyerType.Property ?
                //       flyerTypeFilter = FlyerType.Property :
                //       flyerTypeFilter = FlyerType.General
                //       ;
                //     });
                //   },
                // ),

                ...List<Widget>.generate(
                  flyerFilers.length,
                      (i) => FilterButton(
                      flyerTypeFilter: flyerFilers[i],
                      currentFlyerType : currentFlyerType,
                      tapButton: (FlyerType selectedFlyerType){setState(() {
                        currentFlyerType = selectedFlyerType;
                        _showAnkhsOnly = false;
                      });},
                    )),

              ],
            ),


            // Rageh(
            //   tappingRageh:
            //       getTranslated(context, 'Active_Language') == 'Arabic' ?
            //           () async {
            //               Locale temp = await setLocale('en');
            //               BldrsApp.setLocale(context, temp);
            //             } :
            //           () async {
            //               Locale temp = await setLocale('ar');
            //               BldrsApp.setLocale(context, temp);
            //             },
            //   doubleTappingRageh: () {print(screenHeight * 0.0075 / screenWidth);},
            // ),

          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final FlyerType flyerTypeFilter;
  final Function tapButton;
  final FlyerType currentFlyerType;

  FilterButton({
    @required this.flyerTypeFilter,
    @required this.tapButton,
    @required this.currentFlyerType,
});


  @override
  Widget build(BuildContext context) {

    String icon =
    flyerTypeFilter == FlyerType.Property && currentFlyerType == FlyerType.Property? Iconz.BxPropertiesOn :
    flyerTypeFilter == FlyerType.Property && currentFlyerType != FlyerType.Property? Iconz.BxPropertiesOff :

    flyerTypeFilter == FlyerType.Design && currentFlyerType == FlyerType.Design? Iconz.BxDesignsOn :
    flyerTypeFilter == FlyerType.Design && currentFlyerType != FlyerType.Design? Iconz.BxDesignsOff :

    flyerTypeFilter == FlyerType.Project && currentFlyerType == FlyerType.Project? Iconz.BxProjectsOn :
    flyerTypeFilter == FlyerType.Project && currentFlyerType != FlyerType.Project? Iconz.BxProjectsOff :

    flyerTypeFilter == FlyerType.Product && currentFlyerType == FlyerType.Product? Iconz.BxProductsOn :
    flyerTypeFilter == FlyerType.Product && currentFlyerType != FlyerType.Product? Iconz.BxProductsOff :

    flyerTypeFilter == FlyerType.Craft && currentFlyerType == FlyerType.Craft? Iconz.BxCraftsOn :
    flyerTypeFilter == FlyerType.Craft && currentFlyerType != FlyerType.Craft? Iconz.BxCraftsOff :

    flyerTypeFilter == FlyerType.Equipment && currentFlyerType == FlyerType.Equipment? Iconz.BxEquipmentOn :
    flyerTypeFilter == FlyerType.Equipment && currentFlyerType != FlyerType.Equipment? Iconz.BxEquipmentOff :
        Iconz.Gallery;

    String buttonVerse =
    flyerTypeFilter == FlyerType.Property ?   'Properties' :
    flyerTypeFilter == FlyerType.Design ?     'Designs' :
    flyerTypeFilter == FlyerType.Project ?    'Projects' :
    flyerTypeFilter == FlyerType.Product ?    'Products' :
    flyerTypeFilter == FlyerType.Craft ?      'Crafts' :
    flyerTypeFilter == FlyerType.Equipment ?  'Equipment' : 'All Flyers' ;


    return DreamBox(
      height: 40,
      // width: 40,
      boxMargins: EdgeInsets.all(2.5),
      icon: icon,
      verse: buttonVerse,
      verseColor: flyerTypeFilter == currentFlyerType ? Colorz.BlackBlack : Colorz.White,
      verseScaleFactor: 0.8,
      iconSizeFactor: 0.8,
      color: flyerTypeFilter == currentFlyerType ? Colorz.Yellow : Colorz.Nothing,
      boxFunction: () => tapButton(flyerTypeFilter),
    );
  }
}
