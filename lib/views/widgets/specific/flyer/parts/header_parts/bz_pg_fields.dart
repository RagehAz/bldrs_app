import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final String bzScope;

  const BzPgFields({
    @required this.bzPageIsOn,
    @required this.flyerBoxWidth,
    @required this.bzScope,

});

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    const Color bzPageBGColor = Colorz.Black80;
    final double bzPageDividers = flyerBoxWidth * 0.005;
// -----------------------------------------------------------------------------

    return
      bzPageIsOn == false ? Container():
      Padding(
        padding: EdgeInsets.only(top: bzPageDividers),
        child: Container(
          width: flyerBoxWidth,
          color: bzPageBGColor,
          padding: EdgeInsets.symmetric(vertical: flyerBoxWidth * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SuperVerse(
                verse: '${Wordz.scopeOfServices(context)}',
                size: 2,
                weight: VerseWeight.thin,
                italic: false,
                margin: 10,
                color: Colorz.Grey225,
                maxLines: 2,
              ),

          Wrap(
              spacing: 0,
              runSpacing: 0,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              runAlignment: WrapAlignment.center,
              children:
              bzScope == '' ? [Container()] :
              List<Widget>.generate(
              1,
                  (int index) {
                return
                  SuperVerse(
                    verse: bzScope,
                    italic: false,
                    shadow: false,
                    labelColor: Colorz.White50,
                    color: Colorz.White255,
                    weight: VerseWeight.bold,
                    size: 2,
                    margin: flyerBoxWidth * 0.02 * 0,
                  );
              }
              )


      ),

            ],
          ),

        ),
      )
    ;
  }
}
