import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/nav_bar/nav_bar.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Scale{
// -----------------------------------------------------------------------------
  static double superScreenWidth (BuildContext context){
    final double _screenWidth = MediaQuery.of(context).size.width;
    return _screenWidth;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeight (BuildContext context){
    final double _screenHeight = MediaQuery.of(context).size.height;
    return _screenHeight;
  }
// -----------------------------------------------------------------------------
  static double superSafeAreaTopPadding (BuildContext context){
    final double _safeAreaHeight = MediaQuery.of(context).padding.top;
    return _safeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superScreenHeightWithoutSafeArea (BuildContext context){
    final double _screenWithoutSafeAreaHeight = superScreenHeight(context) - superSafeAreaTopPadding(context);
    return _screenWithoutSafeAreaHeight;
  }
// -----------------------------------------------------------------------------
  static double superDeviceRatio(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _deviceRatio = _size.aspectRatio;
    return _deviceRatio;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets superInsets(BuildContext context,{double enBottom, double enLeft, double enRight, double enTop}){

    final double _enBottom = enBottom ?? 0;
    final double _enLeft = enLeft ?? 0;
    final double _enRight = enRight ?? 0;
    final double _enTop = enTop ?? 0;

    return
      appIsLeftToRight(context) ?
      EdgeInsets.only(bottom: _enBottom, left: _enLeft, right: _enRight, top: _enTop)
          :
      EdgeInsets.only(bottom: _enBottom, left: _enRight, right: _enLeft, top: _enTop);
  }
// -----------------------------------------------------------------------------
  static EdgeInsets superMargins({dynamic margins}){
    final EdgeInsets _boxMargins =
    margins == null || margins == 0 ? const EdgeInsets.all(0)
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
// ----------------------------------------------------------------------------
  /// NAV BAR
  static const double _circleWidth = Ratioz.appBarButtonSize;
  static const double navbarPaddings = Ratioz.appBarPadding * 1.5;
  static const double _textScaleFactor = 0.95;
  static const int _textSize = 0;
  static const double navBarButtonWidth =_circleWidth + (navbarPaddings * 0.5 * 2) + (navbarPaddings * 0.5 * 2);
  static const double buttonCircleCorner = _circleWidth * 0.5;
  static const double _boxCorner = buttonCircleCorner + navbarPaddings;
// -----------------------------------------------------------------------------
  static double navBarWidth({BuildContext context, UserModel userModel, BarType barType}){
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons : _numberOfButtons,
        numberOfSpacings : _numberOfSpacings,
        spacingFactor : _spacingFactor
    );

    final double _boxWidth =
    barType == BarType.maxWithText || barType == BarType.max ?
    Scale.superScreenWidth(context)
        :
    ( navBarButtonWidth * _numberOfButtons ) + (_spacings * _numberOfSpacings) ;

    return _boxWidth;
  }
// -----------------------------------------------------------------------------
  static double navBarHeight({BuildContext context, BarType barType,}){

    final double _textBoxHeight = navBarTextBoxHeight(context: context, barType: barType);

    final double _boxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    _circleWidth + ( navbarPaddings * 2) + (_textBoxHeight)
        :
    _circleWidth + ( navbarPaddings * 2);

    return _boxHeight;
}
// -----------------------------------------------------------------------------
  static double navBarTextBoxHeight({BuildContext context, BarType barType, }){
    final double _textBoxHeight =
    barType == BarType.maxWithText || barType == BarType.minWithText ?
    SuperVerse.superVerseRealHeight(context, _textSize, _textScaleFactor, null) : 0;

    return _textBoxHeight;
}
// -----------------------------------------------------------------------------
  static int navBarNumberOfButtons(UserModel userModel) {
    final int _numberOfButtons = UserModel.userIsAuthor(userModel) ? 5 : 4;
    return _numberOfButtons;
  }
// -----------------------------------------------------------------------------
    static double navBarButtonsSpacing({
      BuildContext context,
      int numberOfButtons,
      int numberOfSpacings,
      double spacingFactor,
      BarType barType,
    }){

      final double _spacings =
      barType == BarType.max || barType == BarType.maxWithText ?
      ((Scale.superScreenWidth(context) - (navBarButtonWidth * numberOfButtons) ) / numberOfSpacings) * spacingFactor
          :
      navbarPaddings * 0
      ;
      return _spacings;

    }
// -----------------------------------------------------------------------------
  static double navBarSpacerWidth(BuildContext context, UserModel userModel){
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context :  context,
        numberOfButtons :  _numberOfButtons,
        numberOfSpacings :  _numberOfSpacings,
        spacingFactor :  _spacingFactor
    );

    final double _halfSpacer = _spacings * 0.5;

    return _halfSpacer;
  }
// -----------------------------------------------------------------------------
  static BorderRadius navBarCorners({BuildContext context, BarType barType,}){
    final BorderRadius _boxBorders =
    barType == BarType.min ?
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: _boxCorner, enBottomRight: _boxCorner, enTopRight: _boxCorner)
        :
    barType == BarType.max  || barType == BarType.maxWithText?
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: 0, enBottomRight: 0, enTopRight: _boxCorner)
        :
    Borderers.superBorderOnly(context: context, enTopLeft: _boxCorner, enBottomLeft: _boxCorner * 0.5, enBottomRight: _boxCorner * 0.5, enTopRight: _boxCorner)
    ;

    return _boxBorders;

  }
// -----------------------------------------------------------------------------
  static double navBarBottomOffset({BarType barType}){
    final double _bottomOffset =
    barType == BarType.min || barType == BarType.minWithText ? navbarPaddings :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;
    return _bottomOffset;
  }
// -----------------------------------------------------------------------------
  /// this concludes item width after dividing screen width over number of items
  /// while considering 10 pixels spacing between them
  static double getUniformRowItemWidth(BuildContext context, int numberOfItems){
    final double _screenWidth = superScreenWidth(context);
    final double _width = (_screenWidth - (Ratioz.appBarMargin * (numberOfItems + 1))) / numberOfItems;
    return _width;
  }
// -----------------------------------------------------------------------------
}