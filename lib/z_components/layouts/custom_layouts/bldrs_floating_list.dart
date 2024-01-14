import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:flutter/material.dart';

class BldrsFloatingList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsFloatingList({
    required this.columnChildren,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.hasMargins = true,
    this.boxAlignment,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool hasMargins;
  final Alignment? boxAlignment;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FloatingList(
      columnChildren: columnChildren,
      padding: hasMargins == true ?
      const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon)
          :
      EdgeInsets.zero
      ,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      boxAlignment: boxAlignment,
      // height: ,
      // width: ,
      // scrollDirection: ,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
