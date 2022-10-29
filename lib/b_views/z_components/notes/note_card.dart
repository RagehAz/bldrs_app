import 'dart:async';

import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x2_user_notes_page_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/buttons/note_card_buttons.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_sender_balloon.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/a_note_poster_builder.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
  Future<void> _onNoteOptionsTap({
    @required BuildContext context,
  }) async {

    noteModel.blogNoteModel();

    if (onNoteOptionsTap != null){
      onNoteOptionsTap();
    }

    else {

      await onShowNoteOptions(
        context: context,
        noteModel: noteModel,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSenderBalloonTap({
    @required BuildContext context,
  }) async {

    /// BZ
    if (noteModel.parties.senderType == PartyType.bz){

      await Nav.jumpToBzPreviewScreen(
        context: context,
        bzID: noteModel.parties.senderID,
      );

    }

    /// USER
    else if (noteModel.parties.senderType == PartyType.user){

      await Nav.jumpToUserPreviewScreen(
        context: context,
        userID: noteModel.parties.senderID,
      );

    }

    /// BLDRS
    else if (noteModel.parties.senderType == PartyType.bldrs){

      await Nav.jumpToBldrsPreviewScreen(
          context: context,
      );

    }

    /// COUNTRY
    else if (noteModel.parties.senderType == PartyType.country){
      await Nav.jumpToCountryPreviewScreen(
          context: context,
          countryID: noteModel.parties.senderID,
      );
    }

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
        headerViewModel: const BubbleHeaderVM(
          centered: true,
        ),
        width: _bubbleWidth,
        childrenCentered: true,
        margins: const EdgeInsets.only(
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
                onTap: () => _onSenderBalloonTap(
                  context: context,
                ),
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
                      verse: Verse(
                        text: TextCheck.isEmpty(noteModel?.title) == false ?
                        noteModel?.title
                            :
                        'phid_title',
                        translate: false,
                      ),
                      maxLines: 5,
                      centered: false,
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
                onTap: () => _onNoteOptionsTap(
                  context: context,
                ),
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
