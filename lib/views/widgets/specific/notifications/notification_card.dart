import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/notifications_manager/noti_banner_editor.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/notifications/notification_balloon.dart';
import 'package:bldrs/views/widgets/specific/notifications/notification_flyers.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final NotiModel notiModel;

  NotificationCard({
    @required this.notiModel,
});
// -----------------------------------------------------------------------------
  static double bubbleWidth(BuildContext context){
    return Bubble.defaultWidth(context);
  }
// -----------------------------------------------------------------------------
  static double bodyWidth(BuildContext context){
    return Bubble.defaultWidth(context) - NotificationSenderBalloon.balloonWidth - (Ratioz.appBarMargin * 3);
  }
// -----------------------------------------------------------------------------
  static const double bannerCorners = Bubble.cornersValue - Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  void _onBubbleTap(){

    print('_onBubbleTap : noti id is : ${notiModel.id} : ${notiModel.timeStamp} : dif : ${Timers.getTimeDifferenceInSeconds(from: notiModel.timeStamp, to: DateTime.now())}');


    }
// -----------------------------------------------------------------------------
  void _onButtonTap(String value){
    /// TASK : notification buttons accept reject need better logic handling for translation
    final bool _accepted = value == 'Accept' ? true : false;
    print('_onButtonTap : _accepted : $_accepted');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bodyWidth = bodyWidth(context);
    final bool _designMode = false;
    final bool _notiHasButtons = notiModel?.attachmentType == NotiAttachmentType.buttons;

    return Bubble(
          centered: true,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin, vertical: Ratioz.appBarPadding),
          bubbleOnTap: _notiHasButtons ? null : _onBubbleTap,
          columnChildren: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// SENDER BALLOON
                NotificationSenderBalloon(
                  sender: notiModel?.notiPicType,
                  pic: notiModel?.pic,
                ),

                /// SPACER
                const SizedBox(
                  width: Ratioz.appBarMargin,
                  height: Ratioz.appBarMargin,
                ),

                /// NOTIFICATION CONTENT
                Container(
                  width: _bodyWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// TITLE
                      SuperVerse(
                        verse: notiModel?.title,
                        size: 2,
                        designMode: _designMode,
                        maxLines: 3,
                        centered: false,
                      ),

                      /// TIME STAMP
                      SuperVerse(
                        verse: '${Timers.getSuperTimeDifferenceString(from: notiModel.timeStamp, to: DateTime.now())}',
                        color: Colorz.Grey225,
                        italic: true,
                        weight: VerseWeight.thin,
                        size: 1,
                        designMode: _designMode,
                        maxLines: 2,
                        centered: false,
                      ),

                      /// BODY
                      SuperVerse(
                        verse: notiModel.body,
                        weight: VerseWeight.thin,
                        size: 2,
                        maxLines: 10,
                        designMode: _designMode,
                        centered: false,
                      ),

                      /// SPACER
                      const SizedBox(
                        width: Ratioz.appBarPadding,
                        height: Ratioz.appBarPadding,
                      ),

                      /// WELCOME BANNER
                      if(notiModel.attachmentType == NotiAttachmentType.banner)
                        NotiBannerEditor(
                          width: _bodyWidth,
                          height: 300,
                          attachment: notiModel.attachment,
                          onDelete: null,
                        ),
                      // BldrsWelcomeBanner(
                      //   width: _bodyWidth,
                      //   corners: _bannerCorner,
                      // ),

                      if(notiModel.attachmentType == NotiAttachmentType.flyers)
                        NotificationFlyers(
                          bodyWidth: _bodyWidth,
                          flyers: notiModel.attachment,
                        ),

                      /// BUTTONS
                      if(notiModel.attachmentType == NotiAttachmentType.buttons && notiModel.attachment is List<String>)
                        Container(
                          width: _bodyWidth,
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              ...List.generate(notiModel.attachment.length,
                                      (index){

                                final double _width = (_bodyWidth - ((notiModel.attachment.length + 1) * Ratioz.appBarMargin) ) / (notiModel.attachment.length);

                                return
                                  DreamBox(
                                    width: _width,
                                    height: 60,
                                    verse: notiModel.attachment[index],
                                    verseScaleFactor: 0.7,
                                    color: Colorz.Blue80,
                                    splashColor: Colorz.Yellow255,
                                    onTap: () => _onButtonTap(notiModel.attachment[index]),
                                  );

                              }
                              ),

                            ],
                          ),
                        ),

                    ],
                  ),
                ),

              ],
            ),

          ],
        );
  }
}
