import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class FlyersGrid extends StatefulWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<FlyerModel> flyers;
  final bool scrollable;
  final bool stratosphere;
  final Axis scrollDirection;
  final Function tinyFlyerOnTap;

  const FlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.flyers,
    this.scrollable = false,
    this.stratosphere = false,
    this.scrollDirection = Axis.vertical,
    this.tinyFlyerOnTap,
    Key key,
}) : super(key: key);

  @override
  _FlyersGridState createState() => _FlyersGridState();
}

class _FlyersGridState extends State<FlyersGrid> {
  List<FlyerModel> flyers;
  // bool _isInit = true;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    // savedFlyers = await pro.getSavedFlyers;
    flyers = widget.flyers == null ? _flyersProvider.savedFlyers : widget.flyers;
  }
// -----------------------------------------------------------------------------
//   @override
//   void didChangeDependencies() {
//     if (_isInit && widget.tinyFlyers == null) {
//       _triggerLoading();
//       FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
//
//       setState(() {
//         _tinyFlyers = _prof.getSavedTinyFlyers;
//       });
//
//       // _prof.fetchAndSetSavedFlyers(context)
//       //     .then((_) async {
//       //
//       //   _savedFlyers = _prof.getSavedTinyFlyers;
//       //
//       //   rebuildGrid();
//       //
//       // });
//
//         _triggerLoading();
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
// -----------------------------------------------------------------------------
  void rebuildGrid(){setState(() {});}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final user = Provider.of<UserModel>(context);
    // List<dynamic> savedFlyersIDs = [ 'f037'];
    // final List<BzModel> bzz = pro.getBzzOfFlyersList(savedFlyers);
// -----------------------------------------------------------------------------
      // int flyerIndex = 0;
// -----------------------------------------------------------------------------
    final double screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    final int gridColumnsCount = widget.numberOfColumns;
    const double spacingRatioToGridWidth = 0.15;
    final double gridFlyerWidth = widget.gridZoneWidth / (widget.numberOfColumns + (widget.numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    final double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    final double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    final int flyersCount = flyers == null ? 0 : flyers.length;
    int numOfGridRows(int flyersCount){
      return
        (flyersCount/gridColumnsCount).ceil();
    }
    final int _numOfRows = numOfGridRows(flyersCount);
    // double gridBottomSpacing = gridZoneWidth * 0.15;
    final double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
        // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;
    // double flyerMainMargins = screenWidth - gridZoneWidth;
// -----------------------------------------------------------------------------
    final double _flyerSizeFactor = (((widget.gridZoneWidth - (gridSpacing*(gridColumnsCount+1)))/gridColumnsCount))/screenWidth;
// -----------------------------------------------------------------------------
    final EdgeInsets _gridPadding = widget.stratosphere == true ?
    EdgeInsets.only(right: gridSpacing, left: gridSpacing, bottom: gridSpacing + Ratioz.horizon * 5, top: gridSpacing + Ratioz.stratosphere)
        :
    EdgeInsets.all(gridSpacing);
// -----------------------------------------------------------------------------
    return
      Container(
          width: widget.gridZoneWidth,
          height: gridHeight,
          child:

          flyers == null?
          const Center(child: Loading(loading: true,)) :

          GridView.builder(
            physics: widget.scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            addAutomaticKeepAlives: true,
            scrollDirection: widget.scrollDirection,
            padding: _gridPadding,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: gridFlyerWidth,
            ),
              itemCount: flyers.length,
              itemBuilder: (BuildContext ctx, int index){

              print('FlyersGrid : flyerID : ${flyers[index].id} : midColor : ${flyers[index].slides[0].midColor}');

              return

                FinalFlyer(
                  flyerBoxWidth: FlyerBox.width(context, _flyerSizeFactor),
                  flyerModel: flyers[index],
                  initialSlideIndex: 0,
                  goesToEditor: false,
                  onSwipeFlyer: (SwipeDirection direction){
                    // print('Direction is ${direction}');
                  },
                );

              },

          ),

    );
  }
}
