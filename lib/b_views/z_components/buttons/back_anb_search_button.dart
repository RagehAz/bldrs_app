import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/x_screens/c_search/c_0_search_screen.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final Color color;
  final BackAndSearchAction backAndSearchAction;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final String _icon =
    backAndSearchAction == BackAndSearchAction.goBack ? Iconizer.superBackIcon(context)
        :
    backAndSearchAction == BackAndSearchAction.goToSearchScreen ? Iconz.search
        :
    backAndSearchAction == BackAndSearchAction.showHistory ? Iconz.clock
        :
    null;
// -----------------------------------------------------------------------------
    final double _iconSizeFactor = backAndSearchAction == BackAndSearchAction.goBack ? 1
        :
    backAndSearchAction == BackAndSearchAction.goToSearchScreen ? 0.5
        :
    backAndSearchAction == BackAndSearchAction.showHistory ? 0.5
        :
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

          if (onTap != null) {
            onTap();
          }

          else {

            if (backAndSearchAction == BackAndSearchAction.goBack) {
              Nav.goBack(context);
              final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
              _uiProvider.triggerLoading(
                setLoadingTo: false,
                callerName: 'BackAndSearchButton',
                notify: true,
              );
              // _uiProvider.triggerIsSearching(setIsSearchingTo: false);
              minimizeKeyboardOnTapOutSide(context);

            }

            else if (backAndSearchAction == BackAndSearchAction.goToSearchScreen) {
              await Nav.goToNewScreen(
                  context: context,
                  screen: const SearchScreen(),
              );
            }

            else {
              blog('nothing to do');
            }
          }
        });
  }
}
