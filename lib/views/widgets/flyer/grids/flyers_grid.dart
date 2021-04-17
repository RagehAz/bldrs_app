import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersGrid extends StatefulWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  // final List<CoFlyer> flyersData;

  FlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    // @required this.flyersData,
});

  @override
  _FlyersGridState createState() => _FlyersGridState();
}

class _FlyersGridState extends State<FlyersGrid> {
  List<TinyFlyer> _savedFlyers;
  bool _isInit = true;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void initState() {
    // final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    // savedFlyers = await pro.getSavedFlyers;
    super.initState();
  }
// ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading();
      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      setState(() {
        _savedFlyers = _prof.getSavedTinyFlyers;
      });

      // _prof.fetchAndSetSavedFlyers(context)
      //     .then((_) async {
      //
      //   _savedFlyers = _prof.getSavedTinyFlyers;
      //
      //   rebuildGrid();
      //
      // });

        _triggerLoading();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// ---------------------------------------------------------------------------
  void rebuildGrid(){setState(() {});}
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final user = Provider.of<UserModel>(context);
    // List<dynamic> savedFlyersIDs = [ 'f037'];
    // final List<BzModel> bzz = pro.getBzzOfFlyersList(savedFlyers);
// ----------------------------------------------------------------------------
      // int flyerIndex = 0;
// ----------------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
// ----------------------------------------------------------------------------
    int gridColumnsCount = widget.numberOfColumns;
    double spacingRatioToGridWidth = 0.15;
    double gridFlyerWidth = widget.gridZoneWidth / (widget.numberOfColumns + (widget.numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    int flyersCount = _savedFlyers == null ? 0 : _savedFlyers.length;
    int numOfGridRows(int flyersCount){
      return
        (flyersCount/gridColumnsCount).ceil();
    }
    int _numOfRows = numOfGridRows(flyersCount);
    // double gridBottomSpacing = gridZoneWidth * 0.15;
    double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
        // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;
    // double flyerMainMargins = screenWidth - gridZoneWidth;
// ----------------------------------------------------------------------------
    double _flyerSizeFactor = (((widget.gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth;


    return
      Container(
          width: widget.gridZoneWidth,
          height: gridHeight,
          child:

          _savedFlyers == null ?

          Center(child: Loading(loading: true,)) :

          GridView(
            physics: NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            padding: EdgeInsets.all(gridSpacing),
            // key: new Key(loadedFlyers[flyerIndex].f01flyerID),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: gridFlyerWidth,
            ),
              children: <Widget>[

                if(_savedFlyers !=null)
                ...List<Widget>.generate(
                    _savedFlyers.length,
                        (index){
                      return

                               // ChangeNotifierProvider.value(
              //   value: savedFlyers[index],
              //     child: ChangeNotifierProvider.value(
              //       value: bzz[index],
              //       child: Flyer(
              //         flyerSizeFactor: (((widget.gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth,
              //         slidingIsOn: false,
              //         rebuildFlyerGrid: rebuildGrid,
              //         tappingFlyerZone: (){
              //           Nav.openFlyer(context, savedFlyers[index].flyerID);
              //         },
              //         flyerIsInGalleryNow: true,
              //       ),
              //     ),
              //   );

                        TinyFlyerWidget(
                          tinyFlyer: _savedFlyers[index],
                          flyerSizeFactor: _flyerSizeFactor,
                          onTap: (tinyFlyer) => Nav().openFlyer(context, _savedFlyers[index].flyerID),
                        );

                    }),

              ]

            // savedFlyers.map(
            //       (coFlyer, i) => ChangeNotifierProvider.value(
            //         value: savedFlyers[coFlyerIndex],
            //         child: ProFlyer(
            //           flyerSizeFactor: _flyerSizeFactor,
            //           slidingIsOn: false,
            //           // flyerID: coFlyer.flyer.flyerID,
            //         ),
            //       ),
            //   ).toList(),

          ),

    );
  }
}
