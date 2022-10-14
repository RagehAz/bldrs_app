import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NoteBodyCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteBodyCreatorBubble({
    @required this.bodyController,
    @required this.noteNotifier,
    @required this.bodyNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController bodyController;
  final ValueNotifier<NoteModel> noteNotifier;
  final FocusNode bodyNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TextFieldBubble(
      headerViewModel: BubbleHeaderVM(
        headlineVerse: Verse.plain('Note Body'),
        leadingIcon: Iconz.bxDesignsOff,
        leadingIconSizeFactor: 0.8,
        leadingIconBoxColor: bodyController.text.isEmpty == true ? Colorz.grey50 : Colorz.green255,
      ),
      appBarType: AppBarType.basic,
      isFormField: true,
      textController: bodyController,
      textOnChanged: (String text) => onBodyChanged(
        note: noteNotifier,
        text: text,
      ),
      counterIsOn: true,
      maxLines: 7,
      maxLength: 80,
      keyboardTextInputType: TextInputType.multiline,
      keyboardTextInputAction: TextInputAction.newline,
      validator: (String text){
        if (bodyController.text.length >= 80){
          return 'max length exceeded Bitch';
        }
        else if (bodyController.text.isEmpty){
          return 'Add more than 1 Character';
        }
        else {
          return null;
        }
      },
      focusNode: bodyNode,
    );

  }
/// --------------------------------------------------------------------------
}
