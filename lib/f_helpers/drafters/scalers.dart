import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
double superScreenWidth(BuildContext context) {
  final double _screenWidth = MediaQuery.of(context).size.width;
  return _screenWidth;
}
// -----------------------------------------------------------------------------
double superScreenHeight(BuildContext context) {
  final double _screenHeight = MediaQuery.of(context).size.height;
  return _screenHeight;
}
// -----------------------------------------------------------------------------
double superSafeAreaTopPadding(BuildContext context) {
  final double _safeAreaHeight = MediaQuery.of(context).padding.top;
  return _safeAreaHeight;
}
// -----------------------------------------------------------------------------
double superScreenHeightWithoutSafeArea(BuildContext context) {

  final double _screenWithoutSafeAreaHeight =
      superScreenHeight(context)
          -
          superSafeAreaTopPadding(context);


  return _screenWithoutSafeAreaHeight;
}
// -----------------------------------------------------------------------------
double superDeviceRatio(BuildContext context) {
  final Size _size = MediaQuery.of(context).size;
  final double _deviceRatio = _size.aspectRatio;
  return _deviceRatio;
}
// -----------------------------------------------------------------------------
EdgeInsets superInsets({
  @required BuildContext context,
  double enBottom = 0,
  double enLeft = 0,
  double enRight = 0,
  double enTop = 0,
}) {

  return appIsLeftToRight(context) ?
  EdgeInsets.only(
      bottom: enBottom,
      left: enLeft,
      right: enRight,
      top: enTop
  )
      :
  EdgeInsets.only(
      bottom: enBottom,
      left: enRight,
      right: enLeft,
      top: enTop
  );
}
// -----------------------------------------------------------------------------
EdgeInsets superMargins({dynamic margins}) {
  final EdgeInsets _boxMargins = margins == null || margins == 0 ? EdgeInsets.zero
      :
  margins.runtimeType == double ? EdgeInsets.all(margins)
      :
  margins.runtimeType == int ? EdgeInsets.all(margins.toDouble())
      :
  margins.runtimeType == EdgeInsets ? margins
      :
  margins;

  return _boxMargins;
}
// -----------------------------------------------------------------------------
/// this concludes item width after dividing screen width over number of items
/// while considering 10 pixels spacing between them
double getUniformRowItemWidth(BuildContext context, int numberOfItems) {
  final double _screenWidth = superScreenWidth(context);
  final double _width = (_screenWidth - (Ratioz.appBarMargin * (numberOfItems + 1))) / numberOfItems;
  return _width;
}
// -----------------------------------------------------------------------------
EdgeInsets superPadding({
  BuildContext context,
  double enLeft,
  double enRight,
  double top,
  double bottom
}) {
  return appIsLeftToRight(context) ? EdgeInsets.only(left: enLeft, right: enRight, top: top, bottom: bottom)
      :
  EdgeInsets.only(left: enRight, right: enLeft, top: top, bottom: bottom);
}
// -----------------------------------------------------------------------------
double clearLayoutHeight({
  @required BuildContext context,
  AppBarType appBarType = AppBarType.basic,
}){

  final double _screenHeight = superScreenHeightWithoutSafeArea(context);
  final double _appBarHeight = BldrsAppBar.height(context, appBarType);

  return _screenHeight - _appBarHeight;

}
