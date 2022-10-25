import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x2_user_notes_page_controllers.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NoteCardButtons extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteCardButtons({
    @required this.boxWidth,
    @required this.noteModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final NoteModel noteModel;
  /// --------------------------------------------------------------------------
  /*
  Verse _getResponseTimeString(BuildContext context, NoteModel noteModel){

    final String _string = Timers.calculateSuperTimeDifferenceString(
      from: noteModel.responseTime,
      to: DateTime.now(),
    );

    return Verse(
      text: _string,
      translate: false,
    );
  }
   */
  // --------------------
  /// TASK : FINALIZE THIS SHIT
  Verse _getResponseVerse(BuildContext context, NoteModel noteModel){

    Verse _output = const Verse(
      text: 'phid_responded',
      translate: true,
    );

    if (noteModel != null){

      if (noteModel.poll.reply == PollModel.accept){
        _output = const Verse(
          text: 'phid_accepted',
          translate: true,
        );
      }

      else if (noteModel.poll.reply == PollModel.decline){
        _output = const Verse(
          text: 'phid_declined',
          translate: true,
        );
      }

      else if (noteModel.poll.reply == PollModel.cancel){
        _output = const Verse(
          text: 'phid_cancelled',
          translate: true,
        );
      }

      else {
        _output = Verse(
          text: noteModel.poll.reply,
          translate: false,
        );
      }

    }

    return _output;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    final bool _replyIsNull = noteModel?.poll?.reply == null;
    // final bool _replyIsCancelled = noteModel?.poll?.reply == PollModel.cancel;
    final bool _replyIsPending = noteModel?.poll?.reply == PollModel.pending;

    return SizedBox(
      width: boxWidth,
      // height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          /// BUTTONS : WHEN NOT YET REPLIED
          if (_replyIsNull == true || _replyIsPending == true)
            Row(
              children: [
                ...List<Widget>.generate(noteModel.poll.buttons.length,
                        (int index) {
                      final String _phid = noteModel.poll.buttons[index];
                      final double _width = Scale.getUniformRowItemWidth(
                        context: context,
                        numberOfItems: noteModel.poll.buttons.length,
                        boxWidth: boxWidth,
                      );
                      return DreamBox(
                        width: _width,
                        height: 40,
                        verse: Verse(
                          text: _phid,
                          translate: true,
                        ),
                        verseScaleFactor: 0.7,
                        color: Colorz.blue80,
                        splashColor: Colorz.yellow255,
                        onTap: () => onNoteButtonTap(
                          context: context,
                          reply: _phid,
                          noteModel: noteModel,
                        ),
                      );
                    }
                )

              ],
            ),

          // /// BUTTONS
          // FutureBuilder(
          //   future: NoteModel.checkCanShowAuthorshipButtons(
          //     context: context,
          //     noteModel: noteModel,
          //   ),
          //   initialData: false,
          //   builder: (_, AsyncSnapshot<bool> snap){
          //
          //     final bool _canShow = snap.data;
          //
          //     /// BUTTONS : only if reply is null
          //     if (
          //     _replyIsNull == true
          //     ){
          //       return Row(
          //         children: [
          //           ...List<Widget>.generate(noteModel.poll.buttons.length,
          //                   (int index) {
          //                 final String _phid = noteModel.poll.buttons[index];
          //                 final double _width = Scale.getUniformRowItemWidth(
          //                   context: context,
          //                   numberOfItems: noteModel.poll.buttons.length,
          //                   boxWidth: boxWidth,
          //                 );
          //                 return DreamBox(
          //                   width: _width,
          //                   height: 40,
          //                   verse: Verse(
          //                     text: _phid,
          //                     translate: true,
          //                   ),
          //                   verseScaleFactor: 0.7,
          //                   color: Colorz.blue80,
          //                   splashColor: Colorz.yellow255,
          //                   onTap: () => onNoteButtonTap(
          //                     context: context,
          //                     reply: _phid,
          //                     noteModel: noteModel,
          //                   ),
          //                 );
          //               }
          //           )
          //
          //         ],
          //       );
          //     }
          //     else {
          //       return const SizedBox();
          //     }
          //
          //   },
          // ),

          /// replied
          if (_replyIsNull == false && _replyIsPending == false)
            SizedBox(
              width: boxWidth * 0.9,
              child: Column(
                children: <Widget>[

                  SuperVerse(
                    verse: _getResponseVerse(context, noteModel),
                    maxLines: 3,
                    weight: VerseWeight.black,
                    italic: true,
                    color: Colorz.yellow255,
                    size: 3,
                    margin: 5,
                    shadow: true,
                  ),

                  // SuperVerse(
                  //   verse: _getResponseTimeString(context, noteModel),
                  //   maxLines: 3,
                  //   weight: VerseWeight.black,
                  //   italic: true,
                  //   color: Colorz.yellow255,
                  //   size: 3,
                  //   margin: 5,
                  //   shadow: true,
                  // ),

                ],
              ),
            ),

        ],
      ),
    );

  }
// --------------------
}
