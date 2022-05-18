import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/contacts_bubble.dart';
import 'package:bldrs/c_controllers/g_user_controllers/user_screen_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserProfilePage({
    @required this.userModel,
    @required this.userCountry,
    @required this.userCity,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final CountryModel userCountry;
  final CityModel userCity;
  /// --------------------------------------------------------------------------
  static String generateTitleCompanyString({
    @required UserModel userModel,
    @required BuildContext context,
  }){

    String _string;

    final String _title = userModel?.title;
    final String _company = userModel.company;

    if (_title == null && _company == null){
      _string = null;
    }
    else if (_title == null && _company != null){
      _string = _company;
    }
    else if (_title != null && _company == null){
      _string = _title;
    }
    else if (_title != null && _company != null){
      _string = '$_title ${superPhrase(context, 'phid_at')} $_company';
    }
    else {
      _string = null;
    }

    return _string;
  }
// -----------------------------------------------------------------------------
  bool _canShowTitleCompanyLine(){
    bool _can = false;

    if (
    stringIsNotEmpty(userModel?.title) == true
        ||
    stringIsNotEmpty(userModel?.company) == true
    ){
    _can = true;
    }

    return _can;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _userName = userModel?.name ?? superPhrase(context, 'phid_unknown_bldr');

    final String _countryName = CountryModel.getTranslatedCountryName(
        context: context,
        countryID: userCountry?.id,
    );
    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: userCity,
    );
    final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
      context: context,
      city: userCity,
      districtID: userModel?.zone?.districtID,
    );

    final bool _thereAreMissingFields = UserModel.thereAreMissingFields(userModel);

    return Column(
      children: <Widget>[

        const SizedBox(
          width: 20,
          height: 20,
        ),

        /// USER PIC
        UserBalloon(
          size: 80,
          balloonType: userModel?.status,
          userModel: userModel,
          loading: false,
          showEditButton: _thereAreMissingFields,
          onTap: _thereAreMissingFields == false ? null
              :
          () => onEditProfileTap(context),
        ),

        /// USER NAME
        SuperVerse(
          verse: _userName,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
        ),

        /// USER JOB TITLE
        if (_canShowTitleCompanyLine() == true)
        SuperVerse(
          italic: true,
          weight: VerseWeight.thin,
          verse: generateTitleCompanyString(
              userModel: userModel,
              context: context,
          ),
        ),

        /// USER LOCALE
        SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              FlagBox(
                size: 20,
                countryID: userModel?.zone?.countryID,
              ),

              const SizedBox(
                width: 5,
                height: 5,
              ),
              SuperVerse(
                verse: '${superPhrase(context, 'phid_inn')} $_districtName, $_cityName, $_countryName',
                weight: VerseWeight.thin,
                italic: true,
                color: Colorz.grey255,
                margin: 5,
              ),
            ],
          ),
        ),

        /// JOINED AT
        SuperVerse(
          verse: Timers.getString_in_bldrs_since_month_yyyy(context, userModel?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
        ),

        /// CONTACTS
        ContactsBubble(
          contacts: userModel?.contacts,
          location: userModel?.location,
          canLaunchOnTap: true,
        ),

        /// BOTTOM PADDING
        const SizedBox(
          height: 30,
        ),

      ],
    );
  }
}
