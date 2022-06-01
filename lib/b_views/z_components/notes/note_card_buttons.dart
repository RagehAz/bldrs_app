import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/notes_controllers/notes_controller.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

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
  String _getResponseTimeString(BuildContext context, NoteModel noteModel){
    final String _string = Timers.getSuperTimeDifferenceString(
      from: noteModel.responseTime,
      to: DateTime.now(),
    );
    return _string;
  }
// -----------------------------------------------------------------------------
  String _getResponseString(BuildContext context, NoteModel noteModel){

    String _output = 'responded';

    if (noteModel != null){

      if (noteModel.response == 'phid_accept'){
        _output = 'Accepted';
      }

      else if (noteModel.response == 'phid_decline'){
        _output = 'Declined';
      }

      else {
        _output = noteModel.response;
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: boxWidth,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          if (noteModel.response == null)
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
                  verse: _phid,
                  verseScaleFactor: 0.7,
                  color: Colorz.blue80,
                  splashColor: Colorz.yellow255,
                  onTap: () => onNoteButtonTap(
                    context: context,
                    response: _phid,
                    noteModel: noteModel,
                  ),
                );

              }
          ),

          if (noteModel.response != null)
            SizedBox(
              width: boxWidth * 0.9,
              child: SuperVerse(
                verse: 'You ${_getResponseString(context, noteModel)}\n${_getResponseTimeString(context, noteModel)}',
                maxLines: 3,
                weight: VerseWeight.black,
                italic: true,
                color: Colorz.yellow255,
                size: 3,
                margin: 5,
                shadow: true,
              ),
            ),

        ],
      ),
    );

  }
}
