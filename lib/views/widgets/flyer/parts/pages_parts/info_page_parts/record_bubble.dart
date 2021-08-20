import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/PersonButton.dart';
import 'package:flutter/material.dart';

class RecordBubble extends StatelessWidget {
  final double flyerZoneWidth;
  final String bubbleTitle;
  final String bubbleIcon;
  final List<TinyUser> users;

  const RecordBubble({
    @required this.flyerZoneWidth,
    @required this.bubbleTitle,
    @required this.bubbleIcon,
    @required this.users,
  });

  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = flyerZoneWidth - (Ratioz.appBarPadding * 2);
    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    BorderRadius _bubbleCorners = Borderers.superBorderAll(context, flyerZoneWidth * Ratioz.xxflyerTopCorners);
    double _peopleBubbleBoxHeight = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.2;


    return InPyramidsBubble(
      bubbleWidth: _bubbleWidth,
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
