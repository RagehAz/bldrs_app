import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
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

    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    double pageMargin = Ratioz.ddAppBarMargin * 2;

    double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;

    // double userStatusZoneWidth = screenWidth - pageMargin * 4;
    //
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);
    //
    // double propertyStatusBtWidth = (screenWidth - (2 * pageMargin) - (8 * abPadding)) / 3;
    // double propertyStatusBtHeight = 40;

    double boxWidth = screenWidth - (abPadding * 6);
    double boxHeight = 100 ;
    bool bubble = true;

    Alignment defaultAlignment =  getTranslated(context, 'Text_Direction') == 'ltr' ? Alignment.centerLeft : Alignment.centerRight;

    double corners = Ratioz.ddBoxCorner *1.5;

    bool designMode = false;

    // - ROW OF BUTTONS
    // double buttonSpacing = abPadding;
    // double buttonsZoneWidth = (screenWidth-(pageMargin*4));
    // double contractTypeBtWidth = (buttonsZoneWidth - (2*buttonSpacing) - buttonSpacing)/2;


  Map<String, Object> propertyUseMap = {
    'Title' : 'Use of property',
    'Strings' : ['Residential', 'Commercial', 'Industrial', 'Governmental', 'Administration', 'Transportation', 'Utilities', 'Religious', 'Educational', 'Agricultural', 'Medical', 'Hotel room', 'Sports', 'Entertainment',],
    'Triggers' : [false, false, false, false, false, false, false, false, false, false, false, false, false, false],
  };

  Map<String, Object> propertyTypeMap = {
    'Title' : 'Type of property',
    'Strings' : ['Apartment', 'Penthouse', 'Chalet', 'TwinHouse', 'FullFloor', 'HalfFloor', 'Building', 'Land', 'Bungalow', 'Cabana', 'HotelRoom', 'Villa', 'Room', 'Office', 'Store', 'WareHouse', 'ExhibitionHall', 'MeetingRoom', 'Hostel', 'MedicalFacility',],
    'Triggers' : [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, ],
  };

  Map<String, Object> contractTypeMap = {
    'Title' : 'Contract type of property',
    'Strings' : ['For Sale', 'For Rent'],
    'Triggers' : [false, false],
  };

  // Map<String, Object> propertyUse = {
  //   'Strings' : [],
  //   'Triggers' : [],
  // };

    return Container(
      width: boxWidth,
      decoration: BoxDecoration(
          color: Colorz.WhiteAir,
          borderRadius: BorderRadius.circular(corners),
          boxShadow: [
            CustomBoxShadow(
                color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                offset: new Offset(0, 0),
                blurRadius: boxHeight * 0.15,
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
                    width: boxWidth,
                    height: boxHeight * 0.27,
                    decoration: BoxDecoration(
                      // color: Colorz.White,
                        borderRadius: BorderRadius.circular(
                            corners - (boxHeight * 0.8) ),
                        boxShadow: [
                          CustomBoxShadow(
                              color: Colorz.WhiteZircon,
                              offset: new Offset(0, boxWidth * -0.01),
                              blurRadius: boxHeight * 0.2,
                              blurStyle: BlurStyle.normal),
                        ]),
                  ),
                ),

                // --- BOX GRADIENT
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: boxWidth * 0.5,
                    width: boxWidth,
                    decoration: BoxDecoration(
                      // color: Colorz.Grey,
                      borderRadius: BorderRadius.circular(corners),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colorz.BlackNothing, Colorz.BlackSmoke],
                          stops: [0.9, 1]),
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
                        padding: EdgeInsets.symmetric(horizontal: pageMargin, vertical: pageMargin * 0.5),
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
                      boxMargins: EdgeInsets.symmetric(horizontal: pageMargin, vertical: pageMargin * 2),
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
