import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NoteFCMTriggerBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteFCMTriggerBubble({
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

    return TileBubble(
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: const Verse(
          text: 'Send FCM',
          translate: false,
        ),
        leadingIcon: Iconz.news,
        leadingIconSizeFactor: 0.5,
        leadingIconBoxColor: note.sendFCM == true ? Colorz.green255 : Colorz.grey50,
        switchValue: note?.sendFCM,
        hasSwitch: true,
        onSwitchTap: (bool val) => onSwitchSendFCM(
          note: noteNotifier,
          value: val,
        ),

      ),
      // secondLineVerse: const Verse(
      //   text: 'This sends firebase cloud message to the receiver or '
      //       'to a group of receivers through a channel',
      //   translate: false,
      // ),
    );

  }
}
