import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';


class ButtonLocalizer extends StatelessWidget {
  final String buttonFlag;

  ButtonLocalizer({
    @required this.buttonFlag,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routez.Localizer);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              // width: 40,
              height: 40,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Ratioz.ddAppBarButtonCorner)),
                  color: Colorz.WhiteAir),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- COUNTRY & CITY NAMES
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SuperVerse(
                            verse: 'Country Name',
                            size: 1,
                          ),
                          SuperVerse(
                            verse: 'City Name',
                            size: 1,
                            scaleFactor: 0.8,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- FLAG
                  DreamBox(
                    height: 30,
                    icon: buttonFlag,
                    corners: Ratioz.ddBoxCorner,
                    boxMargins: EdgeInsets.symmetric(horizontal: 2.5),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
