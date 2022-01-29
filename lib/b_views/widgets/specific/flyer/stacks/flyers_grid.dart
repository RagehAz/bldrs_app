import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class OldFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldFlyersGrid({
    @required this.gridZoneWidth,
    this.numberOfColumns = 3,
    this.flyers,
    this.scrollable = false,
    this.topPadding = Ratioz.stratosphere,
    this.scrollDirection = Axis.vertical,
    this.onFlyerTap,
    this.scrollController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double gridZoneWidth;
  final int numberOfColumns;
  final List<FlyerModel> flyers;
  final bool scrollable;
  final double topPadding;
  final Axis scrollDirection;
  final ValueChanged<FlyerModel> onFlyerTap;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  bool _canTapFlyerCheck(){
    bool _canTap;

    if (onFlyerTap == null){
      _canTap = true;
    }
    else {
      _canTap = false;
    }

    return _canTap;
  }
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
    final int gridColumnsCount = numberOfColumns;
    const double spacingRatioToGridWidth = 0.03;
    final double gridFlyerWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    final double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
    final double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
    final int flyersCount = flyers == null ? 0 : flyers.length;
    int numOfGridRows(int flyersCount) {
      return (flyersCount / gridColumnsCount).ceil();
    }

    final int _numOfRows = numOfGridRows(flyersCount);
    // double gridBottomSpacing = gridZoneWidth * 0.15;
    final double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
    // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;
    // double flyerMainMargins = screenWidth - gridZoneWidth;
// -----------------------------------------------------------------------------
    final double _flyerSizeFactor = ((gridZoneWidth - (gridSpacing * (gridColumnsCount + 1))) / gridColumnsCount) / screenWidth;
// -----------------------------------------------------------------------------
    final EdgeInsets _gridPadding =
    // topMargin == true ?
    EdgeInsets.only(
        right: gridSpacing,
        left: gridSpacing,
        bottom: gridSpacing + Ratioz.horizon,
        top: gridSpacing + topPadding,
    )
    //     :
    // EdgeInsets.all(gridSpacing)
    ;
// -----------------------------------------------------------------------------
    final bool _canTapFlyer =  _canTapFlyerCheck();

    return SizedBox(
      width: gridZoneWidth,
      height: gridHeight,
      child:

      flyers == null ?
      const Center(
          child: Loading(
            loading: true,
          )
      )

          :

      GridView.builder(
        physics: scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        scrollDirection: scrollDirection,
        padding: _gridPadding,
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: gridSpacing,
          mainAxisSpacing: gridSpacing,
          childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
          maxCrossAxisExtent: gridFlyerWidth,
        ),
        itemCount: flyers.length,
        itemBuilder: (BuildContext ctx, int index) {

          final FlyerModel _flyer = flyers[index];
          // blog('FlyersGrid : flyerID : ${flyers[index].id} : midColor : ${flyers[index].slides[0].midColor}');

          return GestureDetector(
            onTap: _canTapFlyer == true ? null : () => onFlyerTap(_flyer),
            child: AbsorbPointer(
              absorbing: !_canTapFlyer,
              child: FinalFlyer(
                flyerBoxWidth: OldFlyerBox.width(context, _flyerSizeFactor),
                flyerModel: flyers[index],
                onSwipeFlyer: (Sliders.SwipeDirection direction) {
                  // blog('Direction is ${direction}');
                },

              ),
            ),
          );
        },
      ),
    );
  }
}


// class FlyersGrid extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const FlyersGrid({
//     @required this.gridZoneWidth,
//     this.numberOfColumns = 3,
//     this.flyers,
//     this.scrollable = false,
//     this.stratosphere = false,
//     this.scrollDirection = Axis.vertical,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final double gridZoneWidth;
//   final int numberOfColumns;
//   final List<FlyerModel> flyers;
//   final bool scrollable;
//   final bool stratosphere;
//   final Axis scrollDirection;
//
//   /// --------------------------------------------------------------------------
//   @override
//   _FlyersGridState createState() => _FlyersGridState();
//
//   /// --------------------------------------------------------------------------
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(EnumProperty<Axis>('scrollDirection', scrollDirection));
//     properties.add(DiagnosticsProperty<bool>('scrollable', scrollable));
//     properties.add(DoubleProperty('gridZoneWidth', gridZoneWidth));
//     properties.add(IntProperty('numberOfColumns', numberOfColumns));
//     properties.add(IterableProperty<FlyerModel>('flyers', flyers));
//     properties.add(DiagnosticsProperty<bool>('stratosphere', stratosphere));
//   }
//
//   /// --------------------------------------------------------------------------
// }
//
// class _FlyersGridState extends State<FlyersGrid> {
//   List<FlyerModel> flyers;
//   // bool _isInit = true;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//     final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
//
//     // savedFlyers = await pro.getSavedFlyers;
//     flyers = widget.flyers ?? _flyersProvider.savedFlyers;
//   }
//
// // -----------------------------------------------------------------------------
// //   @override
// //   void didChangeDependencies() {
// //     if (_isInit && widget.tinyFlyers == null) {
// //       _triggerLoading();
// //       FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
// //
// //       setState(() {
// //         _tinyFlyers = _prof.getSavedTinyFlyers;
// //       });
// //
// //       // _prof.fetchAndSetSavedFlyers(context)
// //       //     .then((_) async {
// //       //
// //       //   _savedFlyers = _prof.getSavedTinyFlyers;
// //       //
// //       //   rebuildGrid();
// //       //
// //       // });
// //
// //         _triggerLoading();
// //     }
// //     _isInit = false;
// //     super.didChangeDependencies();
// //   }
// // -----------------------------------------------------------------------------
//   void rebuildGrid() {
//     setState(() {});
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // final user = Provider.of<UserModel>(context);
//     // List<dynamic> savedFlyersIDs = [ 'f037'];
//     // final List<BzModel> bzz = pro.getBzzOfFlyersList(savedFlyers);
// // -----------------------------------------------------------------------------
//     // int flyerIndex = 0;
// // -----------------------------------------------------------------------------
//     final double screenWidth = Scale.superScreenWidth(context);
// // -----------------------------------------------------------------------------
//     final int gridColumnsCount = widget.numberOfColumns;
//     const double spacingRatioToGridWidth = 0.03;
//     final double gridFlyerWidth = widget.gridZoneWidth / (widget.numberOfColumns + (widget.numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);
//     final double gridFlyerHeight = gridFlyerWidth * Ratioz.xxflyerZoneHeight;
//     final double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;
//     final int flyersCount = flyers == null ? 0 : flyers.length;
//     int numOfGridRows(int flyersCount) {
//       return (flyersCount / gridColumnsCount).ceil();
//     }
//
//     final int _numOfRows = numOfGridRows(flyersCount);
//     // double gridBottomSpacing = gridZoneWidth * 0.15;
//     final double gridHeight = gridFlyerHeight * (_numOfRows + (_numOfRows * spacingRatioToGridWidth) + spacingRatioToGridWidth);
//     // (numOfGridRows(flyersCount) * (gridFlyerHeight + gridSpacing)) + gridSpacing + gridBottomSpacing;
//     // double flyerMainMargins = screenWidth - gridZoneWidth;
// // -----------------------------------------------------------------------------
//     final double _flyerSizeFactor = ((widget.gridZoneWidth - (gridSpacing * (gridColumnsCount + 1))) / gridColumnsCount) / screenWidth;
// // -----------------------------------------------------------------------------
//     final EdgeInsets _gridPadding = widget.stratosphere == true ?
//     EdgeInsets.only(
//         right: gridSpacing,
//         left: gridSpacing,
//         bottom: gridSpacing + Ratioz.horizon * 5,
//         top: gridSpacing + Ratioz.stratosphere)
//         :
//     EdgeInsets.all(gridSpacing);
// // -----------------------------------------------------------------------------
//     return SizedBox(
//       width: widget.gridZoneWidth,
//       height: gridHeight,
//       child: flyers == null
//           ?
//       const Center(
//           child: Loading(
//             loading: true,
//           ))
//
//           :
//
//       GridView.builder(
//         physics: widget.scrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
//         scrollDirection: widget.scrollDirection,
//         padding: _gridPadding,
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           crossAxisSpacing: gridSpacing,
//           mainAxisSpacing: gridSpacing,
//           childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
//           maxCrossAxisExtent: gridFlyerWidth,
//         ),
//         itemCount: flyers.length,
//         itemBuilder: (BuildContext ctx, int index) {
//           blog(
//               'FlyersGrid : flyerID : ${flyers[index].id} : midColor : ${flyers[index].slides[0].midColor}');
//
//           return GestureDetector(
//             onTap: () => onFlyerTap(),
//             child: AbsorbPointer(
//               // absorbing: true,
//               child: FinalFlyer(
//                 flyerBoxWidth: FlyerBox.width(context, _flyerSizeFactor),
//                 flyerModel: flyers[index],
//                 onSwipeFlyer: (Sliders.SwipeDirection direction) {
//                   // blog('Direction is ${direction}');
//                 },
//
//               ),
//             ),
//           );
//           },
//       ),
//     );
//   }
//
//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(IterableProperty<FlyerModel>('flyers', flyers));
//   }
// }
