import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notifications/notification_balloon.dart';
import 'package:bldrs/b_views/z_components/notifications/notification_flyers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/f_helpers/notifications/notifications_manager/noti_banner_editor.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteCard({
    @required this.noteModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
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
    blog('_onBubbleTap : noti id is : ${noteModel.id} : ${noteModel.sentTime} : dif : ${Timers.getTimeDifferenceInSeconds(from: noteModel.sentTime, to: DateTime.now())}');
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
    final bool _noteHasButtons = noteModel?.attachmentType == NoteAttachmentType.buttons;

    return Bubble(
      centered: true,
      // width: _bodyWidth,
      margins: const EdgeInsets.symmetric(
          horizontal: Ratioz.appBarMargin,
          vertical: Ratioz.appBarPadding,
      ),
      onBubbleTap: _noteHasButtons ? null : _onBubbleTap,
      columnChildren: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // /// SENDER BALLOON
            // NotificationSenderBalloon(
            //   sender: noteModel?.notiPicType,
            //   pic: notiModel?.pic,
            // ),

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
                    verse: noteModel?.title,
                    maxLines: 3,
                    centered: false,
                  ),

                  /// TIME STAMP
                  SuperVerse(
                    verse: Timers.getSuperTimeDifferenceString(
                        from: noteModel.sentTime,
                        to: DateTime.now(),
                    ),
                    color: Colorz.grey255,
                    italic: true,
                    weight: VerseWeight.thin,
                    size: 1,
                    maxLines: 2,
                    centered: false,
                  ),

                  /// BODY
                  SuperVerse(
                    verse: noteModel.body,
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
                  if (noteModel.attachmentType == NoteAttachmentType.banner)
                    NotiBannerEditor(
                      width: _bodyWidth,
                      height: 300,
                      attachment: noteModel.attachment,
                      onDelete: null,
                    ),

                  // BldrsWelcomeBanner(
                  //   width: _bodyWidth,
                  //   corners: _bannerCorner,
                  // ),

                  if (noteModel.attachmentType == NoteAttachmentType.flyers)
                    NotificationFlyers(
                      bodyWidth: _bodyWidth,
                      flyers: noteModel.attachment,
                    ),

                  /// BUTTONS
                  if (noteModel.attachmentType == NoteAttachmentType.buttons &&
                      noteModel.attachment is List<String>)
                    Container(
                      width: _bodyWidth,
                      height: 70,
                      color: Colorz.bloodTest,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          ...List<Widget>.generate(noteModel.attachment.length,
                              (int index) {

                            final double _width = Scale.getUniformRowItemWidth(
                              context: context,
                              numberOfItems: noteModel.attachment.length,
                              boxWidth: _bodyWidth,
                            );

                            return DreamBox(
                              width: _width,
                              height: 60,
                              verse: noteModel.attachment[index],
                              verseScaleFactor: 0.7,
                              color: Colorz.blue80,
                              splashColor: Colorz.yellow255,
                              onTap: () => _onButtonTap(noteModel.attachment[index]),
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
