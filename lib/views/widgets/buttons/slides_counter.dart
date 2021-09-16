import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:flutter/material.dart';

class SlidesCounter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 1.3,
      verse: '122 slides',
      verseItalic: true,
      verseMaxLines: 2,
      verseScaleFactor: 0.5,
      secondLine: 'available',
      secondLineScaleFactor: 0.9,
      verseCentered: false,
      bubble: false,
      color: Colorz.White20,
      onTap: () async {

        dynamic _result = await CenterDialog.showCenterDialog(
          context: context,
          boolDialog: true,
          title: 'No Slides left',
          body: 'You don\'t have any more slides to add\nWould you wish to get more slides ?',
        );

        if(_result == false){
          print('No');
        }

        else {
          print('yes');
        }

      },
    );
  }
}
