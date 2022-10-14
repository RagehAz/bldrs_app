import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/x_notes_creator_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteAndFCMTriggersBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteAndFCMTriggersBubble({
    @required this.note,
    @required this.noteNotifier,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel note;
  final ValueNotifier<NoteModel> noteNotifier;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = (PageBubble.width(context) - 10) / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        /// SEND NOTE
        TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Send Note',
              translate: false,
            ),
            leadingIcon: Iconz.notification,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note.sendNote == true ? Colorz.green255 : Colorz.grey50,
            switchValue: note?.sendNote,
            hasSwitch: true,
            onSwitchTap: (bool val) => onSwitchSendNote(
              note: noteNotifier,
              value: val,
            ),
          ),
          onTileTap: () => onSwitchSendNote(
            note: noteNotifier,
            value: !note.sendNote,
          ),
          // secondLineVerse: const Verse(
          //   text: 'This sends firebase cloud message to the receiver or '
          //       'to a group of receivers through a channel',
          //   translate: false,
          // ),
        ),

        /// SEND FCM
        TileBubble(
          bubbleWidth: _tileWidth,
          bubbleHeaderVM: BubbleHeaderVM(
            headlineVerse: const Verse(
              text: 'Send FCM',
              translate: false,
            ),
            leadingIcon: Iconz.advertise,
            leadingIconSizeFactor: 0.5,
            leadingIconBoxColor: note.sendFCM == true ? Colorz.green255 : Colorz.grey50,
            switchValue: note?.sendFCM,
            hasSwitch: true,
            onSwitchTap: (bool val) => onSwitchSendFCM(
              note: noteNotifier,
              value: val,
            ),
          ),
          onTileTap: () => onSwitchSendFCM(
            note: noteNotifier,
            value: !note.sendFCM,
          ),
          // secondLineVerse: const Verse(
          //   text: 'This sends firebase cloud message to the receiver or '
          //       'to a group of receivers through a channel',
          //   translate: false,
          // ),
        ),

      ],
    );

  }
}
