import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final dynamic bzFieldsList;

  BzPgFields({
    @required this.bzPageIsOn,
    @required this.flyerZoneWidth,
    @required this.bzFieldsList,

});

  @override
  Widget build(BuildContext context) {

    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
    final dynamic _fields = bzFieldsList;
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
            _fields == null ? [Container()] :
              List<Widget>.generate(
                  _fields.length,
                      (int index) {
                        return
                          SuperVerse(
                          verse: valueIsString(bzFieldsList) == true ? bzFieldsList : bzFieldsList[index],
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
