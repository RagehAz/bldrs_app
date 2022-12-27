
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class InfoPageSeparator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfoPageSeparator({
    @required this.pageWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: pageWidth * 0.8,
      height: 0.2,
      color: Colorz.white200,
      margin: const EdgeInsets.symmetric(vertical: 10),
    );
  }
/// --------------------------------------------------------------------------
}
