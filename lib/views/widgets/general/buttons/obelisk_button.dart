import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/buttons/main_button.dart';
import 'package:flutter/material.dart';

class ObeliskButton extends StatelessWidget {

  final String title;
  final String icon;
  final Widget screen;
  final Color color;

  const ObeliskButton(
      this.title,
      this.icon,
      this.screen,
      {
        this.color = Colorz.black125,
        Key key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Color _color = color == null ? Colorz.black125 : color;

    return MainButton(
      buttonVerse: title,
      buttonColor: _color,
      buttonIcon: icon,
      buttonVerseShadow: true,
      splashColor: Colorz.yellow255,
      function: () => Nav.goToNewScreen(context, screen),
      stretched: false,
    );

  }
}
