// ignore_for_file: avoid_bool_literals_in_conditional_expressions
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class NoteDismissibleTriggerBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteDismissibleTriggerBubble({
    @required this.note,
    @required this.onSwitch,
    @required this.isDismissible,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<bool> onSwitch;
  final NoteModel note;
  final bool isDismissible;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    bool _isOn;
    if (note.sendFCM == true){
      _isOn = isDismissible;
    }
    else {
      _isOn = false;
    }

    return WidgetFader(
      fadeType: note.sendFCM == true ? FadeType.stillAtMax : FadeType.stillAtMin,
      min: 0.2,
      absorbPointer: !note.sendFCM,
      child: TileBubble(
        bubbleHeaderVM: BubbleHeaderVM(
          headlineVerse: Verse.plain('Notification is Dismissible'),
          leadingIcon: Iconz.fingerTap,
          leadingIconSizeFactor: 0.5,
          leadingIconBoxColor: _isOn == true ? Colorz.green255 : Colorz.grey50,
          hasSwitch: true,
          switchValue: _isOn,
          onSwitchTap: onSwitch,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}