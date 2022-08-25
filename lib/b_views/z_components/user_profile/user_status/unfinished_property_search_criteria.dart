import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/unfinished_fields_row.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

class PropertySearchCriteria extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PropertySearchCriteria({
    @required this.openEnumLister,
    // @required this.currentPropertyUse,
    // @required this.currentPropertyType,
    // @required this.currentPropertyContract,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function openEnumLister;
  // final Map<String, Object> currentPropertyUse;
  // final Map<String, Object> currentPropertyType;
  // final Map<String, Object> currentPropertyContract;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    const double _pageMargin = Ratioz.appBarMargin * 2;

    const double _abPadding = Ratioz.appBarMargin;
    // double abHeight = _screenWidth * 0.25;

    // double userStatusZoneWidth = _screenWidth - _pageMargin * 4;
    //
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * _abPadding);
    //
    // double propertyStatusBtWidth = (_screenWidth - (2 * _pageMargin) - (8 * _abPadding)) / 3;
    // double propertyStatusBtHeight = 40;

    final double _boxWidth = _screenWidth - (_abPadding * 6);
    const double _boxHeight = 100;
    const bool _bubble = true;

    final Alignment defaultAlignment = Words.textDirection(context) == 'ltr'
        ? Alignment.centerLeft
        : Alignment.centerRight;

    const double corners = Ratioz.boxCorner12;

    // - ROW OF BUTTONS
    // double buttonSpacing = _abPadding;
    // double buttonsZoneWidth = (_screenWidth-(_pageMargin*4));
    // double contractTypeBtWidth = (buttonsZoneWidth - (2*buttonSpacing) - buttonSpacing)/2;

    const Map<String, Object> propertyUseMap = <String, Object>{
      'Title': 'Use of property',
      'Strings': <String>[
        'Residential',
        'Commercial',
        'Industrial',
        'Governmental',
        'Administration',
        'Transportation',
        'Utilities',
        'Religious',
        'Educational',
        'Agricultural',
        'Medical',
        'Hotel room',
        'Sports',
        'Entertainment',
      ],
      'Triggers': <bool>[
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ],
    };

    const Map<String, Object> propertyTypeMap = <String, Object>{
      'Title': 'Type of property',
      'Strings': <String>[
        'Apartment',
        'Penthouse',
        'Chalet',
        'TwinHouse',
        'FullFloor',
        'HalfFloor',
        'Building',
        'Land',
        'Bungalow',
        'Cabana',
        'HotelRoom',
        'Villa',
        'Room',
        'Office',
        'Store',
        'WareHouse',
        'ExhibitionHall',
        'MeetingRoom',
        'Hostel',
        'MedicalFacility',
      ],
      'Triggers': <bool>[
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
    };

    const Map<String, Object> contractTypeMap = <String, Object>{
      'Title': 'Contract type of property',
      'Strings': <String>['For Sale', 'For Rent'],
      'Triggers': <bool>[false, false],
    };

    // Map<String, Object> propertyUse = {
    //   'Strings' : [],
    //   'Triggers' : [],
    // };

    return Container(
      width: _boxWidth,
      decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: BorderRadius.circular(corners),
          boxShadow: const <BoxShadow>[
            CustomBoxShadow(
                color: _bubble == true ? Colorz.black200 : Colorz.nothing,
                blurRadius: _boxHeight * 0.15,
                style: BlurStyle.outer),
          ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(corners),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            /// --- BOX HIGHLIGHT
            Positioned(
              top: 0,
              child: Container(
                width: _boxWidth,
                height: _boxHeight * 0.27,
                decoration: BoxDecoration(
                    // color: Colorz.White,
                    borderRadius:
                        BorderRadius.circular(corners - (_boxHeight * 0.8)),
                    boxShadow: <BoxShadow>[
                      CustomBoxShadow(
                          color: Colorz.white50,
                          offset: Offset(0, _boxWidth * -0.01),
                          blurRadius: _boxHeight * 0.2),
                    ],
                ),
              ),
            ),

            /// --- BOX GRADIENT
            Positioned(
              bottom: 0,
              child: Container(
                height: _boxWidth * 0.5,
                width: _boxWidth,
                decoration: BoxDecoration(
                  // color: Colorz.Grey,
                  borderRadius: BorderRadius.circular(corners),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colorz.black0, Colorz.black80],
                      stops: <double>[0.9, 1]),
                ),
              ),
            ),

            /// --- SEARCH CRITERIA ROWS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// --- INITIAL NOTE
                Align(
                  alignment: defaultAlignment,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _pageMargin,
                        vertical: _pageMargin * 0.5,
                    ),
                    child: SuperVerse(
                      verse: '##Select your default property search criteria !',
                      centered: false,
                      italic: true,
                      color: Colorz.yellow200,
                      shadow: true,
                    ),
                  ),
                ),

                /// --- PROPERTY USE
                FieldsRow(
                  openList: () => openEnumLister(propertyUseMap),
                  title: propertyUseMap['Title'],
                  fields: propertyUseMap['Strings'],
                ),

                /// --- PROPERTY TYPE
                FieldsRow(
                  openList: () => openEnumLister(propertyTypeMap),
                  title: propertyTypeMap['Title'],
                  fields: propertyTypeMap['Strings'],
                ),

                /// --- CONTRACT TYPE
                FieldsRow(
                  openList: () => openEnumLister(contractTypeMap),
                  title: contractTypeMap['Title'],
                  fields: contractTypeMap['Strings'],
                ),

                /// --- PROPERTY LOCATION
                FieldsRow(
                  openList: () {
                    blog('Locale bitch');
                  },
                  title: 'Location of property',
                  fields: const <String>['Heliopolis', 'Cairo', 'Egypt'],
                ),

                /// --- ADD MORE DETAILS
                DreamBox(
                  height: 35,
                  margins: const EdgeInsets.symmetric(
                      horizontal: _pageMargin, vertical: _pageMargin * 2),
                  color: Colorz.white10,
                  icon: Iconz.plus,
                  iconColor: Colorz.blue255,
                  iconSizeFactor: 0.5,
                  verse: '##Add more details',
                  verseColor: Colorz.blue255,
                  onTap: () {
                    blog('3afreet enta');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
