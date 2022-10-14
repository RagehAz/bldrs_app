import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NoteButtonsCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteButtonsCreatorBubble({
    @required this.note,
    @required this.noteNotifier,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
  /// --------------------------------------------------------------------------
  String _noteButtonsValidator(NoteModel note){
    String _message;

    // if (note?.type == NoteType.authorship){
    //   if (note?.buttons?.length != 2){
    //     return 'Authorship Note should include yes & no buttons';
    //   }
    // }

    return _message;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _noteButtonButtonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: PollModel.acceptDeclineButtons.length,
      boxWidth: TileBubble.childWidth(context: context),
    );
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    // --------------------
    final bool _noteHasButton = note?.poll?.buttons?.isNotEmpty;
    // --------------------
    return TileBubble(
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: const Verse(
          text: 'Buttons',
          translate: false,
        ),
        leadingIcon: Iconz.pause,
        leadingIconSizeFactor: 0.5,
        leadingIconBoxColor: _noteHasButton == true ? Colorz.green255 : Colorz.grey50,
      ),
      // secondLineVerse: const Verse(
      //   text: 'Add buttons to the Note',
      //   translate: false,
      // ),
      validator: () => _noteButtonsValidator(note),
      child: SizedBox(
        width: _bubbleClearWidth,
        child: Column(
          children: <Widget>[

            SizedBox(
              width: TileBubble.childWidth(context: context),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  ...List.generate(PollModel.acceptDeclineButtons.length, (index){

                    final String _phid = PollModel.acceptDeclineButtons[index];
                    final bool _isSelected = Stringer.checkStringsContainString(
                        strings: note?.poll?.buttons,
                        string: _phid
                    );

                    return DreamBox(
                      height: 40,
                      width: _noteButtonButtonWidth,
                      verse: Verse(
                        text: _phid,
                        translate: true,
                        casing: Casing.upperCase,
                      ),
                      verseScaleFactor: 0.5,
                      color: _isSelected == true ? Colorz.yellow255 : null,
                      verseColor: _isSelected == true ? Colorz.black255 : Colorz.white255,
                      verseWeight: _isSelected == true ? VerseWeight.black : VerseWeight.thin,
                      onTap: () => onAddNoteButton(
                        note: noteNotifier,
                        button: _phid,
                      ),
                    );

                  }),

                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
/// --------------------------------------------------------------------------
}
