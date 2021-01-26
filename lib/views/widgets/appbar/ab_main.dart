import 'dart:ui';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/screens/s05_pg_countries_page.dart';
import 'package:flutter/material.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bt_search.dart';
import 'buttons/bt_section.dart';
import 'sliver_home_appbar.dart';

class ABMain extends StatefulWidget {
  final bool searchButtonOn;
  final bool countryButtonOn;
  final bool sectionsAreOn;

  ABMain({
    this.searchButtonOn = true,
    this.countryButtonOn = true,
    this.sectionsAreOn = true,
  });

  @override
  _ABMainState createState() => _ABMainState();
}

class _ABMainState extends State<ABMain> {
  bool sectionsAreExpanded;
  BldrsSection currentSection;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    currentSection = BldrsSection.Home;
    sectionsAreExpanded = false;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void expandingSections() {
    setState(() {
      sectionsAreExpanded = !sectionsAreExpanded;
    });
  }
// ---------------------------------------------------------------------------
  void choosingSection(BldrsSection section) {
    setState(() {
      currentSection = section;
      sectionsAreExpanded = false;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double abPadding = Ratioz.ddAppBarMargin * 0.5;
    double abHeight = sectionsAreExpanded == true ?
    (Ratioz.ddAppBarHeight * 4) - (abPadding * 3) : Ratioz.ddAppBarHeight;

    return ABStrip(
      abHeight: abHeight,

      rowWidgets: [
        // --- SEARCH BUTTON
        widget.searchButtonOn == true ?
        BtSearch(
          btSearchIsBackBt: sectionsAreExpanded == true ? true : false,
          tappingBack: expandingSections,
        ) : Container(),

        // --- SECTIONS BUTTON
        widget.sectionsAreOn == false ? Container() :
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // --- INITIAL SECTION BUTTON
            Container(
              // color: Colorz.BloodTest,
              margin: EdgeInsets.only(top: Ratioz.ddAppBarMargin * 0.5),
              child: InitialSectionsBT(
                expandingSections: expandingSections,
                currentSection: currentSection,
                sectionsAreExpanded: sectionsAreExpanded,
              ),
            ),

            // --- SECTIONS BUTTONS
            sectionsAreExpanded == false ? Container() :
            Container(
              // color: Colorz.BloodTest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Divider(height: abPadding,),

                  SectionToChooseBT(
                    section: BldrsSection.RealEstate,
                    choosingSection: choosingSection,
                  ),

                  Divider(height: abPadding,),

                  SectionToChooseBT(
                    section: BldrsSection.Construction,
                    choosingSection: choosingSection,
                  ),

                  Divider(height: abPadding,),

                  SectionToChooseBT(
                    section: BldrsSection.Supplies,
                    choosingSection: choosingSection,
                  ),

                ],
              ),
            ),

          ],
        ),

        // --- FILLER SPACE BETWEEN ITEMS
        sectionsAreExpanded == true ? Container() :
        Expanded(
          child: Container(),
        ),

        // --- LOCALIZER BUTTON
        sectionsAreExpanded == true || widget.countryButtonOn != true ? Container() :
        Padding(
          padding: EdgeInsets.only(top: Ratioz.ddAppBarMargin * 0.5),
          child: ButtonLocalizer(
            buttonFlag: flagFileNameSelectedFromPGLanguageList,
          ),
        ),

      ],
    );

  }
}

class ABStrip extends StatelessWidget {
  final List<Widget> rowWidgets;
  final double abHeight;
  final bool scrollable;

  ABStrip({
    this.rowWidgets,
    this.abHeight = Ratioz.ddAppBarHeight,
    this.scrollable = false,
  });
  @override
  Widget build(BuildContext context) {

    double screenWidth = superScreenWidth(context);
    double abWidth = screenWidth - (2 * Ratioz.ddAppBarMargin);

    return Container(
      width: abWidth,
      height: abHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.all(Ratioz.ddAppBarMargin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          boxShadow: [
            CustomBoxShadow(
                color: Colorz.BlackSmoke,
                offset: Offset(0, 0),
                blurRadius: abHeight * 0.18,
                blurStyle: BlurStyle.outer),
          ]),
      child: Stack(
        alignment: superCenterAlignment(context),
        children: <Widget>[

          // APPBAR SHADOW
          Container(
            width: double.infinity,
            height: abHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
                boxShadow: [
                  CustomBoxShadow(
                      color: Colorz.BlackBlack,
                      offset: Offset(0, 0),
                      blurRadius: abHeight * 0.18,
                      blurStyle: BlurStyle.outer),
                ]),
          ),

          // APPBAR BLUR
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                width: double.infinity,
                height: abHeight,
                decoration: BoxDecoration(
                    color: Colorz.WhiteAir,
                    borderRadius: BorderRadius.all(
                        Radius.circular(Ratioz.ddAppBarCorner))),
              ),
            ),
          ),

          // --- CONTENTS INSIDE THE APP BAR
          scrollable ?
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
                child: Container(
                  width: screenWidth - (2 * Ratioz.ddAppBarMargin),
                  height: 50,
                  alignment: Alignment.center,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: rowWidgets,
                  ),
                ),
              )
            ],
          )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowWidgets,
          ),
        ],
      ),
    );
  }
}
