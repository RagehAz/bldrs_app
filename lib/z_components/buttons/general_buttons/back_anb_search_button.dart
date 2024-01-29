import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class TheBackButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheBackButton({
    this.onTap,
    this.color = Colorz.white10,
    this.loading = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  final bool loading;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
        height: Ratioz.appBarButtonSize,
        loading: loading,
        width: Ratioz.appBarButtonSize,
        corners: Ratioz.appBarButtonCorner,
        icon: Iconizer.superBackIcon(context),
        iconSizeFactor: 0.8,
        bubble: false,
        color: color,
        onTap: () async {

          if (onTap != null) {
            onTap?.call();
          }

          else {

            await Keyboard.closeKeyboard();

            await Nav.goBack(
              context: context,
              invoker: 'BackAndSearchButton',
            );

          }

        }
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class TheSearchButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheSearchButton({
    this.onTap,
    this.color = Colorz.white10,
    this.loading = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  final bool loading;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
        height: Ratioz.appBarButtonSize,
        loading: loading,
        width: Ratioz.appBarButtonSize,
        corners: Ratioz.appBarButtonCorner,
        icon: Iconz.search,
        iconSizeFactor: 0.5,
        bubble: false,
        color: color,
        onTap: onTap,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class TheHistoryButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TheHistoryButton({
    this.onTap,
    this.color = Colorz.white10,
    this.loading = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final Function? onTap;
  final Color color;
  final bool loading;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
        height: Ratioz.appBarButtonSize,
        loading: loading,
        width: Ratioz.appBarButtonSize,
        corners: Ratioz.appBarButtonCorner,
        icon: Iconz.clock,
        iconSizeFactor: 0.5,
        bubble: false,
        color: color,
        onTap: onTap,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
