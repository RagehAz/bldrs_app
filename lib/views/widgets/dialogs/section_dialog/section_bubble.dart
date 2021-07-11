import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:flutter/material.dart';

class SectionBubble extends StatelessWidget {
  final String title;
  final double bubbleWidth;
  final String icon;
  final List<Widget> buttons;

  SectionBubble({
    @required this.title,
    @required this.bubbleWidth,
    @required this.icon,
    @required this.buttons,
});

  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
      centered: false,
      title: title,
      // actionBtIcon: Iconz.BxPropertiesOn,
      actionBtSizeFactor: 1,
      actionBtFunction: (){},
      bubbleColor: Colorz.White20,
      bubbleOnTap: null,
      bubbleWidth: bubbleWidth,
      leadingIcon: icon,
      leadingIconColor: Colorz.White50,
      titleColor: Colorz.White50,
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
