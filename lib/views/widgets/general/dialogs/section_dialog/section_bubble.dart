import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/chain_expander/components/expanding_tile.dart';
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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bubble(
      title: title,
      // actionBtIcon: Iconz.BxPropertiesOn,
      leadingAndActionButtonsSizeFactor: 1,
      actionBtFunction: (){},
      width: bubbleWidth,
      // leadingIcon: icon,
      leadingIconColor: Colorz.white50,
      margins: const EdgeInsets.only(left: Ratioz.appBarMargin, right: Ratioz.appBarMargin, top: Ratioz.appBarMargin),
      titleColor: Colorz.white50,
      corners: ExpandingTile.cornersValue + Ratioz.appBarMargin,
      columnChildren: <Widget>[

        /// Section buttons
        SizedBox(
          width: bubbleWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buttons,
          ),
        ),

      ],
    );
  }
}
