import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/buttons/note_card_buttons.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_sender_balloon.dart';
import 'package:bldrs/b_views/z_components/poster/note_poster_builder.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteCard({
    @required this.noteModel,
    @required this.isDraftNote,
    this.onNoteOptionsTap,
    this.onCardTap,
    this.bubbleWidth,
    this.bubbleColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  final bool isDraftNote;
  final Function onNoteOptionsTap;
  final Function onCardTap;
  final double bubbleWidth;
  final Color bubbleColor;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getBubbleWidth(BuildContext context) {
    return Bubble.bubbleWidth(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double bodyWidth({
    @required BuildContext context,
    @required double widthOverride
  }) {
    return Bubble.clearWidth(context, bubbleWidthOverride: widthOverride) - NoteSenderBalloon.balloonWidth - (Ratioz.appBarMargin);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSenderBalloonTap() async {

    /// BZ
    if (noteModel.parties.senderType == PartyType.bz){

      await Nav.jumpToBzPreviewScreen(
        bzID: noteModel.parties.senderID,
      );

    }

    /// USER
    else if (noteModel.parties.senderType == PartyType.user){

      await Nav.jumpToUserPreviewScreen(
        userID: noteModel.parties.senderID,
      );

    }

    /// BLDRS
    // else if (noteModel.parties.senderType == PartyType.bldrs){
      // await Nav.jumpToBldrsPreviewScreen(
      //     context: context,
      // );
    // }

    /// COUNTRY
    // else if (noteModel.parties.senderType == PartyType.country){
      // await Nav.jumpToCountryPreviewScreen(
      //     context: context,
      //     countryID: noteModel.parties.senderID,
      // );
    // }

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bodyWidth = bodyWidth(
      context: context,
      widthOverride: bubbleWidth,
    );
    const double _moreButtonSize = 35;
    final bool _noteHasButtons = Mapper.checkCanLoopList(noteModel?.poll?.buttons);
    // --------------------
    final double _bubbleWidth = bubbleWidth ?? getBubbleWidth(context);
    final double _clearWidth = Bubble.clearWidth(context, bubbleWidthOverride: _bubbleWidth);
    // --------------------
    return NoteRedDotWrapper(
      childWidth: _bubbleWidth,
      redDotIsOn: noteModel?.seen != true,
      shrinkChild: true,
      child: Bubble(
        bubbleHeaderVM: const BubbleHeaderVM(
          centered: true,
        ),
        width: _bubbleWidth,
        childrenCentered: true,
        margin: const EdgeInsets.only(
            // horizontal: Ratioz.appBarMargin,
            bottom: Ratioz.appBarMargin,
        ),
        onBubbleTap: _noteHasButtons ? null : onCardTap,
        bubbleColor: bubbleColor ?? (noteModel?.seen == true ? Colorz.white10 : Colorz.yellow50),
        columnChildren: <Widget>[

          /// SENDER BALLOON - TITLE - TIMESTAMP - BODY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              NoteSenderBalloon(
                noteModel: noteModel,
                onTap: () => _onSenderBalloonTap(),
              ),

              /// SPACER
              const SizedBox(
                width: Ratioz.appBarMargin,
                height: Ratioz.appBarMargin,
              ),

              /// NOTIFICATION CONTENT
              SizedBox(
                width: _bodyWidth - _moreButtonSize - Ratioz.appBarMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    /// TITLE
                    SuperVerse(
                      verse: Verse(
                        text: TextCheck.isEmpty(noteModel?.title) == false ?
                        noteModel?.title
                            :
                        'phid_title',
                        translate: false,
                      ),
                      maxLines: 5,
                      centered: false,
                      // textDirection: TextDir.autoSwitchTextDirection(
                      //     context: context,
                      //     val: noteModel?.title,
                      // ),
                    ),

                    /// TIME STAMP
                    SuperVerse(
                      verse: Verse(
                        text: Timers.calculateSuperTimeDifferenceString(
                          context: context,
                          from: noteModel?.sentTime,
                          to: DateTime.now(),
                        ),
                        translate: false,
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
                      verse: Verse(
                        text: TextCheck.isEmpty(noteModel?.body) == false ? noteModel?.body : '...',
                        translate: false,
                      ),
                      weight: VerseWeight.thin,
                      maxLines: 20,
                      centered: false,
                      // textDirection: TextDir.autoSwitchTextDirection(
                      //     context: context,
                      //     val: noteModel?.body,
                      // ),
                    ),

                  ],
                ),
              ),

              /// SPACER
              const SizedBox(
                width: Ratioz.appBarMargin,
                height: Ratioz.appBarMargin,
              ),

              /// MORE BUTTON
              DreamBox(
                height: _moreButtonSize,
                width: _moreButtonSize,
                icon: Iconz.more,
                iconSizeFactor: 0.7,
                onTap: onNoteOptionsTap,
              ),

            ],
          ),

          /// SPACER
          const SizedBox(
            width: Ratioz.appBarPadding,
            height: Ratioz.appBarPadding,
          ),

          /// POSTER
          if (noteModel?.poster?.type != null)
            Container(
              width: _clearWidth,
              alignment: Aligners.superInverseCenterAlignment(context),
              child: ClipRRect(
                borderRadius: NotePosterBox.getCorners(
                    context: context,
                    boxWidth: _bodyWidth,
                ),
                child: NotePosterBuilder(
                width: _bodyWidth,
                noteModel: noteModel,
          ),
              ),
            ),

          /// BUTTONS
          if (Mapper.checkCanLoopList(noteModel?.poll?.buttons) == true)
            Container(
              width: _clearWidth,
              alignment: Aligners.superInverseCenterAlignment(context),
              margin: const EdgeInsets.only(top: 10),
              child: NoteCardButtons(
                boxWidth: _bodyWidth,
                noteModel: noteModel,
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
