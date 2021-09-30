import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/PersonButton.dart';
import 'package:flutter/material.dart';

class RecordBubble extends StatelessWidget {
  final double flyerBoxWidth;
  final String bubbleTitle;
  final String bubbleIcon;
  final List<TinyUser> users;
  final Key key;

  const RecordBubble({
    @required this.flyerBoxWidth,
    @required this.bubbleTitle,
    @required this.bubbleIcon,
    @required this.users,
    this.key,
  });

  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = flyerBoxWidth - (Ratioz.appBarPadding * 2);
    const EdgeInsets _bubbleMargins = const EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    final BorderRadius _bubbleCorners = Borderers.superBorderAll(context, flyerBoxWidth * Ratioz.xxflyerTopCorners);
    final double _peopleBubbleBoxHeight = flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 1.2;

    return Bubble(
      key: key,
      width: _bubbleWidth,
      margins: _bubbleMargins,
      corners: _bubbleCorners,
      title: bubbleTitle,
      leadingIcon: bubbleIcon,
      LeadingAndActionButtonsSizeFactor: 1,
      columnChildren: <Widget>[

        /// PEOPLE BOX
        Container(
            width: _bubbleWidth,
            height: _peopleBubbleBoxHeight,
            // color: Colorz.Yellow80,
            alignment: Alignment.center,
            child:
            ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (ctx, index){
                  return
                    PersonButton(
                      totalHeight: _peopleBubbleBoxHeight,
                      image: users[index].pic,
                      id: users[index].userID,
                      name: users[index].name,
                      onTap: (userID){
                        print('id is : $userID');
                      },
                    );
                }
            )
        ),


      ],
    );
  }
}
