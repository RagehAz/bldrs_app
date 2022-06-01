import 'dart:async';

import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/note_attachment.dart';
import 'package:bldrs/b_views/z_components/notes/note_card_buttons.dart';
import 'package:bldrs/b_views/z_components/notes/note_sender_balloon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/notes_controllers/notes_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
    return Bubble.clearWidth(context) - NoteSenderBalloon.balloonWidth - (Ratioz.appBarMargin);
  }
// -----------------------------------------------------------------------------
  static const double bannerCorners = Bubble.cornersValue - Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  void _onBubbleTap() {
    blog('_onBubbleTap : noti id is : ${noteModel.id} : ${noteModel.sentTime} : dif : ${Timers.getTimeDifferenceInSeconds(from: noteModel.sentTime, to: DateTime.now())}');
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    final double _bodyWidth = bodyWidth(context);
    const double _moreButtonSize = 35;
    final bool _noteHasButtons = Mapper.canLoopList(noteModel.buttons);

    unawaited(markNoteAsSeen(
      context: context,
      noteModel: noteModel,
    ));

    return Bubble(
      centered: true,
      margins: const EdgeInsets.symmetric(
          horizontal: Ratioz.appBarMargin,
          vertical: Ratioz.appBarPadding,
      ),
      onBubbleTap: _noteHasButtons ? null : _onBubbleTap,
      bubbleColor: noteModel.seen == true ? Colorz.white10 : Colorz.yellow10,
      columnChildren: <Widget>[

        /// SENDER BALLOON - TITLE - TIMESTAMP - BODY
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            NoteSenderBalloon(
              noteModel: noteModel,
            ),

            /// SPACER
            const SizedBox(
              width: Ratioz.appBarMargin,
              height: Ratioz.appBarMargin,
            ),

            /// NOTIFICATION CONTENT
            SizedBox(
              width: _bodyWidth - _moreButtonSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// TITLE
                  SuperVerse(
                    verse: noteModel?.title,
                    maxLines: 5,
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
                    maxLines: 20,
                    centered: false,
                  ),

                ],
              ),
            ),

            /// MORE BUTTON
            DreamBox(
              height: _moreButtonSize,
              width: _moreButtonSize,
              icon: Iconz.more,
              iconSizeFactor: 0.7,
              onTap: () => onShowNoteOptions(
                context: context,
                noteModel: noteModel,
              ),
            ),

          ],
        ),

        /// SPACER
        const SizedBox(
          width: Ratioz.appBarPadding,
          height: Ratioz.appBarPadding,
        ),

        /// ATTACHMENT
        NoteAttachment(
          noteModel: noteModel,
          boxWidth: _bodyWidth,
        ),

        /// BUTTONS
        if (Mapper.canLoopList(noteModel.buttons) == true)
          NoteCardButtons(
            boxWidth: _bodyWidth,
            noteModel: noteModel,
          ),

      ],
    );
  }
}
