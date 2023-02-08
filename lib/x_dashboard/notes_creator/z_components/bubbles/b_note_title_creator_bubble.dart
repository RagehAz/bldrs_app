import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';


import 'package:bldrs/x_dashboard/notes_creator/b_controllers/c_note_texts_controllers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class NoteTitleCreatorBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteTitleCreatorBubble({
    @required this.titleController,
    @required this.titleNode,
    @required this.bodyNode,
    @required this.onTextChanged,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TextEditingController titleController;
  final FocusNode titleNode;
  final FocusNode bodyNode;
  final ValueChanged<String> onTextChanged;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TextFieldBubble(
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        leadingIcon: Iconz.bxDesignsOff,
        leadingIconSizeFactor: 0.8,
        leadingIconBoxColor: titleController.text.isEmpty == true ? Colorz.grey50 : Colorz.green255,
        headlineVerse: Verse.plain('Note Title'),
      ),
      appBarType: AppBarType.basic,
      isFormField: true,
      textController: titleController,
      onTextChanged: onTextChanged,
      counterIsOn: true,
      maxLines: 2,
      maxLength: 30,
      validator: noteTitleValidator,
      focusNode: titleNode,
      keyboardTextInputAction: TextInputAction.next,
      onSubmitted: (String text){
        Formers.focusOnNode(bodyNode);
      },
    );

  }
  /// --------------------------------------------------------------------------
}
