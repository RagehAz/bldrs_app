import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:filers/filers.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

enum BackAndSearchAction {
  goToSearchScreen,
  goBack,
  showHistory,
}

class BackAndSearchButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BackAndSearchButton({
    @required this.backAndSearchAction,
    this.onTap,
    this.color = Colorz.white10,
    this.icon,
    this.iconSizeFactor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final Color color;
  final BackAndSearchAction backAndSearchAction;
  final String icon;
  final double iconSizeFactor;
  /// --------------------------------------------------------------------------
  String _getIcon(BuildContext context){

    if (backAndSearchAction == BackAndSearchAction.goBack){
      return Iconizer.superBackIcon(context);
    }
    else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen){
      return Iconz.search;
    }
    else if (backAndSearchAction == BackAndSearchAction.showHistory){
      return Iconz.clock;
    }
    else {
      return null;
    }

  }
  // --------------------
  double getIconSizeFactor(){

    if (backAndSearchAction == BackAndSearchAction.goBack){
      return 1;
    }

    else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen){
      return 0.5;
    }
    else if (backAndSearchAction == BackAndSearchAction.showHistory){
      return 0.5;
    }
    else {
      return 1;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
        height: Ratioz.appBarButtonSize,
        width: Ratioz.appBarButtonSize,
        corners: Ratioz.appBarButtonCorner,
        // margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        icon: icon ?? _getIcon(context),
        iconRounded: false,
        iconSizeFactor: iconSizeFactor ?? getIconSizeFactor(),
        bubble: false,
        color: color,
        // textDirection: superInverseTextDirection(context),
        onTap: () async {

          if (onTap != null) {
            onTap();
          }

          else {

            if (backAndSearchAction == BackAndSearchAction.goBack) {

              Keyboard.closeKeyboard();

              await Nav.goBack(
                context: context,
                invoker: 'BackAndSearchButton',
              );

            }

            else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen) {
              await Nav.goToNewScreen(
                context: context,
                screen: const SuperSearchScreen(),
                pageTransitionType: Nav.superHorizontalTransition(
                  context: context,
                  // inverse: false,
                ),
              );
            }

            else {
              blog('nothing to do');
            }
          }
        });
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
