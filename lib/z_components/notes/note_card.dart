import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/bubbles/model/bubble_header_vm.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/notes/x_components/buttons/note_card_buttons.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/notes/x_components/note_sender_balloon.dart';
import 'package:bldrs/z_components/poster/note_poster_builder.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/maps/mapper.dart';

class NoteCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteCard({
    required this.noteModel,
    this.onNoteOptionsTap,
    this.onCardTap,
    this.bubbleWidth,
    this.bubbleColor,
    super.key
  });
  /// --------------------------------------------------------------------------
  final NoteModel? noteModel;
  final Function? onNoteOptionsTap;
  final Function? onCardTap;
  final double? bubbleWidth;
  final Color? bubbleColor;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static double getBubbleWidth(BuildContext context) {
    return Bubble.bubbleWidth(context: context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double bodyWidth({
    required BuildContext context,
    required double? widthOverride
  }) {
    return Bubble.clearWidth(
        context: context,
        bubbleWidthOverride: widthOverride) - NoteSenderBalloon.balloonWidth - (Ratioz.appBarMargin);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSenderBalloonTap() async {

    /// BZ
    if (noteModel?.parties?.senderType == PartyType.bz){

      blog('BZ TAPPED');

      await ScreenRouter.goTo(
        routeName: ScreenName.bzPreview,
        arg: noteModel?.parties?.senderID,
      );

    }

    /// USER
    else if (noteModel?.parties?.senderType == PartyType.user){

      await ScreenRouter.goTo(
        routeName: ScreenName.userPreview,
        arg: noteModel?.parties?.senderID,
      );

    }

    /// BLDRS
    else if (noteModel?.parties?.senderType == PartyType.bldrs){

      // await Nav.jumpToBldrsPreviewScreen(
      //     context: context,
      // );

      // await onFeedbackTap();

    }

    /// COUNTRY
    else if (noteModel?.parties?.senderType == PartyType.country){
      // await Nav.jumpToCountryPreviewScreen(
      //     context: context,
      //     countryID: noteModel.parties.senderID,
      // );

      blog('COUNTRY CANNOT BE PREVIEWED');
    }

    else {
      blog('NoteCard._onSenderBalloonTap() : ERROR : senderType not found');
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
    final bool _noteHasButtons = Lister.checkCanLoop(noteModel?.poll?.buttons);
    // --------------------
    final double _bubbleWidth = bubbleWidth ?? getBubbleWidth(context);
    final double _clearWidth = Bubble.clearWidth(
        context: context,
        bubbleWidthOverride: _bubbleWidth,
    );
    // --------------------
    return RedDotBadge(
      approxChildWidth: _bubbleWidth,
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
        bubbleColor: bubbleColor ?? (Mapper.boolIsTrue(noteModel?.seen) == true ? Colorz.white10 : Colorz.yellow50),
        columnChildren: <Widget>[

          /// SENDER BALLOON - TITLE - TIMESTAMP - BODY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// SENDER PIC
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
                    BldrsText(
                      verse: Verse(
                        id: TextCheck.isEmpty(noteModel?.title) == false ?
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
                    if (noteModel?.sentTime != null)
                    BldrsText(
                      verse: Verse(
                        id: BldrsTimers.calculateSuperTimeDifferenceString(
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
                    BldrsText(
                      verse: Verse(
                        id: TextCheck.isEmpty(noteModel?.body) == false ? noteModel?.body : '...',
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
              if (onNoteOptionsTap != null)
              BldrsBox(
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
              alignment: BldrsAligners.superInverseCenterAlignment(context),
              child: ClipRRect(
                borderRadius: NotePosterBox.getCorners(
                    boxWidth: _bodyWidth,
                ),
                child: NotePosterBuilder(
                width: _bodyWidth,
                noteModel: noteModel,
          ),
              ),
            ),

          /// BUTTONS
          if (Lister.checkCanLoop(noteModel?.poll?.buttons) == true)
            Container(
              width: _clearWidth,
              alignment: BldrsAligners.superInverseCenterAlignment(context),
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
