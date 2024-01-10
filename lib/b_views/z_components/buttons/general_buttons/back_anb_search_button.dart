import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

enum BackAndSearchAction {
  goToSearchScreen,
  goBack,
  showHistory,
}

class BackAndSearchButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BackAndSearchButton({
    required this.backAndSearchAction,
    this.onTap,
    this.color = Colorz.white10,
    this.icon,
    this.iconSizeFactor,
    this.loading = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  final BackAndSearchAction backAndSearchAction;
  final String? icon;
  final double? iconSizeFactor;
  final bool loading;
  /// --------------------------------------------------------------------------
  String? _getIcon(BuildContext context){

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
        loading: loading,
        width: Ratioz.appBarButtonSize,
        corners: Ratioz.appBarButtonCorner,
        // margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        icon: icon ?? _getIcon(context),
        iconSizeFactor: iconSizeFactor ?? getIconSizeFactor(),
        bubble: false,
        color: color,
        // textDirection: superInverseTextDirection(context),
        onTap: () async {

          if (onTap != null) {
            onTap?.call();
          }

          else {

            if (backAndSearchAction == BackAndSearchAction.goBack) {

              await Keyboard.closeKeyboard();

              await Nav.goBack(
                context: context,
                invoker: 'BackAndSearchButton',
              );

            }

            else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen) {

              await BldrsNav.pushSearchRoute();

              // await Nav.goToNewScreen(
              //   context: context,
              //   screen: const SuperSearchScreen(),
              //   pageTransitionType: Nav.superHorizontalTransition(
              //     appIsLTR: UiProvider.checkAppIsLeftToRight(),
              //     // inverse: false,
              //   ),
              // );

            }

            else {
              blog('nothing to do');
            }
          }

        }
        );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
