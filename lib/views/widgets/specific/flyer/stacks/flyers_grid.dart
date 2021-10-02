import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class FlyersGrid extends StatefulWidget {

  final double gridZoneWidth;
  final int numberOfColumns;
  final List<TinyFlyer> tinyFlyers;
  final bool scrollable;
  final bool stratosphere;
  final Axis scrollDirection;
  final Function tinyFlyerOnTap;

  const FlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.tinyFlyers,
    this.scrollable = false,
    this.stratosphere = false,
    this.scrollDirection = Axis.vertical,
    this.tinyFlyerOnTap,
});

  @override
  _FlyersGridState createState() => _FlyersGridState();
}

class _FlyersGridState extends State<FlyersGrid> {
  List<TinyFlyer> _tinyFlyers;
  // bool _isInit = true;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    final FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: false);
    // savedFlyers = await pro.getSavedFlyers;
    _tinyFlyers = widget.tinyFlyers == null ? _prof.getSavedTinyFlyers : widget.tinyFlyers;
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
    final int flyersCount = _tinyFlyers == null ? 0 : _tinyFlyers.length;
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

          _tinyFlyers == null?
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
              itemCount: _tinyFlyers.length,
              itemBuilder: (ctx, index){

              print('FlyersGrid : flyerID : ${_tinyFlyers[index].flyerID} : midColor : ${_tinyFlyers[index].midColor}');

              return

                FinalFlyer(
                  flyerBoxWidth: FlyerBox.width(context, _flyerSizeFactor),
                  tinyFlyer: _tinyFlyers[index],
                  initialSlideIndex: _tinyFlyers[index].slideIndex,
                  goesToEditor: false,
                );

              },

          ),

    );
  }
}