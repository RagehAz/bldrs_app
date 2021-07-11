import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'check_box.dart';

class EnumListerTile extends StatelessWidget {

  final String verse;
  final Function onTap;
  final bool tileIsOn;

  EnumListerTile({
    @required this.verse,
    @required this.onTap,
    @required this.tileIsOn,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(Ratioz.appBarMargin * 0.2),
        decoration: BoxDecoration(
          color: const Color.fromARGB(5, 255, 255, 255),
          borderRadius: BorderRadius.circular(Ratioz.boxCorner8),
        ),
        child: Row(
          children: <Widget>[

            CheckBox(
                // onTap: (){},
                checkBoxIsOn: tileIsOn
            ),

            SuperVerse(
              verse: verse,
              size: 3,
              color: tileIsOn == true ? Colorz.White225 : Colorz.Grey225,
              shadow: tileIsOn == true ? false : false,
              weight: tileIsOn == true ? VerseWeight.bold : VerseWeight.thin,
              labelColor: tileIsOn == true ? Colorz.White50 : null,
            ),
          ],
        ),
      ),
    );
  }
}
