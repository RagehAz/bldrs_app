import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notifications/notification_balloon.dart';
import 'package:bldrs/b_views/z_components/notifications/notification_flyers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/notifications/notification_model/noti_model.dart';
import 'package:bldrs/f_helpers/notifications/notifications_manager/noti_banner_editor.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotificationCard({
    @required this.notiModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NotiModel notiModel;
  /// --------------------------------------------------------------------------
  static double bubbleWidth(BuildContext context) {
    return Bubble.defaultWidth(context);
  }
// -----------------------------------------------------------------------------
  static double bodyWidth(BuildContext context) {
    return Bubble.defaultWidth(context) -
        NotificationSenderBalloon.balloonWidth -
        (Ratioz.appBarMargin * 4);
  }
// -----------------------------------------------------------------------------
  static const double bannerCorners = Bubble.cornersValue - Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  void _onBubbleTap() {
    blog('_onBubbleTap : noti id is : ${notiModel.id} : ${notiModel.timeStamp} : dif : ${Timers.getTimeDifferenceInSeconds(from: notiModel.timeStamp, to: DateTime.now())}');
  }
// -----------------------------------------------------------------------------
  void _onButtonTap(String value) {
    /// TASK : notification buttons accept reject need better logic handling for translation
    bool _accepted;

    if (value == 'Accept') {
      _accepted = true;
    }

    else {
      _accepted = false;
    }

    blog('_onButtonTap : _accepted : $_accepted');
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bodyWidth = bodyWidth(context);
    final bool _notiHasButtons = notiModel?.attachmentType == NotiAttachmentType.buttons;

    return Bubble(
      centered: true,
      // width: _bodyWidth,
      margins: const EdgeInsets.symmetric(
          horizontal: Ratioz.appBarMargin,
          vertical: Ratioz.appBarPadding,
      ),
      onBubbleTap: _notiHasButtons ? null : _onBubbleTap,
      columnChildren: <Widget>[

        Row(
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
            SizedBox(
              width: _bodyWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// TITLE
                  SuperVerse(
                    verse: notiModel?.title,
                    maxLines: 3,
                    centered: false,
                  ),

                  /// TIME STAMP
                  SuperVerse(
                    verse: Timers.getSuperTimeDifferenceString(
                        from: notiModel.timeStamp, to: DateTime.now()),
                    color: Colorz.grey255,
                    italic: true,
                    weight: VerseWeight.thin,
                    size: 1,
                    maxLines: 2,
                    centered: false,
                  ),

                  /// BODY
                  SuperVerse(
                    verse: notiModel.body,
                    weight: VerseWeight.thin,
                    maxLines: 10,
                    centered: false,
                  ),

                  /// SPACER
                  const SizedBox(
                    width: Ratioz.appBarPadding,
                    height: Ratioz.appBarPadding,
                  ),

                  /// WELCOME BANNER
                  if (notiModel.attachmentType == NotiAttachmentType.banner)
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

                  if (notiModel.attachmentType == NotiAttachmentType.flyers)
                    NotificationFlyers(
                      bodyWidth: _bodyWidth,
                      flyers: notiModel.attachment,
                    ),

                  /// BUTTONS
                  if (notiModel.attachmentType == NotiAttachmentType.buttons &&
                      notiModel.attachment is List<String>)
                    SizedBox(
                      width: _bodyWidth,
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          ...List<Widget>.generate(notiModel.attachment.length,
                              (int index) {

                            final double _width = (_bodyWidth -
                                    ((notiModel.attachment.length + 1) *
                                        Ratioz.appBarMargin)) /
                                (notiModel.attachment.length);

                            return DreamBox(
                              width: _width,
                              height: 60,
                              verse: notiModel.attachment[index],
                              verseScaleFactor: 0.7,
                              color: Colorz.blue80,
                              splashColor: Colorz.yellow255,
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
