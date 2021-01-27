import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import 'in_pyramids_bubble.dart';

class LocaleBubble extends StatelessWidget {
  final String title;

  LocaleBubble({
    @required this.title,
});

  // ----------------------------------------------------------------------
  void openCityList(){
    print('this will be fun');
  }


  @override
  Widget build(BuildContext context) {
    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
          ),

          DreamBox(
            height: 40,
            bubble: false,
            verse: 'city, ${Wordz.country(context)}',
            color: Colorz.WhiteAir,
            boxFunction: openCityList,
          )
        ]
    );
  }
}
