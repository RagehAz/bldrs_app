import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_dashboard/a_modules/a_test_labs/specialized_labs/ask/enum_lister/check_box.dart';
import 'package:flutter/material.dart';

class EnumListerTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EnumListerTile({
    @required this.verse,
    @required this.onTap,
    @required this.tileIsOn,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String verse;
  final Function onTap;
  final bool tileIsOn;

  /// --------------------------------------------------------------------------
  bool _shadow() {
    bool _shadowIsOn;
    if (tileIsOn == true) {
      _shadowIsOn = false;
    } else {
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
                checkBoxIsOn: tileIsOn),
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
