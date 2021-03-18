import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'ab_strip.dart';
import 'buttons/bt_localizer.dart';
import 'buttons/bt_search.dart';
import 'buttons/bt_section.dart';

class ABMain extends StatefulWidget {
  final bool searchButtonOn;
  final Function tappingLocalizer;
  /// either the button itself is there or not
  final bool sectionsAreOn;
  final Function expandingSections;
  final AppBarType currentAppBarType;

  ABMain({
    this.searchButtonOn = true,
    this.tappingLocalizer,
    this.sectionsAreOn = true,
    @required this.expandingSections,
    @required this.currentAppBarType,
  });

  @override
  _ABMainState createState() => _ABMainState();
}

class _ABMainState extends State<ABMain> {
  bool _sectionsAreExpanded;
  BldrsSection _currentSection;
// ---------------------------------------------------------------------------
  @override
  void initState() {
    _currentSection = BldrsSection.Home;
    _sectionsAreExpanded = false;
    super.initState();
  }
// ---------------------------------------------------------------------------
  void _expandingSections() {
    setState(() {
      _sectionsAreExpanded = !_sectionsAreExpanded;
    });
    widget.expandingSections(_sectionsAreExpanded);
  }
// ---------------------------------------------------------------------------
  void _choosingSection(BldrsSection section) {
    setState(() {
      _currentSection = section;
      _sectionsAreExpanded = false;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    // String _lastCountry = _countryPro.currentCountry;
    double _abPadding = Ratioz.ddAppBarPadding;
    double _abHeight = _sectionsAreExpanded == true ?
    (Ratioz.ddAppBarHeight * 4) - (_abPadding * 3) : Ratioz.ddAppBarHeight;

    return ABStrip(
      abHeight: _abHeight,
      appBarType: widget.currentAppBarType,
      scrollable: false,
      rowWidgets: <Widget>[
        // --- SEARCH BUTTON
        widget.searchButtonOn == true ?
        BtSearch(
          btSearchIsBackBt: _sectionsAreExpanded == true ? true : false,
          tappingBack: _expandingSections,
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
                expandingSections: _expandingSections,
                currentSection: _currentSection,
                sectionsAreExpanded: _sectionsAreExpanded,
              ),
            ),

            // --- SECTIONS BUTTONS
            _sectionsAreExpanded == false ? Container() :
            Container(
              // color: Colorz.BloodTest,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Divider(height: _abPadding,),

                  SectionButton(
                    section: BldrsSection.RealEstate,
                    choosingSection: _choosingSection,
                  ),

                  Divider(height: _abPadding,),

                  SectionButton(
                    section: BldrsSection.Construction,
                    choosingSection: _choosingSection,
                  ),

                  Divider(height: _abPadding,),

                  SectionButton(
                    section: BldrsSection.Supplies,
                    choosingSection: _choosingSection,
                  ),

                ],
              ),
            ),

          ],
        ),

        // --- FILLER SPACE BETWEEN ITEMS
        _sectionsAreExpanded == true ? Container() :
        Expanded(
          child: Container(),
        ),

        // --- LOCALIZER BUTTON
        _sectionsAreExpanded == true || widget.tappingLocalizer == null ? Container() :
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

