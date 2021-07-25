import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersGridView extends StatefulWidget {

  @override
  _FlyersGridViewState createState() => _FlyersGridViewState();
}

class _FlyersGridViewState extends State<FlyersGridView> {
  // ScrollController _controller;
  var _showAnkhsOnly = false;
  FlyerType currentFlyerType = FlyerType.Non;

  // List<FlyerType> flyerFilers = [
  //   FlyerType.General,
  //   FlyerType.Property,
  //   FlyerType.Design,
  //   FlyerType.Project,
  //   FlyerType.Product,
  //   FlyerType.Craft,
  //   FlyerType.Equipment,
  // ];


  @override
  Widget build(BuildContext context) {
    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    // final List<FlyerModel> allFlyersOfType = pro.getFlyersByFlyerType(currentFlyerType);
    // final List<FlyerModel> savedFlyersFilter = [];//pro.getSavedFlyers;
    // final List<FlyerModel> _flyers = _showAnkhsOnly ? savedFlyersFilter : allFlyersOfType;
    // final List<BzModel> bzz = pro.getBzzOfFlyersList(flyers);

    final List<TinyFlyer> _tinyFlyers = pro.getAllTinyFlyers;
    // final flyers = _showAnkhsOnly ? flyersData.savedFlyers : flyersData.allFlyers;

    // List<FlyerModel> propertyFlyers       = flyersData.getFlyersByFlyerType(FlyerType.Property);
    // // List<CoFlyer> savedPropertyFlyers  = flyersData.findSavedFlyers(propertyFlyers);
    //
    // List<FlyerModel> designFlyers         = flyersData.getFlyersByFlyerType(FlyerType.Design);
    // // List<CoFlyer> savedDesignFlyers    = flyersData.findSavedFlyers(designFlyers);
    //
    // List<FlyerModel> productFlyers        = flyersData.getFlyersByFlyerType(FlyerType.Product);
    // // List<CoFlyer> savedProductFlyers   = flyersData.findSavedFlyers(productFlyers);
    //
    // List<FlyerModel> projectFlyers        = flyersData.getFlyersByFlyerType(FlyerType.Project);
    // // List<CoFlyer> savedProjectFlyers   = flyersData.findSavedFlyers(projectFlyers);
    //
    // List<FlyerModel> craftFlyers          = flyersData.getFlyersByFlyerType(FlyerType.Craft);
    // // List<CoFlyer> savedCraftFlyers     = flyersData.findSavedFlyers(craftFlyers);
    //
    // List<FlyerModel> equipmentFlyers      = flyersData.getFlyersByFlyerType(FlyerType.Equipment);
    // // List<CoFlyer> savedEquipmentFlyers = flyersData.findSavedFlyers(equipmentFlyers);

    //     final flyers =
    // currentFlyerType == FlyerType.Property &&  !_showAnkhsOnly? propertyFlyers :
    // // currentFlyerType == FlyerType.Property &&  _showAnkhsOnly? savedPropertyFlyers :
    //
    // currentFlyerType == FlyerType.Design &&  !_showAnkhsOnly? designFlyers :
    // // currentFlyerType == FlyerType.Design &&  _showAnkhsOnly? savedDesignFlyers :
    //
    // currentFlyerType == FlyerType.Project &&  !_showAnkhsOnly? projectFlyers :
    // // currentFlyerType == FlyerType.Project &&  _showAnkhsOnly? savedProjectFlyers :
    //
    // currentFlyerType == FlyerType.Product &&  !_showAnkhsOnly? productFlyers :
    // // currentFlyerType == FlyerType.Product &&  _showAnkhsOnly? savedProductFlyers :
    //
    // currentFlyerType == FlyerType.Craft &&  !_showAnkhsOnly? craftFlyers :
    // // currentFlyerType == FlyerType.Craft &&  _showAnkhsOnly? savedCraftFlyers :
    //
    // currentFlyerType == FlyerType.Equipment &&  !_showAnkhsOnly? equipmentFlyers :
    // // currentFlyerType == FlyerType.Equipment &&  _showAnkhsOnly? savedEquipmentFlyers :

    // _showAnkhsOnly ? flyersData.savedFlyers :
    // flyersData.getAllFlyers ;

      // int flyerIndex = 0;
// -------------------------------------------------------------------------
    double screenWidth = MediaQuery.of(context).size.width;

    int gridColumnsCount = currentFlyerType == FlyerType.Property ? 4 : 2;
    int numberOfColumns = gridColumnsCount;
    double gridZoneWidth = screenWidth;
    // double flyerHeight = (gridZoneWidth * Ratioz.xxflyerZoneHeight);

    const double spacingRatioToGridWidth = 0.15;
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

    double _flyerSizeFactor = (((gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth;

    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      appBarType: AppBarType.Scrollable,
      appBarRowWidgets: <Widget>[

        DreamBox(
          height: 40,
          width: 40,
          margins: const EdgeInsets.all(5),
          icon: Iconz.SavedFlyers,
          iconSizeFactor: 0.8,
          color: _showAnkhsOnly == true ? Colorz.Yellow255 : Colorz.Nothing,
          onTap: (){
            setState(() {
              _showAnkhsOnly = !_showAnkhsOnly;
            });
          },
        ),

        ...List<Widget>.generate(
            FlyerTypeClass.flyerTypesList.length,
                (i) => FilterButton(
              flyerTypeFilter: FlyerTypeClass.flyerTypesList[i],
              currentFlyerType : currentFlyerType,
              tapButton: (FlyerType selectedFlyerType){setState(() {
                currentFlyerType = selectedFlyerType;
                _showAnkhsOnly = false;
              });},
            )),

      ],
      layoutWidget: GridView.builder(
        // physics: NeverScrollableScrollPhysics(),
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.only(right: gridSpacing, left: gridSpacing, top: ( (10) + Ratioz.stratosphere), bottom: gridSpacing * 5 ),
        // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: gridSpacing,
          mainAxisSpacing: gridSpacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
          maxCrossAxisExtent: gridFlyerWidth,//gridFlyerWidth,
        ),
        itemCount: _tinyFlyers.length,
        itemBuilder: (ctx, i) =>
            // ChangeNotifierProvider.value(
            //     value: flyers[i],
            //     // or we can use other syntax like :-
            //     // ChangeNotifierProvider(//     create: (c) => flyers[i],
            //     child: ChangeNotifierProvider.value(
            //       value: bzz[i],
            //       child: Padding(
            //         key: Key(flyers[i].flyerID),
            //         padding: const EdgeInsets.only(bottom: 0),
            //         child: Flyer(
            //           // flyerID: flyers[i].flyer.flyerID,
            //           flyerSizeFactor: flyerSizeFactor,
            //           initialSlide: 0,
            //           slidingIsOn: true,
            //           tappingFlyerZone: (){
            //             Nav.openFlyer(context, flyers[i].flyerID);
            //           },
            //         ),
            //       ),
            //     )
            // ),
///
//         flyerModelBuilder(
//             context: context,
//             tinyFlyer: _tinyFlyers[i],
//             flyerSizeFactor: _flyerSizeFactor,
//             builder: (ctx, flyerModel){
//               return NormalFlyerWidget(
//                 flyer: flyerModel,
//                 flyerSizeFactor: _flyerSizeFactor,
//               );
//             }
//         ),
///

        FinalFlyer(
          flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
          tinyFlyer: _tinyFlyers[i],
        )

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
    //
    // flyerTypeFilter == FlyerType.Design && currentFlyerType == FlyerType.Design? Iconz.BxDesignsOn :
    // flyerTypeFilter == FlyerType.Design && currentFlyerType != FlyerType.Design? Iconz.BxDesignsOff :

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
      margins: EdgeInsets.all(2.5),
      icon: icon,
      verse: buttonVerse,
      verseColor: flyerTypeFilter == currentFlyerType ? Colorz.Black230 : Colorz.White255,
      verseScaleFactor: 0.8,
      iconSizeFactor: 0.8,
      color: flyerTypeFilter == currentFlyerType ? Colorz.Yellow255 : Colorz.Nothing,
      onTap: () => tapButton(flyerTypeFilter),
    );
  }
}
