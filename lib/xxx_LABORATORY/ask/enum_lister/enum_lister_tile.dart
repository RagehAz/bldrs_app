import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/xxx_LABORATORY/ask/enum_lister/check_box.dart';
import 'package:flutter/material.dart';

class EnumListerTile extends StatelessWidget {

  final String verse;
  final Function onTap;
  final bool tileIsOn;

  const EnumListerTile({
    @required this.verse,
    @required this.onTap,
    @required this.tileIsOn,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  bool _shadow(){
    bool _shadowIsOn;
    if (tileIsOn == true){
      _shadowIsOn = false;
    }
    else {
      _shadowIsOn = true;
    }

    return _shadowIsOn;
  }
// -----------------------------------------------------------------------------
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
              color: tileIsOn == true ? Colorz.white255 : Colorz.grey255,
              shadow: _shadow(),
              weight: tileIsOn == true ? VerseWeight.bold : VerseWeight.thin,
              labelColor: tileIsOn == true ? Colorz.white50 : null,
            ),
          ],
        ),
      ),
    );
  }
}
