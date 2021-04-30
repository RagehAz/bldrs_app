import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class ChangeLanguageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      pageTitle: 'Change current zone',
      appBarBackButton: true,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeight(context),
        child: ListView(
          children: <Widget>[

            Stratosphere(),

            DreamBox(
              width: Scale.superScreenWidth(context),
              height: 50,
              verse: 'Test',
              boxMargins: Ratioz.ddAppBarMargin,
              color: Colorz.Yellow,
              verseColor: Colorz.BlackBlack,
              verseMaxLines: 2,
              boxFunction: (){print('testing this');},
            ),

          ],
        ),
      ),
    );
  }
}
