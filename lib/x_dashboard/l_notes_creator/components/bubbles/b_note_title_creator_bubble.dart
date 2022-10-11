import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_notes_creator_controller.dart';
import 'package:flutter/material.dart';

class NoteTitleCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTitleCreatorBubble({
    @required this.titleController,
    @required this.noteNotifier,
    @required this.titleNode,
    @required this.bodyNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController titleController;
  final ValueNotifier<NoteModel> noteNotifier;
  final FocusNode titleNode;
  final FocusNode bodyNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TextFieldBubble(
      headerViewModel: BubbleHeaderVM(
        leadingIcon: Iconz.bxDesignsOff,
        leadingIconSizeFactor: 0.8,
        leadingIconBoxColor: titleController.text.isEmpty == true ? Colorz.grey50 : Colorz.green255,
        headlineVerse: Verse.plain('Note Title'),
      ),
      appBarType: AppBarType.basic,
      isFormField: true,
      textController: titleController,
      textOnChanged: (String text) => onTitleChanged(
        note: noteNotifier,
        text: text,
      ),
      counterIsOn: true,
      maxLines: 2,
      maxLength: 30,
      validator: (String text){
        if (titleController.text.length >= 30){
          return 'max length exceeded Bitch';
        }
        else if (titleController.text.isEmpty == true){
          return 'Atleast put 1 Character man';
        }
        else {
          return null;
        }
      },
      focusNode: titleNode,
      keyboardTextInputAction: TextInputAction.next,
      onSubmitted: (String text){
        Formers.focusOnNode(bodyNode);
      },
    );

  }
  /// --------------------------------------------------------------------------
}
