import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/screens/c_search/c_1_search_history_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/screens/c_search/c_0_search_screen.dart';

enum BackAndSearchAction{
  GoToSearchScreen,
  GoBack,
  ShowHistory,
}

class BackAndSearchButton extends StatelessWidget {
  final Function onTap;
  final Color color;
  final BackAndSearchAction backAndSearchAction;
  final Function passSearchHistory;

  const BackAndSearchButton({
    @required this.backAndSearchAction,
    this.onTap,
    this.color = Colorz.white10,
    this.passSearchHistory,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    final String _icon =
    backAndSearchAction == BackAndSearchAction.GoBack ? Iconizer.superBackIcon(context) :
    backAndSearchAction == BackAndSearchAction.GoToSearchScreen ? Iconz.Search :
    backAndSearchAction == BackAndSearchAction.ShowHistory ? Iconz.Clock :
    null;
// -----------------------------------------------------------------------------
    final double _iconSizeFactor =
    backAndSearchAction == BackAndSearchAction.GoBack ? 1 :
    backAndSearchAction == BackAndSearchAction.GoToSearchScreen ? 0.5 :
    backAndSearchAction == BackAndSearchAction.ShowHistory ? 0.5 :
    1;
// -----------------------------------------------------------------------------
    return DreamBox(
      height: Ratioz.appBarButtonSize,
      width: Ratioz.appBarButtonSize,
      corners: Ratioz.appBarButtonCorner,
      // margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      icon: _icon,
      iconRounded: false,
      iconSizeFactor: _iconSizeFactor,
      bubble: false,
      color: color,
      // textDirection: superInverseTextDirection(context),
      onTap: () async {

        if (onTap != null){
          onTap();
        }

        else {

          if (backAndSearchAction == BackAndSearchAction.GoBack){
            Nav.goBack(context);
          }

          else if(backAndSearchAction == BackAndSearchAction.GoToSearchScreen){
            Nav.goToNewScreen(context, const SearchScreen());
          }

          else if(backAndSearchAction == BackAndSearchAction.ShowHistory){
            final String _result = await Nav.goToNewScreen(context, const SearchHistoryScreen());
            print('received back this result : $_result');
            passSearchHistory(_result);
          }

          else {
            print('nothing to do');
          }

        }


      }

    );

  }
}
