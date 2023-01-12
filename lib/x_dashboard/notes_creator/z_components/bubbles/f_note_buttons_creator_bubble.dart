import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poll_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:scale/scale.dart';
import 'package:stringer/stringer.dart';


import 'package:bldrs/x_dashboard/notes_creator/b_controllers/g_buttons_controller.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NoteButtonsCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteButtonsCreatorBubble({
    @required this.note,
    @required this.onAddButton,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueChanged<String> onAddButton;
  /// --------------------------------------------------------------------------
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
      validator: () => noteButtonsValidator(note),
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
                      onTap: () => onAddButton(_phid),
                    );

                  }),

                ],
              ),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
