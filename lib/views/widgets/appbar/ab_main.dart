import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'bldrs_appbar.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bt_search.dart';
import 'buttons/bt_section.dart';
import 'sliver_home_appbar.dart';

class ABMain extends StatefulWidget {
  final bool searchButtonOn;
  final Function tappingLocalizer;
  final bool sectionsAreOn;

  ABMain({
    this.searchButtonOn = true,
    this.tappingLocalizer,
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
    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    // String _lastCountry = _countryPro.currentCountry;
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
        sectionsAreExpanded == true || widget.tappingLocalizer == null ? Container() :
        Padding(
          padding: EdgeInsets.all(Ratioz.ddAppBarMargin * 0.5),
          child: LocalizerButton(
            onTap: widget.tappingLocalizer,
          ),
        ),

      ],
    );

  }
}

