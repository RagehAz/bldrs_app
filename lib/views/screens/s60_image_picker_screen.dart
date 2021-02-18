import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.PyramidzWhite,
      canRefreshFlyers: false,
      layoutWidget: Center(
        child: InPyramidsBubble(
          columnChildren: <Widget>[
            SuperVerse(
              verse: 'Image Picker Screen',
            ),
          ],
        ),
      ),
    );
  }
}
