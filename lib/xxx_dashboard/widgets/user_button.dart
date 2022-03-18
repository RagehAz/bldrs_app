import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/xxx_dashboard/b_views/c_components/dream_wrapper.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardUserButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DashboardUserButton({
    @required this.width,
    @required this.userModel,
    @required this.index,
    @required this.onDeleteUser,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double width;
  final UserModel userModel;
  final int index;
  final Function onDeleteUser;

  /// --------------------------------------------------------------------------
  static double height() {
    return 60;
  }

// -----------------------------------------------------------------------------
  static SuperVerse _titleVerse(String title) {
    return SuperVerse(
      verse: title,
      size: 0,
      color: Colorz.grey80,
    );
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _country = _zoneProvider.userCountryModel;
    final CityModel _city = _zoneProvider.userCityModel;

    final String _countryName = CountryModel.getTranslatedCountryNameByID(
        context: context,
        countryID: _country.id,
    );

    final String _cityName = CityModel.getTranslatedCityNameFromCity(
        context: context,
        city: _city,
    );

    final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
      context: context,
      city: _city,
      districtID: userModel.zone.districtID,
    );

    final List<ContactModel> _stringyContacts = ContactModel.getContactsWithStringsFromContacts(userModel.contacts);
    final List<String> _stringyContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_stringyContacts);
    final List<String> _stringyContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_stringyContacts);

    final List<ContactModel> _socialContacts = ContactModel.getSocialMediaContactsFromContacts(userModel.contacts);
    final List<String> _socialContactsValues = ContactModel.getListOfValuesFromContactsModelsList(_socialContacts);
    final List<String> _socialContactsIcons = ContactModel.getListOfIconzFromContactsModelsList(_socialContacts);

    return DreamBox(
      height: height(),
      width: width,
      icon: userModel.pic,
      color: Colorz.white20,
      verse: userModel.name,
      secondLine: '$index : ${userModel.id}',
      verseScaleFactor: 0.6,
      verseCentered: false,
      secondLineScaleFactor: 0.9,
      margins: const EdgeInsets.symmetric(vertical: 5),
      onTap: () async {
        final double _clearDialogWidth = BottomDialog.clearWidth(context);

        await BottomDialog.showBottomDialog(
          context: context,
          title: userModel.name,
          draggable: true,
          child: Container(
            width: _clearDialogWidth,
            height: BottomDialog.clearHeight(
              draggable: true,
              titleIsOn: true,
              context: context,
            ),
            color: Colorz.bloodTest,
            child: OldMaxBounceNavigator(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  DreamBox(
                    height: 25,
                    width: 25,
                    icon: Flag.getFlagIconByCountryID(userModel.zone.countryID),
                    corners: 5,
                  ),

                  const SuperVerse(
                    verse: 'is admin or not ? ,, work this out please',
                  ),

                  DataStripWithHeadline(dataKey: 'userID', dataValue: userModel.id),
                  DataStripWithHeadline(dataKey: 'authBy', dataValue: userModel.authBy),
                  DataStripWithHeadline(
                      dataKey: 'createdAt', dataValue: userModel.createdAt),
                  DataStripWithHeadline(
                      dataKey: 'timeString',
                      dataValue: Timers.dayMonthYearStringer(
                          context, userModel.createdAt)),
                  DataStripWithHeadline(dataKey: 'userStatus', dataValue: userModel.status),
                  DataStripWithHeadline(dataKey: 'name', dataValue: userModel.name),
                  DataStripWithHeadline(dataKey: 'pic', dataValue: userModel.pic),
                  DataStripWithHeadline(dataKey: 'title', dataValue: userModel.title),
                  DataStripWithHeadline(dataKey: 'company', dataValue: userModel.company),
                  DataStripWithHeadline(dataKey: 'gender', dataValue: userModel.gender),
                  DataStripWithHeadline(dataKey: 'zone', dataValue: userModel.zone),
                  DataStripWithHeadline(
                      dataKey: 'zone String',
                      dataValue:
                          'in [ $_districtName ] - [ $_cityName ] - [ $_countryName ]'),
                  DataStripWithHeadline(dataKey: 'language', dataValue: userModel.language),
                  DataStripWithHeadline(dataKey: 'position', dataValue: userModel.position),
                  DataStripWithHeadline(dataKey: 'contacts', dataValue: userModel.contacts),
                  DataStripWithHeadline(
                      dataKey: 'Stringy contacts',
                      dataValue: '$_stringyContactsValues'),
                  DataStripWithHeadline(
                      dataKey: 'Social Contacts',
                      dataValue: '$_socialContactsValues'),
                  DataStripWithHeadline(dataKey: 'myBzzIDs', dataValue: userModel.myBzzIDs),
                  DataStripWithHeadline(
                      dataKey: 'emailIsVerified',
                      dataValue: userModel.emailIsVerified),
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
                        );
                      }),

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
                        );
                      }),

                  SizedBox(
                      width: _clearDialogWidth,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DreamBox(
                            height: 80,
                            width: 80,
                            verse: 'Delete User',
                            verseMaxLines: 2,
                            onTap: () => onDeleteUser(userModel),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
