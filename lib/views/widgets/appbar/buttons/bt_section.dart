import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

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

    double _corners = Ratioz.ddBoxCorner12;

    bool _designMode = false;

    String _buttonTitle = sectionsAreExpanded == true ? Wordz.choose(context) : Wordz.section(context) ;

    // double _btThirdsOfScreenWidth = (_screenWidth - (6*_abPadding))/3;

    // double _buttonWidth = _sectionsAreExpanded == true ? _btThirdsOfScreenWidth : null;

    String _currentSection = sectionsAreExpanded == true ? '...             ' :
    sectionStringer(context, currentSection);

    return GestureDetector(
          onTap: expandingSections,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              IntrinsicWidth(

                child: Container(
                  height: 40,
                  // width: buttonWidth,
                  // margin: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin*0.5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colorz.WhiteAir,
                    borderRadius: BorderRadius.circular(_corners),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[

                            SuperVerse(
                              verse: _currentSection,
                              size: 1,
                              italic: false,
                              color: Colorz.White,
                              weight: VerseWeight.bold,
                              scaleFactor: 1,
                              designMode: _designMode,
                              centered: false,
                            ),

                            sectionsAreExpanded == true ? Container() :
                            Container(
                              color: _designMode == true ? Colorz.BloodTest : null,
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
                ),
              ),

            ],
          ),
        );
  }
}

class SectionButton extends StatelessWidget {
  final Function choosingSection;
  final BldrsSection section;

  SectionButton({
    @required this.choosingSection,
    @required this.section,
  });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = superScreenWidth(context);

    double _abPadding = Ratioz.ddAppBarPadding;

    double _corners = Ratioz.ddBoxCorner12;

    bool _designMode = false;

    double _buttonWidth = (_screenWidth - (2*Ratioz.ddAppBarMargin) - (3*_abPadding) - 40) * 1;

    String _sectionString =
    section == BldrsSection.RealEstate ? Wordz.realEstate(context) :
    section == BldrsSection.Construction ? Wordz.construction(context) :
    section == BldrsSection.Supplies ? Wordz.supplies(context) :
    Wordz.bldrsShortName(context);

    String _description =
    section == BldrsSection.RealEstate ? Wordz.realEstateTagLine(context) :
    section == BldrsSection.Construction ? Wordz.constructionTagLine(context) :
    section == BldrsSection.Supplies ? Wordz.suppliesTagLine(context) :
    Wordz.bldrsShortName(context);

    return GestureDetector(
      onTap: () => choosingSection(section),
      child: IntrinsicWidth(
        child: Container(
          height: 40,
          width: _buttonWidth,
          // margin: EdgeInsets.symmetric(horizontal: Ratioz.ddAppBarMargin * 0.5),
          alignment: superCenterAlignment(context),
          decoration: BoxDecoration(
            color: Colorz.WhiteAir,
            borderRadius: BorderRadius.circular(_corners),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SuperVerse(
                  verse: _sectionString,
                  size: 2,
                  italic: false,
                  color: Colorz.White,
                  weight: VerseWeight.bold,
                  scaleFactor: 1,
                  designMode: _designMode,
                  centered: false,
                  maxLines: 1,
                ),
                SuperVerse(
                  verse: _description,
                  size: 1,
                  italic: true,
                  color: Colorz.WhiteLingerie,
                  centered: false,
                  weight: VerseWeight.thin,
                  designMode: _designMode,
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
