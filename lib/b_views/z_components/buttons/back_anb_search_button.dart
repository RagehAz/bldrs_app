import 'package:bldrs/b_views/c_main_search/a_main_search_screen/a_main_search_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return DreamBox(
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

              await Nav.goBack(
                context: context,
                invoker: 'BackAndSearchButton',
              );

              final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
              _uiProvider.triggerLoading(
                setLoadingTo: false,
                callerName: 'BackAndSearchButton',
                notify: true,
              );
              // _uiProvider.triggerIsSearching(setIsSearchingTo: false);
              Keyboard.closeKeyboard(context);

            }

            else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen) {
              await Nav.goToNewScreen(
                context: context,
                screen: const MainSearchScreen(),
                transitionType: Nav.superHorizontalTransition(context, inverse: true),
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
