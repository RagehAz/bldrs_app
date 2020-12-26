import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'dream_box.dart';

class AddBzBt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: DreamBox(
        height: 40,
        verse: 'Open a business account',
        verseColor: Colorz.White,
        boxMargins: EdgeInsets.all(10),
        color: Colorz.Nothing,
        icon: Iconz.Bz,
        iconSizeFactor: 0.55,
        boxFunction: () {
          Navigator.pushNamed(context, Routez.AddBz);
        },
      ),
    );
  }
}
