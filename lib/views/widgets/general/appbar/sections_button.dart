import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/dialogs/section_dialog/section_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  final Function onTap;
  final Color color;

  const SectionsButton({
    this.onTap,
    this.color = Colorz.White10,
});
// -----------------------------------------------------------------------------
  void _changeSection(BuildContext context, FlyersProvider pro) async {

  final double _dialogHeight = Scale.superScreenHeight(context) * 0.95;

  await SectionDialog.slideDialog(
    context: context,
    pro: pro,
    dialogHeight: _dialogHeight,
  );

}
// -----------------------------------------------------------------------------
@override
Widget build(BuildContext context) {
  final FlyersProvider _pro =  Provider.of<FlyersProvider>(context, listen: true);
  final Section _currentSection = _pro.getCurrentSection;

  final double _corners = Ratioz.boxCorner12;

  final bool _designMode = false;

  final String _buttonTitle = Wordz.section(context) ;

  // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;

  // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;

  final String _sectionName = TextGenerator.sectionStringer(context, _currentSection);

  return GestureDetector(
    onTap: onTap == null ? () => _changeSection(context, _pro) : onTap,
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
                    color: Colorz.Grey225,
                    weight: VerseWeight.thin,
                    designMode: _designMode,
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
                        color: Colorz.White255,
                        weight: VerseWeight.bold,
                        scaleFactor: 1,
                        designMode: _designMode,
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
  );
}
}