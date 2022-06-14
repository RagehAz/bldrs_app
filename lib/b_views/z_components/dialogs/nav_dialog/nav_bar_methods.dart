import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

enum BarType {
  min,
  max,
  minWithText,
  maxWithText,
}

class NavBar {
  /// --------------------------------------------------------------------------
  const NavBar();
  // -----------------------------------------------------------------------------
  /// --- MAIN CONTROLS
  static const double circleWidth = Ratioz.appBarButtonSize;
  static const double navbarPaddings = Ratioz.appBarPadding * 1.5;
  static const double navBarButtonWidth = circleWidth + (navbarPaddings * 0.5 * 2) + (navbarPaddings * 0.5 * 2);
  static const double _textScaleFactor = 0.95;
  static const int _textSize = 0;
  static const double buttonCircleCorner = circleWidth * 0.5;
  static const double _boxCorner = buttonCircleCorner + navbarPaddings;
  static const BarType barType = BarType.minWithText;
// -----------------------------------------------------------------------------
  static double navBarHeight({
    @required BuildContext context,
    @required BarType barType,
  }) {
    final double _textBoxHeight = navBarTextBoxHeight(context: context, barType: barType);

    final double _boxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
    circleWidth + (navbarPaddings * 2) + _textBoxHeight
        :
    circleWidth + (navbarPaddings * 2);

    return _boxHeight;
  }
// -----------------------------------------------------------------------------
  static double navBarWidth({
    @required BuildContext context,
    @required UserModel userModel,
    @required BarType barType,
  }) {

    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons: _numberOfButtons,
        numberOfSpacings: _numberOfSpacings,
        spacingFactor: _spacingFactor
    );

    final double _boxWidth = barType == BarType.maxWithText || barType == BarType.max ?
    Scale.superScreenWidth(context)
        :
    (navBarButtonWidth * _numberOfButtons) + (_spacings * _numberOfSpacings);

    return _boxWidth;
  }
// -----------------------------------------------------------------------------
  static double navBarTextBoxHeight({
    @required BuildContext context,
    @required BarType barType,
  }) {

    final double _textBoxHeight = barType == BarType.maxWithText || barType == BarType.minWithText ?
    SuperVerse.superVerseRealHeight(
      context: context,
      size: _textSize,
      sizeFactor: _textScaleFactor,
      hasLabelBox: false,
    )
        :
    0;

    return _textBoxHeight;
  }
// -----------------------------------------------------------------------------
  static int navBarNumberOfButtons(UserModel userModel) {
    int _numberOfButtons;

    if (AuthModel.userIsSignedIn() == false) {
      _numberOfButtons = 2;
    } else if (UserModel.checkUserIsAuthor(userModel)) {
      _numberOfButtons = 4;
    } else {
      _numberOfButtons = 3;
    }

    return _numberOfButtons;
  }
// -----------------------------------------------------------------------------
  static double navBarButtonsSpacing({
    @required BuildContext context,
    @required int numberOfButtons,
    @required int numberOfSpacings,
    @required double spacingFactor,
    BarType barType = barType,
  }) {

    final double _spacings =
    barType == BarType.max || barType == BarType.maxWithText ?
    (
        (
            Scale.superScreenWidth(context)
                -
                (navBarButtonWidth * numberOfButtons)
        )
            /
            numberOfSpacings
    ) * spacingFactor
        :
    navbarPaddings * 0;

    return _spacings;
  }
// -----------------------------------------------------------------------------
  static double navBarSpacerWidth(BuildContext context, UserModel userModel) {
    final int _numberOfButtons = navBarNumberOfButtons(userModel);
    final int _numberOfSpacings = _numberOfButtons - 1;
    const double _spacingFactor = 0.5;
    final double _spacings = navBarButtonsSpacing(
        context: context,
        numberOfButtons: _numberOfButtons,
        numberOfSpacings: _numberOfSpacings,
        spacingFactor: _spacingFactor);

    final double _halfSpacer = _spacings * 0.5;

    return _halfSpacer;
  }
// -----------------------------------------------------------------------------
  static BorderRadius navBarCorners({
    @required BuildContext context,
    @required BarType barType,
  }) {
    final BorderRadius _boxBorders = barType == BarType.min ?
    Borderers.superBorderOnly(
        context: context,
        enTopLeft: _boxCorner,
        enBottomLeft: _boxCorner,
        enBottomRight: _boxCorner,
        enTopRight: _boxCorner
    )
        :
    barType == BarType.max || barType == BarType.maxWithText ?

    Borderers.superBorderOnly(
        context: context,
        enTopLeft: _boxCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: _boxCorner)
        :
    Borderers.superBorderOnly(
        context: context,
        enTopLeft: _boxCorner,
        enBottomLeft: _boxCorner * 0.5,
        enBottomRight: _boxCorner * 0.5,
        enTopRight: _boxCorner
    );

    return _boxBorders;
  }
// -----------------------------------------------------------------------------
  static double navBarBottomOffset({
    @required BarType barType,
  }) {

    final double _bottomOffset = barType == BarType.min || barType == BarType.minWithText ?
    navbarPaddings
        :
    barType == BarType.max || barType == BarType.maxWithText ? 0 : 0;

    return _bottomOffset;
  }
// -----------------------------------------------------------------------------
}
