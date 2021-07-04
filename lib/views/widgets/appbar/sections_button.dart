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
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionsButton extends StatelessWidget {
// -----------------------------------------------------------------------------
  void _onSectionTap({BuildContext context, FlyersProvider pro, Section section}){


    /// if section is not active * if user is author or not

    /// if section is active
    pro.changeSection(context, section);
  }
// -----------------------------------------------------------------------------
  String _sectionIcon({Section section, bool inActiveMode}){
    String _icon;

    if (inActiveMode == true){
      _icon = Iconizer.sectionIconOff(section);
    }
    else {
      _icon = Iconizer.sectionIconOn(section);
    }

    return _icon;
  }
// -----------------------------------------------------------------------------
void _changeSection(BuildContext context, FlyersProvider pro) async {

  List<Section> _sections = SectionClass.SectionsList;
  double _bubbleWidth = Scale.superDialogWidth(context) - Ratioz.appBarMargin * 2;
  double _buttonWidth = _bubbleWidth * 0.9;
  double _dialogHeight = Scale.superScreenHeight(context) * 0.95;

  Widget _sectionBubble({String title, String icon, List<Widget> buttons}){
    return
      InPyramidsBubble(
        centered: false,
        title: title,
        // actionBtIcon: Iconz.BxPropertiesOn,
        actionBtSizeFactor: 1,
        actionBtFunction: (){},
        bubbleColor: Colorz.WhiteGlass,
        bubbleOnTap: null,
        bubbleWidth: _bubbleWidth,
        leadingIcon: icon,
        leadingIconColor: Colorz.WhiteZircon,
        titleColor: Colorz.WhiteZircon,
        columnChildren: <Widget>[

          /// Section buttons
          Container(
            width: _buttonWidth,
            // color: Colorz.BloodTest,
            // alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buttons,
            ),
          ),


        ],
      );
  }


  Widget _sectionButton({Section section, bool inActiveMode}){

    return
      DreamBox(
        height: _dialogHeight * 0.06,
        // width: _buttonWidth,
        icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
        verse: TextGenerator.sectionStringer(context, section),
        verseScaleFactor: 0.6,
        secondLine: TextGenerator.sectionDescriptionStringer(context, section),
        secondLineColor: Colorz.WhiteLingerie,
        margins: Ratioz.appBarPadding,
        inActiveMode: inActiveMode,
        boxFunction: () => _onSectionTap(context: context, section: section, pro: pro),
      );
  }

  dynamic _result = await superDialog(
    context: context,
    body: 'Select a section',
    height: _dialogHeight,
    child: Container(
      height: _dialogHeight  - 60,
      // color: Colorz.BloodTest,
      child: Column(
        children: <Widget>[

          /// REAL ESTATE
          _sectionBubble(
            title: 'RealEstate',
            icon: Iconz.PyramidSingleYellow,
            buttons: <Widget>[

              _sectionButton(
                section: Section.NewProperties,
                inActiveMode: false,
              ),

              _sectionButton(
                section: Section.ResaleProperties,
                inActiveMode: false,
              ),

              _sectionButton(
                section: Section.RentalProperties,
                inActiveMode: true,
              ),

            ]
          ),

          /// Construction
          _sectionBubble(
              title: 'Construction',
              icon: Iconz.PyramidSingleYellow,
              buttons: <Widget>[

                _sectionButton(
                  section: Section.Designs,
                  inActiveMode: false,
                ),

                _sectionButton(
                  section: Section.Projects,
                  inActiveMode: false,
                ),

                _sectionButton(
                  section: Section.Crafts,
                  inActiveMode: false,
                ),

              ]
          ),

          /// Construction
          _sectionBubble(
            title: 'Supplies',
            icon: Iconz.PyramidSingleYellow,
            buttons: <Widget>[

              _sectionButton(
                section: Section.Products,
                inActiveMode: false,
                ),

              _sectionButton(
                section: Section.Equipment,
                inActiveMode: true,
              ),

            ],
          ),



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
