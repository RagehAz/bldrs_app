import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';

class BldrsFloatingList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsFloatingList({
    @required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FloatingList(
      columnChildren: columnChildren,
      padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      // height: ,
      // width: ,
      // scrollDirection: ,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
