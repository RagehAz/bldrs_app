import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'property_search_items/fields_row.dart';

class PropertySearchCriteria extends StatelessWidget {
  final Function openEnumLister;
  // final Map<String, Object> currentPropertyUse;
  // final Map<String, Object> currentPropertyType;
  // final Map<String, Object> currentPropertyContract;

  PropertySearchCriteria({
    @required this.openEnumLister,
    // @required this.currentPropertyUse,
    // @required this.currentPropertyType,
    // @required this.currentPropertyContract,
});

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width;
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

    double _boxWidth = _screenWidth - (_abPadding * 6);
    const double _boxHeight = 100 ;
    const bool _bubble = true;

    Alignment defaultAlignment =  Wordz.textDirection(context) == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;

    const double corners = Ratioz.boxCorner12;

    const bool designMode = false;

    // - ROW OF BUTTONS
    // double buttonSpacing = _abPadding;
    // double buttonsZoneWidth = (_screenWidth-(_pageMargin*4));
    // double contractTypeBtWidth = (buttonsZoneWidth - (2*buttonSpacing) - buttonSpacing)/2;


  Map<String, Object> propertyUseMap = {
    'Title' : 'Use of property',
    'Strings' : <String>['Residential', 'Commercial', 'Industrial', 'Governmental', 'Administration', 'Transportation', 'Utilities', 'Religious', 'Educational', 'Agricultural', 'Medical', 'Hotel room', 'Sports', 'Entertainment',],
    'Triggers' : <bool>[false, false, false, false, false, false, false, false, false, false, false, false, false, false],
  };

  Map<String, Object> propertyTypeMap = {
    'Title' : 'Type of property',
    'Strings' : <String>['Apartment', 'Penthouse', 'Chalet', 'TwinHouse', 'FullFloor', 'HalfFloor', 'Building', 'Land', 'Bungalow', 'Cabana', 'HotelRoom', 'Villa', 'Room', 'Office', 'Store', 'WareHouse', 'ExhibitionHall', 'MeetingRoom', 'Hostel', 'MedicalFacility',],
    'Triggers' : <bool>[false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, ],
  };

  Map<String, Object> contractTypeMap = {
    'Title' : 'Contract type of property',
    'Strings' : <String>['For Sale', 'For Rent'],
    'Triggers' : <bool>[false, false],
  };

  // Map<String, Object> propertyUse = {
  //   'Strings' : [],
  //   'Triggers' : [],
  // };

    return Container(
      width: _boxWidth,
      decoration: BoxDecoration(
          color: Colorz.WhiteAir,
          borderRadius: BorderRadius.circular(corners),
          boxShadow: <BoxShadow>[
            CustomBoxShadow(
                color: _bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                offset: new Offset(0, 0),
                blurRadius: _boxHeight * 0.15,
                blurStyle: BlurStyle.outer),
          ]),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(corners),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                // --- BOX HIGHLIGHT
                Positioned(
                  top: 0,
                  child: Container(
                    width: _boxWidth,
                    height: _boxHeight * 0.27,
                    decoration: BoxDecoration(
                      // color: Colorz.White,
                        borderRadius: BorderRadius.circular(
                            corners - (_boxHeight * 0.8) ),
                        boxShadow: <BoxShadow>[
                          CustomBoxShadow(
                              color: Colorz.WhiteZircon,
                              offset: new Offset(0, _boxWidth * -0.01),
                              blurRadius: _boxHeight * 0.2,
                              blurStyle: BlurStyle.normal),
                        ]),
                  ),
                ),

                // --- BOX GRADIENT
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: _boxWidth * 0.5,
                    width: _boxWidth,
                    decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corners),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Colorz.BlackNothing, Colorz.BlackSmoke],
                          stops: <double>[0.9, 1]),
                    ),
                  ),
                ),

                // --- SEARCH CRITERIA ROWS
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    // --- INITIAL NOTE
                    Align(
                      alignment: defaultAlignment,
                      child:
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: _pageMargin, vertical: _pageMargin * 0.5),
                        child: SuperVerse(
                          verse: 'Select your default property search criteria !',
                          centered: false,
                          designMode: designMode,
                          italic: true,
                          color: Colorz.YellowLingerie,
                          shadow: true,
                        ),
                      ),
                    ),

                    // --- PROPERTY USE
                    FieldsRow(
                      openList: () => openEnumLister(propertyUseMap),
                      title: propertyUseMap['Title'],
                      fields: propertyUseMap['Strings'],
                    ),

                    // --- PROPERTY TYPE
                    FieldsRow(
                      openList: () => openEnumLister(propertyTypeMap),
                      title: propertyTypeMap['Title'],
                      fields: propertyTypeMap['Strings'],
                    ),

                    // --- CONTRACT TYPE
                    FieldsRow(
                      openList: () => openEnumLister(contractTypeMap),
                      title: contractTypeMap['Title'],
                      fields: contractTypeMap['Strings'],
                    ),

                    // --- PROPERTY LOCATION
                    FieldsRow(
                      openList: (){print('Locale bitch');},
                      title: 'Location of property',
                      fields: ['Heliopolis', 'Cairo', 'Egypt'],
                    ),

                    // --- ADD MORE DETAILS
                    DreamBox(
                      height: 35,
                      margins: const EdgeInsets.symmetric(horizontal: _pageMargin, vertical: _pageMargin * 2),
                      color: Colorz.WhiteAir,
                      icon: Iconz.Plus,
                      iconColor: Colorz.BabyBlue,
                      iconSizeFactor: 0.5,
                      verse: 'Add more details',
                      verseColor: Colorz.BabyBlue,
                      boxFunction: (){print('3afreet enta');},
                      blackAndWhite: false,

                    ),

                  ],
                ),

              ],
            ),
          ),
        );
  }
}
