import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final List<String> fieldo;

  BzPgFields({
    @required this.bzPageIsOn,
    @required this.flyerZoneWidth,
    @required this.fieldo,

});

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    final dynamic _fields = fieldo;
    // ['Architecture Design', 'abcd', 'Interior Design', 'Landscape Design'];
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    dynamic bzPageBGColor = Colorz.BlackSmoke;
    double bzPageDividers = flyerZoneWidth * 0.005;
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

    return
      bzPageIsOn == false ? Container():
      Padding(
        padding: EdgeInsets.only(top: bzPageDividers),
        child: Container(
          width: flyerZoneWidth,
          color: bzPageBGColor,
          padding: EdgeInsets.symmetric(vertical: flyerZoneWidth * 0.02),
          child: Wrap(
            spacing: 0,
            runSpacing: 0,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            runAlignment: WrapAlignment.center,

            children:
              List<Widget>.generate(
                  _fields.length,
                      (int index) {
                        return
                          SuperVerse(
                          verse: fieldo[index],
                          italic: false,
                          shadow: false,
                          labelColor: Colorz.WhiteZircon,
                          color: Colorz.White,
                          weight: VerseWeight.bold,
                          size: 2,
                          margin: flyerZoneWidth * 0.02 * 0,
                        );
                      }
              )


          ),

        ),
      )
    ;
  }
}
