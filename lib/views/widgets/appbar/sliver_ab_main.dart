import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:flutter/material.dart';
import 'ab_strip.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bt_search.dart';
import 'buttons/bt_section.dart';
import 'pages/pg_country.dart';

class SliverABMain extends StatefulWidget {
  // final List<Map<String, String>> sections;
  final String currentSection;
  final Function selectingASection;
  final bool sectionsListIsOpen;
  final Function openingTheList;

  SliverABMain({
    // @required this.sections,
    @required this.currentSection,
    @required this.selectingASection,
    @required this.sectionsListIsOpen,
    @required this.openingTheList,
});

  @override
  _SliverABMainState createState() => _SliverABMainState();
}

class _SliverABMainState extends State<SliverABMain> {
bool sectionsAreExpanded;

@override
void initState(){
  sectionsAreExpanded = false;
  super.initState();
}

  void expandingSections(){
    setState(() {
      sectionsAreExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    // double screenHeight = MediaQuery.of(context).size.height;

    // double abMargins = 10;
    // double abHeight = sectionsListIsOpen == false ? 50 : (screenHeight - (Ratioz.ddPyramidsHeight+10));
    const double abSpacings = 5;
    // double abPadding = Ratioz.ddAppBarMargin * 2;
    // double abHeight = Ratioz.ddAppBarHeight;
    // double abButtonsHeight = abHeight - (abPadding);
    //
    // double corners = Ratioz.ddBoxCorner *1.5;
    //
    // bool designMode = false;

    return AppBarStrip(
      rowWidgets: <Widget>[

        // --- SEARCH BUTTON
        sectionsAreExpanded == true ? Container() :
        Padding(
          padding: EdgeInsets.symmetric(horizontal: abSpacings),
          child: widget.sectionsListIsOpen == true ? Container() : BtSearch(),
        ),

        // --- SECTION BUTTON
        InitialSectionsBT(
          expandingSections: expandingSections,
          currentSection: BldrsSection.RealEstate,
          sectionsAreExpanded: sectionsAreExpanded,
        ),

         // --- FILLER SPACE BETWEEN ITEMS
        sectionsAreExpanded == true ? Container() :
         Expanded(
           child: Container(),
         ),

        // --- LOCALIZER BUTTON
        sectionsAreExpanded == true ? Container() :
        Padding(
            padding: EdgeInsets.symmetric(horizontal: abSpacings*0),
            child: ButtonLocalizer(
              buttonFlag: flagFileNameSelectedFromPGLanguageList,
            ),
          ),
        ],
    );
  }
}
