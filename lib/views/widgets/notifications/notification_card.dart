import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/notifications/notification_balloon.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotiModel notiModel;

  NotificationCard({
    @required this.notiModel,
});

  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = Bubble.defaultWidth(context);
    double _balloonWidth = NotificationSenderBalloon.balloonWidth();
    double _padding = Ratioz.appBarMargin;
    double _bodyWidth = _bubbleWidth - _balloonWidth - (_padding * 3);

    bool designMode = false;

    return Bubble(
          centered: true,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin, vertical: Ratioz.appBarPadding),
          columnChildren: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

               NotificationSenderBalloon(
                 sender: notiModel.sender,
                 pic: notiModel.senderPicURL,
               ),

                SizedBox(
                  width: Ratioz.appBarMargin,
                  height: Ratioz.appBarMargin,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    SuperVerse(
                      verse: notiModel.title,
                      size: 2,
                      designMode: designMode,
                    ),

                    SuperVerse(
                      verse: '${Timers.stringOnDateMonthYear(context: context, time: notiModel.timeStamp)}', /// task : fix timestamp parsing
                      color: Colorz.Grey225,
                      italic: true,
                      weight: VerseWeight.thin,
                      size: 1,
                      designMode: designMode,
                    ),

                    Container(
                      width: _bodyWidth,
                      child: SuperVerse(
                        verse: notiModel.body,
                        weight: VerseWeight.thin,
                        size: 2,
                        maxLines: 10,
                        designMode: designMode,
                        centered: false,
                      ),
                    ),

                  ],
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),


          ],
        );
  }
}
