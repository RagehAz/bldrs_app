import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/buttons/dream_wrapper.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog_data_row.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dashboardUserButton extends StatelessWidget {
  final double width;
  final UserModel userModel;
  final int index;
  final Function onDeleteUser;


  const dashboardUserButton({
    @required this.width,
    @required this.userModel,
    @required this.index,
    @required this.onDeleteUser,
  });
// -----------------------------------------------------------------------------
  static double height(){
    return 60;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _countryName = _countryPro .getCountryNameInCurrentLanguageByIso3(context, userModel.zone.countryID);
    String _provinceName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, userModel.zone.cityID);
    String _districtName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, userModel.zone.districtID);

    List<ContactModel> _stringyContacts = ContactModel.getContactsWithStringsFromContacts(userModel.contacts);
    List<String> _stringyContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);
    List<String> _stringyContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_stringyContacts);

    List<ContactModel> _socialContacts = ContactModel.getSocialMediaContactsFromContacts(userModel.contacts);
    List<String> _socialContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_socialContacts);
    List<String> _socialContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_socialContacts);

    SuperVerse _titleVerse(String title){
      return SuperVerse(
        verse: title,
        size: 0,
        color: Colorz.Grey80,
      );
    }


    return DreamBox(
      height: height(),
      width: width,
      icon: userModel.pic,
      color: Colorz.White20,
      verse: userModel.name,
      secondLine: '$index : ${userModel.userID}',
      verseScaleFactor: 0.6,
      verseCentered: false,
      secondLineScaleFactor: 0.9,
      margins: EdgeInsets.symmetric(vertical: 5),
      onTap: () async {

        double _clearDialogWidth = BottomDialog.dialogClearWidth(context);

        await BottomDialog.showBottomDialog(
          context: context,
          title: userModel.name,
          draggable: true,
          child: Container(
            width: _clearDialogWidth,
            height: BottomDialog.dialogClearHeight(draggable: true, titleIsOn: true, context: context,),
            color: Colorz.BloodTest,
            child: MaxBounceNavigator(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[

                  DreamBox(
                    height: 25,
                    width: 25,
                    icon: Flagz.getFlagByIso3(userModel.zone.countryID),
                    corners: 5,
                  ),

                  SuperVerse(verse: 'is admin or not ? ,, work this out please',),

                  BottomDialogRow(dataKey: 'userID', dataValue: userModel.userID),
                  BottomDialogRow(dataKey: 'authBy', dataValue: userModel.authBy),
                  BottomDialogRow(dataKey: 'createdAt', dataValue: userModel.createdAt),
                  BottomDialogRow(dataKey: 'timeString', dataValue: Timers.dayMonthYearStringer(context, userModel.createdAt)),
                  BottomDialogRow(dataKey: 'userStatus', dataValue: userModel.userStatus),
                  BottomDialogRow(dataKey: 'name', dataValue: userModel.name),
                  BottomDialogRow(dataKey: 'pic', dataValue: userModel.pic),
                  BottomDialogRow(dataKey: 'title', dataValue: userModel.title),
                  BottomDialogRow(dataKey: 'company', dataValue: userModel.company),
                  BottomDialogRow(dataKey: 'gender', dataValue: userModel.gender),
                  BottomDialogRow(dataKey: 'zone', dataValue: userModel.zone),
                  BottomDialogRow(dataKey: 'zone String', dataValue: 'in [ $_districtName ] - [ $_provinceName ] - [ $_countryName ]'),
                  BottomDialogRow(dataKey: 'language', dataValue: userModel.language),
                  BottomDialogRow(dataKey: 'position', dataValue: userModel.position),
                  BottomDialogRow(dataKey: 'contacts', dataValue: userModel.contacts),
                  BottomDialogRow(dataKey: 'Stringy contacts', dataValue: '$_stringyContactsValues'),
                  BottomDialogRow(dataKey: 'Social Contacts', dataValue: '$_socialContactsValues'),
                  BottomDialogRow(dataKey: 'myBzzIDs', dataValue: userModel.myBzzIDs),
                  BottomDialogRow(dataKey: 'emailIsVerified', dataValue: userModel.emailIsVerified),
                  // DataRow(dataKey: 'SavedFlyers', value: '${userModel.savedFlyersIDs.length} flyers')
                  // DataRow(dataKey: 'followedBzz', value: '${userModel.followedBzzIDs.length} Businesses'),

                  _titleVerse('Main Contacts'),
                  DreamWrapper(
                      boxWidth: 250,
                      boxHeight: 100,
                      verses: _stringyContactsValues,
                      icons: _stringyContactsIcons,
                      buttonHeight: 20,
                      spacing: 2.5,
                      margins: const EdgeInsets.all(2.5),
                      onTap: () async {
                        await CenterDialog.showCenterDialog(
                          context: context,
                          title: 'Contact',
                          body: '$_stringyContactsValues',
                          boolDialog: false,
                        );
                      }

                  ),

                  _titleVerse('Social Media Contacts'),
                  DreamWrapper(
                      boxWidth: 250,
                      boxHeight: 100,
                      verses: _socialContactsValues,
                      icons: _socialContactsIcons,
                      buttonHeight: 20,
                      spacing: 2.5,
                      margins: const EdgeInsets.all(2.5),
                      onTap: () async {
                        await CenterDialog.showCenterDialog(
                          context: context,
                          title: 'Contact',
                          body: '$_socialContactsValues',
                          boolDialog: false,
                        );
                      }
                  ),

                  Container(
                      width: _clearDialogWidth,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          DreamBox(
                            height: 80,
                            width: 80,
                            verse: 'Delete User',
                            verseMaxLines: 2,
                            onTap: () => onDeleteUser(userModel),
                          ),

                        ],
                      )
                  )

                ],
              ),
            ),
          ),
        );

      },
    );
  }
}
