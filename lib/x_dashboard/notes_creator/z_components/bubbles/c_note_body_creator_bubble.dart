import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/b_controllers/c_note_texts_controllers.dart';
import 'package:flutter/material.dart';

class NoteBodyCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteBodyCreatorBubble({
    @required this.bodyController,
    @required this.bodyNode,
    @required this.onTextChanged,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController bodyController;
  final FocusNode bodyNode;
  final ValueChanged<String> onTextChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TextFieldBubble(
      bubbleHeaderVM: BubbleHeaderVM(
        headlineVerse: Verse.plain('Note Body'),
        leadingIcon: Iconz.bxDesignsOff,
        leadingIconSizeFactor: 0.8,
        leadingIconBoxColor: bodyController.text.isEmpty == true ? Colorz.grey50 : Colorz.green255,
      ),
      appBarType: AppBarType.basic,
      isFormField: true,
      textController: bodyController,
      onTextChanged: onTextChanged,
      counterIsOn: true,
      maxLines: 7,
      maxLength: 80,
      keyboardTextInputType: TextInputType.multiline,
      keyboardTextInputAction: TextInputAction.newline,
      validator: noteBodyValidator,
      focusNode: bodyNode,
    );

  }
/// --------------------------------------------------------------------------
}
