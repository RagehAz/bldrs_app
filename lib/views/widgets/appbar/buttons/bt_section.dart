import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../sliver_home_appbar.dart';

class InitialSectionsBT extends StatelessWidget {
  final Function expandingSections;
  final BldrsSection currentSection;
  final bool sectionsAreExpanded;

  InitialSectionsBT({
    @required this.expandingSections,
    @required this.currentSection,
    @required this.sectionsAreExpanded,
});

  @override
  Widget build(BuildContext context) {

    // double abPadding = Ratioz.ddAppBarMargin * 2;
    // double abHeight = Ratioz.ddAppBarHeight;
    //
    // double corners = Ratioz.ddBoxCorner *1.5;
    //
    // bool designMode = false;


    return GestureDetector(
          onTap: expandingSections,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              IntrinsicWidth(

                child: SectionButton(
                  section: currentSection,
                  sectionsAreExpanded : sectionsAreExpanded,
                ),
              ),

            ],
          ),
        );
  }
}

class SectionButton extends StatelessWidget {
  final BldrsSection section;
  final bool sectionsAreExpanded;

  SectionButton({
    @required this.section,
    @required this.sectionsAreExpanded,
});

  @override
  Widget build(BuildContext context) {

    // double screenWidth = MediaQuery.of(context).size.width;

    // double abPadding = Ratioz.ddAppBarMargin * 2;
    // double abHeight = Ratioz.ddAppBarHeight;

    double corners = Ratioz.ddBoxCorner *1.5;

    bool designMode = false;

    String buttonTitle = sectionsAreExpanded == true ? 'Choose' : 'Section' ;

    // double btThirdsOfScreenWidth = (screenWidth - (6*abPadding))/3;

    // double buttonWidth = sectionsAreExpanded == true ? btThirdsOfScreenWidth : null;

    String currentSection = sectionsAreExpanded == true ? '...             ' :
        sectionStringer(context, section);

    return Container(
      height: 40,
      // width: buttonWidth,
      // margin: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin*0.5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: BorderRadius.circular(corners),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SuperVerse(
              verse: buttonTitle,
              size: 0,
              italic: true,
              color: Colorz.Grey,
              weight: VerseWeight.thin,
              designMode: designMode,
              centered: false,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                SuperVerse(
                  verse: currentSection,
                  size: 2,
                  italic: false,
                  color: Colorz.White,
                  weight: VerseWeight.bold,
                  scaleFactor: 1,
                  designMode: designMode,
                  centered: false,
                ),

                sectionsAreExpanded == true ? Container() :
                Container(
                  color: designMode == true ? Colorz.BloodTest : null,
                  margin: EdgeInsets.only(bottom: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: WebsafeSvg.asset(superArrowENRight(context), height: 7.5),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
