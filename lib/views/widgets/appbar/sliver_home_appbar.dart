import 'dart:ui';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bt_search.dart';
import 'buttons/bt_section.dart';


class SliverHomeAppBar extends StatefulWidget {

  @override
  _SliverHomeAppBarState createState() => _SliverHomeAppBarState();
}

class _SliverHomeAppBarState extends State<SliverHomeAppBar> {
  bool sectionsAreExpanded;
  BldrsSection currentSection;

  @override
  void initState() {
    currentSection = BldrsSection.Home;
    sectionsAreExpanded = false;
    super.initState();
  }

  void expandingSections() {
    if (sectionsAreExpanded == false) {
      setState(() {
        sectionsAreExpanded = true;
      });
    } else {
      setState(() {
        sectionsAreExpanded = false;
      });
    }
  }

  void choosingSection(BldrsSection section){
    setState(() {
      currentSection = section;
      sectionsAreExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double abPadding = Ratioz.ddAppBarMargin * 0.5;
    double abHeight = sectionsAreExpanded == true
        ? (Ratioz.ddAppBarHeight * 4) - (abPadding * 3)
        : Ratioz.ddAppBarHeight;

    return SliverPadding(
      padding: EdgeInsets.only(top: 0),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        floating: true,
        expandedHeight: abHeight + (abPadding),
        backgroundColor: Colorz.Nothing,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner))),
        titleSpacing: abPadding * 0,
        toolbarHeight: abHeight + (Ratioz.ddAppBarMargin * 2),
        title: Padding(
          padding: EdgeInsets.all(Ratioz.ddAppBarMargin), // this is the horizontal margin of the entire app bar
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              // --- SHADOW
              Container(
                width: double.infinity,
                height: abHeight,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Ratioz.ddAppBarCorner)),
                    boxShadow: [
                      CustomBoxShadow(
                          color: Colorz.BlackBlack,
                          offset: Offset(0, 0),
                          blurRadius: abHeight * 0.18,
                          blurStyle: BlurStyle.outer),
                      // CustomBoxShadow(
                      //     color: Colorz.BlackSmoke,
                      //     offset: Offset(0,0),
                      //     blurRadius: abHeight * 0.0,
                      //     blurStyle: BlurStyle.outer
                      // ),
                    ]),
              ),

              // --- BLUR
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
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

              // --- CONTENTS
              Padding(
                padding: EdgeInsets.all(abPadding), // this is inner padding of appbar squeezing appbar contents inside

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // --- SEARCH BUTTON
                    BtSearch(
                      btSearchIsBackBt: sectionsAreExpanded == true ? true : false,
                      tappingBack: expandingSections,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        InitialSectionsBT(
                          expandingSections: expandingSections,
                          currentSection: currentSection,
                          sectionsAreExpanded: sectionsAreExpanded,
                        ),

                        // --- SECTIONS BUTTONS
                        sectionsAreExpanded == false ? Container() :
                        Column(
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
                      ],
                    ),

                    // --- FILLER SPACE BETWEEN ITEMS
                    sectionsAreExpanded == true ? Container() :
                    Expanded(child: Container(),),

                    // --- LOCALIZER BUTTON
                    sectionsAreExpanded == true ? Container() :
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: abPadding * 0),
                      child: LocalizerButton(
                        // buttonFlag:
                        // Iconz.DvDonaldDuck,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SectionToChooseBT extends StatelessWidget {
  final Function choosingSection;
  final BldrsSection section;

  SectionToChooseBT({
    @required this.choosingSection,
    @required this.section,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double abPadding = Ratioz.ddAppBarMargin * 0.5;
    // double abHeight = Ratioz.ddAppBarHeight;

    double corners = Ratioz.ddBoxCorner * 1.5;

    bool designMode = false;

    double buttonWidth = (screenWidth - (2*Ratioz.ddAppBarMargin) - (3*abPadding) - 40) * 1;

    String sectionString =
    section == BldrsSection.RealEstate ? Wordz.realEstate(context) :
    section == BldrsSection.Construction ? Wordz.construction(context) :
    section == BldrsSection.Supplies ? Wordz.supplies(context) :
    Wordz.bldrsShortName(context);

    String description =
    section == BldrsSection.RealEstate ? Wordz.realEstateTagLine(context) :
    section == BldrsSection.Construction ? Wordz.constructionTagLine(context) :
    section == BldrsSection.Supplies ? Wordz.suppliesTagLine(context) :
    Wordz.bldrsShortName(context);

    return GestureDetector(
      onTap: () => choosingSection(section),
      child: IntrinsicWidth(
        child: Container(
          height: 40,
          width: buttonWidth,
          // margin: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin * 0.5),
          alignment: superCenterAlignment(context),
          decoration: BoxDecoration(
            color: Colorz.WhiteAir,
            borderRadius: BorderRadius.circular(corners),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SuperVerse(
                  verse: sectionString,
                  size: 2,
                  italic: false,
                  color: Colorz.White,
                  weight: VerseWeight.bold,
                  scaleFactor: 1,
                  designMode: designMode,
                  centered: false,
                  maxLines: 1,
                ),
                SuperVerse(
                  verse: description,
                  size: 1,
                  italic: true,
                  color: Colorz.WhiteLingerie,
                  centered: false,
                  weight: VerseWeight.thin,
                  designMode: designMode,
                  maxLines: 1,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
