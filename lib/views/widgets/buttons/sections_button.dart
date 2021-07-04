import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {

// -----------------------------------------------------------------------------
void _changeSection(BuildContext context, FlyersProvider pro) async {

  List<Section> _sections = SectionClass.SectionsList;

  dynamic _result = await superDialog(
    context: context,
    title: '',
    body: 'Select a section',
    height: Scale.superScreenHeight(context) * 0.7,
    child: Container(
      height: Scale.superScreenHeight(context) * 0.7 - 30 - 116,
      child: Column(
        children: <Widget>[

          ...List.generate(
              _sections.length,
                  (index) =>

                      TileBubble(
                        verse: TextGenerator.sectionStringer(context, _sections[index]),
                        icon: Iconizer.bzTypeIconOn(BzType.Broker),
                        iconSizeFactor: 1,
                        secondLine: TextGenerator.sectionDescriptionStringer(context, _sections[index]),
                        insideDialog: true,
                        btOnTap: () async {
                          print(_sections[index]);

                          await pro.changeSection(context, _sections[index]);

                          /// close dialog
                          Nav.goBack(context);
                        },
                      ),

          )

        ],
      ),
    ),
  );

}
// -----------------------------------------------------------------------------
@override
Widget build(BuildContext context) {
  FlyersProvider _pro =  Provider.of<FlyersProvider>(context, listen: true);
  Section _currentSection = _pro.getCurrentSection;

  double _corners = Ratioz.boxCorner12;

  bool _designMode = false;

  String _buttonTitle = Wordz.section(context) ;

  // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;

  // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;

  String _sectionName = TextGenerator.sectionStringer(context, _currentSection);

  return GestureDetector(
    onTap: () => _changeSection(context, _pro),
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
              color: Colorz.WhiteAir,
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
                    color: Colorz.Grey,
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
                        color: Colorz.White,
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

// class SectionButton extends StatelessWidget {
//   final Function choosingSection;
//   final BldrsSection section;
//
//   SectionButton({
//     @required this.choosingSection,
//     @required this.section,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _screenWidth = Scale.superScreenWidth(context);
//
//     double _abPadding = Ratioz.ddAppBarPadding;
//
//     double _corners = Ratioz.ddBoxCorner12;
//
//     bool _designMode = false;
//
//     double _buttonWidth = (_screenWidth - (2*Ratioz.ddAppBarMargin) - (3*_abPadding) - 40) * 1;
//
//     String _sectionString =
//     section == BldrsSection.RealEstate ? Wordz.realEstate(context) :
//     section == BldrsSection.Construction ? Wordz.construction(context) :
//     section == BldrsSection.Supplies ? Wordz.supplies(context) :
//     Wordz.bldrsShortName(context);
//
//     String _description =
//     section == BldrsSection.RealEstate ? Wordz.realEstateTagLine(context) :
//     section == BldrsSection.Construction ? Wordz.constructionTagLine(context) :
//     section == BldrsSection.Supplies ? Wordz.suppliesTagLine(context) :
//     Wordz.bldrsShortName(context);
//
//     return GestureDetector(
//       onTap: () => choosingSection(section),
//       child: IntrinsicWidth(
//         child: Container(
//           height: 40,
//           width: _buttonWidth,
//           // margin: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin * 0.5),
//           alignment: Aligners.superCenterAlignment(context),
//           decoration: BoxDecoration(
//             color: Colorz.WhiteAir,
//             borderRadius: BorderRadius.circular(_corners),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SuperVerse(
//                   verse: _sectionString,
//                   size: 2,
//                   italic: false,
//                   color: Colorz.White,
//                   weight: VerseWeight.bold,
//                   scaleFactor: 1,
//                   designMode: _designMode,
//                   centered: false,
//                   maxLines: 1,
//                 ),
//                 SuperVerse(
//                   verse: _description,
//                   size: 1,
//                   italic: true,
//                   color: Colorz.WhiteLingerie,
//                   centered: false,
//                   weight: VerseWeight.thin,
//                   designMode: _designMode,
//                   maxLines: 1,
//                 )
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
