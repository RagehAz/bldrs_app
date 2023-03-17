import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class ObeliskButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskButton(
    this.title,
    this.icon,
    this.screen, {
    this.color = Colorz.black125,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String title;
  final String icon;
  final Widget screen;
  final Color color;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final Color _color = color ?? Colorz.black125;

    return MainButton(
      verse: Verse.plain(title),
      buttonColor: _color,
      icon: icon,
      onTap: () => Nav.goToNewScreen(
          context: context,
          screen: screen,
      ),
    );
  }
}
