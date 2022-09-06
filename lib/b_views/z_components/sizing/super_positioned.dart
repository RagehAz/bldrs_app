import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:flutter/material.dart';

class SuperPositioned extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperPositioned({
    @required this.child,
    @required this.enAlignment,
    this.verticalOffset = 0,
    this.horizontalOffset = 0,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final Alignment enAlignment;
  final double verticalOffset;
  final double horizontalOffset;
  /// --------------------------------------------------------------------------
  static double _getLeft({
    @required Alignment enAlignment,
    @required double horizontalOffset,
  }){
    double _output;

    if (
    enAlignment == Alignment.topLeft
        ||
        enAlignment == Alignment.centerLeft
        ||
        enAlignment == Alignment.bottomLeft
    ){
      _output = horizontalOffset;
    }

    return  _output;
  }
  // --------------------
  static double _getRight({
    @required Alignment enAlignment,
    @required double horizontalOffset,
  }){
    double _output;

    if (
    enAlignment == Alignment.topRight
        ||
        enAlignment == Alignment.centerRight
        ||
        enAlignment == Alignment.bottomRight
    ){
      _output = horizontalOffset;
    }

    return  _output;
  }
  // --------------------
  static double _getTop({
    @required Alignment enAlignment,
    @required double verticalOffset,
  }){
    double _output;

    if (
    enAlignment == Alignment.topLeft
        ||
        enAlignment == Alignment.topCenter
        ||
        enAlignment == Alignment.topRight
    ){
      _output = verticalOffset;
    }

    return  _output;
  }
  // --------------------
  static double _getBottom({
    @required Alignment enAlignment,
    @required double verticalOffset,
  }){
    double _output;

    if (
    enAlignment == Alignment.bottomLeft
        ||
        enAlignment == Alignment.bottomCenter
        ||
        enAlignment == Alignment.bottomRight
    ){
      _output = verticalOffset;
    }

    return  _output;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isLTR = TextDir.appIsLeftToRight(context);

    /// LEFT TO RIGHT ( ENGLISH )
    if (_isLTR == true){

      return Positioned(
        left: _getLeft(enAlignment: enAlignment, horizontalOffset: horizontalOffset),
        right: _getRight(enAlignment: enAlignment, horizontalOffset: horizontalOffset),
        top: _getTop(enAlignment: enAlignment, verticalOffset: verticalOffset),
        bottom: _getBottom(enAlignment: enAlignment, verticalOffset: verticalOffset),
        child: child,
      );

    }

    /// RIGHT TO LEFT ( ARABIC )
    else {

      return Positioned(
        left: _getRight(enAlignment: enAlignment, horizontalOffset: horizontalOffset),
        right: _getLeft(enAlignment: enAlignment, horizontalOffset: horizontalOffset),
        top: _getTop(enAlignment: enAlignment, verticalOffset: verticalOffset),
        bottom: _getBottom(enAlignment: enAlignment, verticalOffset: verticalOffset),
        child: child,
      );

    }

  }
// -----------------------------------------------------------------------------
}
