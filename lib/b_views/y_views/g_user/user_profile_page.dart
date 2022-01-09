import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
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
  void _switchUserStatus(UserStatus status){
    blog('status is : $status');
  }

  void _slideUserOptions({BuildContext context, UserModel userModel}){
    blog('blah blha');
  }

  void onEditProfileTap(){
    blog('edit profile');
  }

  void onUserPicTap(){
    blog('user pic tapped');
  }

  @override
  Widget build(BuildContext context) {

    final String _countryName = CountryModel.getTranslatedCountryNameByID(
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


    return Column(
      children: <Widget>[

        /// EDIT BUTTON
        Container(
          height: 30,
          alignment: Aligners.superInverseCenterAlignment(context),
          child: DreamBox(
            height: 30,
            width: 30,
            icon: Iconz.gears,
            iconSizeFactor: 0.6,
            onTap: onEditProfileTap,
          ),
        ),

        /// USER PIC
        UserBalloon(
          balloonWidth: 80,
          balloonType: userModel?.status,
          userModel: userModel,
          onTap: onUserPicTap,
          loading: false,
        ),

        /// USER NAME
        SuperVerse(
          verse: userModel?.name,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.white10,
        ),

        /// USER JOB TITLE
        SuperVerse(
          verse: '${userModel?.title} @ ${userModel?.company}',
          italic: true,
          weight: VerseWeight.thin,
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
                verse:
                '${Wordz.inn(context)} $_districtName, $_cityName, $_countryName',
                weight: VerseWeight.thin,
                italic: true,
                color: Colorz.grey255,
                margin: 5,
              ),
            ],
          ),
        ),

        /// Joined at
        SuperVerse(
          verse: Timers.monthYearStringer(context, userModel?.createdAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.grey255,
          size: 1,
        ),

        /// BOTTOM PADDING
        const SizedBox(
          height: 30,
        ),


      ],
    );
  }
}
