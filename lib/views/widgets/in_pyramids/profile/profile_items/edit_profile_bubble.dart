import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/textings/text_field_bubble.dart';
import 'package:flutter/material.dart';

class EditProfileBubbles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        TextFieldBubble(
          title: 'Name',
          keyboardTextInputType: TextInputType.name,
          actionBtIcon: Iconz.Gears,
        ),
        
      ],
    );
  }
}
