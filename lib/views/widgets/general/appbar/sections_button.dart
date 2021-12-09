import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionsButton({
    this.onTap,
    this.color = Colorz.white10,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final Color color;
  /// --------------------------------------------------------------------------
  void _changeSection(BuildContext context) {

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
  final SectionClass.Section _currentSection = _generalProvider.currentSection;
  final KW _currentKeyword = _generalProvider.currentKeyword;


  const double _corners = Ratioz.boxCorner12;

  final String _sectionName = TextGen.sectionStringer(context, _currentSection);
  final String _titleVerse = _currentKeyword == null ? Wordz.section(context) : _sectionName;

  final String _sectionVerse = _currentKeyword == null ? TextGen.sectionStringer(context, _currentSection) : Name.getNameByCurrentLingoFromNames(context, _currentKeyword.names);
  // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;

  // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;


  return Builder(
    builder: (BuildContext context) => GestureDetector(
      onTap: onTap ?? () => _changeSection(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                      verse: _titleVerse,
                      size: 0,
                      italic: true,
                      color: Colorz.grey255,
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
                          verse: _sectionVerse,
                          size: 1,
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
