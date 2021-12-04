import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/kw/section_class.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  final Function onTap;
  final Color color;

  const SectionsButton({
    this.onTap,
    this.color = Colorz.white10,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  void _changeSection(BuildContext context) async {

  // final double _dialogHeight = Scale.superScreenHeight(context) * 0.95;

  Scaffold.of(context).openDrawer();
  // await SectionDialog.slideDialog(
  //   context: context,
  //   dialogHeight: _dialogHeight,
  // );

}
// -----------------------------------------------------------------------------
@override
Widget build(BuildContext context) {

  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
  final Section _currentSection = _generalProvider.currentSection;


  const double _corners = Ratioz.boxCorner12;

  final String _buttonTitle = Wordz.section(context) ;

  // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;

  // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;

  final String _sectionName = TextGen.sectionStringer(context, _currentSection);

  return Builder(
    builder: (BuildContext context) => GestureDetector(
      onTap: onTap == null ? () => _changeSection(context) : onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Container(
              height: 40,
              // width: buttonWidth,
              // margin: const EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin*0.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(_corners),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  /// 'Section' TITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SuperVerse(
                      verse: _buttonTitle,
                      size: 0,
                      italic: true,
                      color: Colorz.grey225,
                      weight: VerseWeight.thin,
                      centered: false,
                    ),
                  ),

                  /// CURRENT SECTION NAME
                  // MAYBE WE WILL NEED CHANGE NOTIFIER PROVIDER . VALUE HERE TO LISTEN TO CHANGES
                  //         ChangeNotifierProvider.value(
                  //           value: _countryPro,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[

                        SuperVerse(
                          verse: _sectionName,
                          size: 1,
                          italic: false,
                          color: Colorz.white255,
                          weight: VerseWeight.bold,
                          scaleFactor: 1,
                          centered: false,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    ),
  );
}
}