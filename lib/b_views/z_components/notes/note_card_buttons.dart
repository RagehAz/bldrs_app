import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/streamers/clock_rebuilder.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x2_user_notes_page_controllers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';

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
  // --------------------
  /// TASK : FINALIZE THIS SHIT
  Verse _getResponseVerse(BuildContext context, NoteModel noteModel){

    Verse _output = const Verse(
      text: 'phid_responded',
      translate: true,
    );

    if (noteModel != null){

      if (noteModel.response == NoteResponse.accepted){
        _output = const Verse(
          text: 'phid_accepted',
          translate: true,
        );
      }

      else if (noteModel.response == NoteResponse.declined){
        _output = const Verse(
          text: 'phid_declined',
          translate: true,
        );
      }

      else if (noteModel.response == NoteResponse.cancelled){
        _output = const Verse(
          text: 'phid_cancelled',
          translate: true,
        );
      }

      else {
        _output = Verse(
          text: noteModel.response.toString(),
          translate: false,
        );
      }

    }

    return _output;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: boxWidth,
      // height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          if (noteModel.response == NoteResponse.pending)
          ...List<Widget>.generate(noteModel.buttons.length,
                  (int index) {

                final String _phid = noteModel.buttons[index];

                final double _width = Scale.getUniformRowItemWidth(
                  context: context,
                  numberOfItems: noteModel.buttons.length,
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
                    response: NoteModel.getNoteResponseByPhid(_phid),
                    noteModel: noteModel,
                  ),
                );

              }
          ),

          if (noteModel.response != NoteResponse.pending)
            SizedBox(
              width: boxWidth * 0.9,
              child: ClockRebuilder(
                startTime: noteModel.responseTime,
                duration: const Duration(minutes: 1),
                builder: (int fuck, Widget child){

                  return Column(
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

                      SuperVerse(
                        verse: _getResponseTimeString(context, noteModel),
                        maxLines: 3,
                        weight: VerseWeight.black,
                        italic: true,
                        color: Colorz.yellow255,
                        size: 3,
                        margin: 5,
                        shadow: true,
                      ),

                    ],
                  );

                },
              ),
            ),

        ],
      ),
    );

  }
// --------------------
}
