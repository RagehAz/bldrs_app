import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:flutter/material.dart';

class SectionBubble extends StatelessWidget {
  final String title;
  final double bubbleWidth;
  final String icon;
  final List<Widget> buttons;

  const SectionBubble({
    @required this.title,
    @required this.bubbleWidth,
    @required this.icon,
    @required this.buttons,
});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      centered: false,
      title: title,
      // actionBtIcon: Iconz.BxPropertiesOn,
      LeadingAndActionButtonsSizeFactor: 1,
      actionBtFunction: (){},
      bubbleColor: Colorz.White20,
      bubbleOnTap: null,
      width: bubbleWidth,
      // leadingIcon: icon,
      leadingIconColor: Colorz.White50,
      margins: const EdgeInsets.only(bottom: 0, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin, top: Ratioz.appBarMargin),
      titleColor: Colorz.White50,
      corners: BottomDialog.dialogClearCornerValue() - Ratioz.appBarMargin,
      columnChildren: <Widget>[

        /// Section buttons
        Container(
          width: bubbleWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buttons,
          ),
        ),

      ],
    );
  }
}