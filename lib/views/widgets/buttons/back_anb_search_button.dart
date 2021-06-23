import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';
import 'package:bldrs/views/screens/s20_search_screen.dart';

enum BackAndSearchAction{
  GoToSearchScreen,
  GoBack,
  EnterSearch,
}

class BackAndSearchButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final BackAndSearchAction backAndSearchAction;

  BackAndSearchButton({
    this.onTap,
    this.color = Colorz.WhiteAir,
    @required this.backAndSearchAction,
});
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    String _icon =
    backAndSearchAction == BackAndSearchAction.GoBack ? Iconizer.superBackIcon(context) :
    backAndSearchAction == BackAndSearchAction.GoToSearchScreen ? Iconz.Search :
    backAndSearchAction == BackAndSearchAction.EnterSearch ? Iconz.Search :
    null;
// -----------------------------------------------------------------------------
    double _iconSizeFactor =
    backAndSearchAction == BackAndSearchAction.GoBack ? 1 :
    backAndSearchAction == BackAndSearchAction.GoToSearchScreen ? 0.5 :
    backAndSearchAction == BackAndSearchAction.EnterSearch ? 0.5 :
    1;
// -----------------------------------------------------------------------------
    return DreamBox(
      height: Ratioz.appBarButtonSize,
      width: Ratioz.appBarButtonSize,
      corners: Ratioz.appBarButtonCorner,
      boxMargins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      icon: _icon,
      iconRounded: false,
      iconSizeFactor: _iconSizeFactor,
      bubble: false,
      color: color,
      // textDirection: superInverseTextDirection(context),
      boxFunction: (){

        if (backAndSearchAction == BackAndSearchAction.GoBack){
          Nav.goBack(context);
        }

        else if(backAndSearchAction == BackAndSearchAction.GoToSearchScreen){
          Nav.goToNewScreen(context, SearchScreen());
        }

        else if(backAndSearchAction == BackAndSearchAction.EnterSearch){
          print('Entering search');
        }

        else {
          print('nothing to do');
        }
      }

    );

  }
}
