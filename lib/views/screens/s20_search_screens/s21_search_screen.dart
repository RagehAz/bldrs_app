import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SuperVerse(
      verse: 'SearchScreen',
      color: Colorz.Yellow,
      italic: true,
      shadow: true,
      weight: VerseWeight.black,
      size: 8,
      centered: true,
      designMode: false,

    );
  }
}
