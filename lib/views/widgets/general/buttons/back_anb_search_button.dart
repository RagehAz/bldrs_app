import 'package:bldrs/controllers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/screens/c_search/c_0_search_screen.dart';
import 'package:bldrs/views/screens/c_search/c_1_search_history_screen.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

enum BackAndSearchAction{
  goToSearchScreen,
  goBack,
  showHistory,
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
    backAndSearchAction == BackAndSearchAction.goBack ? Iconizer.superBackIcon(context) :
    backAndSearchAction == BackAndSearchAction.goToSearchScreen ? Iconz.search :
    backAndSearchAction == BackAndSearchAction.showHistory ? Iconz.clock :
    null;
// -----------------------------------------------------------------------------
    final double _iconSizeFactor =
    backAndSearchAction == BackAndSearchAction.goBack ? 1 :
    backAndSearchAction == BackAndSearchAction.goToSearchScreen ? 0.5 :
    backAndSearchAction == BackAndSearchAction.showHistory ? 0.5 :
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

          if (backAndSearchAction == BackAndSearchAction.goBack){
            Nav.goBack(context);
          }

          else if(backAndSearchAction == BackAndSearchAction.goToSearchScreen){
            Nav.goToNewScreen(context, const SearchScreen());
          }

          else if(backAndSearchAction == BackAndSearchAction.showHistory){
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
