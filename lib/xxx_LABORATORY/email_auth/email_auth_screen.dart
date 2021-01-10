import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/xxx_LABORATORY/xxx_obelisk/x20_ad_bz.dart';
import 'package:flutter/material.dart';

class EmailAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidsYellow,
      layoutWidget: Container(
        width: superScreenWidth(context),
        height: superScreenHeight(context),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stratosphere(),

            TextFieldBubble(
              title: 'E-mail Address',
              hintText: '...',
              counterIsOn: false,
              maxLength: 50,
              maxLines: 1,
              keyboardTextInputType: TextInputType.emailAddress,
              // textController: aboutTextController,
              // textOnChanged: (bzAbout) => typingBzAbout(bzAbout),
            ),

            TextFieldBubble(
              title: 'Password',
              hintText: '...',
              counterIsOn: false,
              obscured: true,
              maxLength: 50,
              maxLines: 1,
              keyboardTextInputType: TextInputType.visiblePassword,
              // textController: aboutTextController,
              // textOnChanged: (bzAbout) => typingBzAbout(bzAbout),
            ),


          ],
        ),
      ),
    );
  }
}
