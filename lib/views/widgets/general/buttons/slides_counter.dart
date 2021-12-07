import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:flutter/material.dart';

class SlidesCounter extends StatelessWidget {
  const SlidesCounter({Key key}) : super(key: key);

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
      color: Colorz.white20,
      onTap: () async {

        final dynamic _result = await CenterDialog.showCenterDialog(
          context: context,
          boolDialog: true,
          title: 'No Slides left',
          body: "You don't have any more slides to add\nWould you wish to get more slides ?",
        );

        if(_result == false){
          blog('No');
        }

        else {
          blog('yes');
        }

      },
    );
  }
}
