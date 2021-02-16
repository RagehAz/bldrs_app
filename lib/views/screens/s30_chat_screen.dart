import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.Basic,
      pageTitle: 'Chat Screen',
      pyramids: Iconz.PyramidsCrystal,
      sky: Sky.Night,
      appBarRowWidgets: <Widget>[BldrsBackButton(),],
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SuperVerse(
            verse: 'Chat Screen',
          ),

        ],
      ),
    );
  }
}
