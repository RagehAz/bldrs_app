import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/bz_box.dart';
import 'package:flutter/material.dart';

class BzStaticGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzStaticGrid({
    @required this.gridBoxWidth,
    @required this.bzzModels,
    this.numberOfColumns = 3,
    this.itemOnTap,
    this.scrollable = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double gridBoxWidth;
  final int numberOfColumns;
  final List<BzModel> bzzModels;
  final ValueChanged<BzModel> itemOnTap;
  final bool scrollable;
  /// --------------------------------------------------------------------------
  /*
  static const List<Color> _boxesColors = <Color>[
    Colorz.white30,
    Colorz.white20,
    Colorz.white10
  ];
   */
// -----------------------------------------------------------------------------
  static const double _spacingRatioToGridWidth = 0.1;
// -----------------------------------------------------------------------------
  static double concludeLogoBoxWidth({
    @required double gridBoxWidth,
    @required int numberOfColumns
  }){

    /// MY LOVELY EQUATION
    final double _logoWidth = gridBoxWidth /
        (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    return _logoWidth;
  }
// -----------------------------------------------------------------------------
  static double gridSpacings({
    @required double logoWidth,
  }){
    return logoWidth * _spacingRatioToGridWidth;
  }
// -----------------------------------------------------------------------------
  /// TOTAL GRID BOX HEIGHT
  static double concludeGridBoxHeight({
    @required double gridSpacing,
    @required int numberOfRow,
    @required double logoBoxHeight, /// includes logo height + bz name box height
}){

    final double _gridZoneHeight =
        gridSpacing + (numberOfRow * (logoBoxHeight + gridSpacing));

    /// old lovely equation
    // totalHeight = logoBoxHeight * (numberOfRows + (spacingRatio * numberOfRows) + spacingRatio)

    return _gridZoneHeight;
  }
// -----------------------------------------------------------------------------
  static int concludeNumberOfRows({
    // @required int definedNumberOfRows,
    // @required bool scrollable,
    @required int numberOfBzz,
    @required int numberOfColumns,
}){

    // int _numberOfRows = definedNumberOfRows;

    final int _numberOfRows = (numberOfBzz / numberOfColumns).ceil();

    return _numberOfRows;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
// -------------------------------------------------------
    final List<BzModel> _bzz = bzzModels ?? <BzModel>[];
// -------------------------------------------------------
    final double _logoWidth = concludeLogoBoxWidth(
        gridBoxWidth: gridBoxWidth,
        numberOfColumns: numberOfColumns
    );
// -------------------------------------------------------
    final double _gridSpacing = gridSpacings(logoWidth: _logoWidth);
// -------------------------------------------------------
    final double _logoBoxHeight = BzLogoBox.boxHeight(
        width: _logoWidth,
        showName: true
    );
// -------------------------------------------------------
    /*
    final int _numberOfRows = concludeNumberOfRows(
      numberOfBzz: _bzz.length,
      numberOfColumns: numberOfColumns,
    );
     */
// -------------------------------------------------------
    final SliverGridDelegate _gridDelegate =
    SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisSpacing: _gridSpacing,
      crossAxisSpacing: _gridSpacing,
      mainAxisExtent: _logoBoxHeight,
      crossAxisCount: numberOfColumns,
      childAspectRatio: 1/1.25,
    );
// -------------------------------------------------------
    final EdgeInsets _gridPadding = EdgeInsets.only(
      top: _gridSpacing,
      left: _gridSpacing,
      right: _gridSpacing,
      bottom: _gridSpacing,
    );
// -------------------------------------------------------

    return
      GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: _gridPadding,
          gridDelegate: _gridDelegate,
          shrinkWrap: true,
          itemCount: _bzz.length,
          itemBuilder: (BuildContext ctx, int index){

            final BzModel _bzModel = _bzz[index];

            return BzLogoBox(
              width: _logoWidth,
              bzModel: _bzModel,
              onTap: () => itemOnTap(_bzModel),
            );

          },
        );
  }
}
