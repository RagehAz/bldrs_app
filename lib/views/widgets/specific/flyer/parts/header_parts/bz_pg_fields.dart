import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzPgFields extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzPgFields({
    @required this.bzPageIsOn,
    @required this.flyerBoxWidth,
    @required this.bzScope,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool bzPageIsOn;
  final String bzScope;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    const Color bzPageBGColor = Colorz.black80;
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
            children: <Widget>[

              SuperVerse(
                verse: Wordz.scopeOfServices(context),
                weight: VerseWeight.thin,
                margin: 10,
                color: Colorz.grey255,
                maxLines: 2,
              ),

          Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children:
              bzScope == '' ? <Widget>[Container()] :
              List<Widget>.generate(
              1,
                  (int index) {
                return
                  SuperVerse(
                    verse: bzScope,
                    labelColor: Colorz.white50,
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
