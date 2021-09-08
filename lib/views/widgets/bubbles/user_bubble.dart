import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/localization/localizer.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserBubble extends StatelessWidget {
  final UserModel user;
  final Function switchUserType;
  final Function editProfileBtOnTap;
  final bool loading;

  UserBubble({
    @required this.user,
    @required this.switchUserType,
    @required this.editProfileBtOnTap,
    @required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _countryName = Localizer.translate(context, user?.zone?.countryID);
    // String _countryFlag = Flagz.getFlagByIso3(user?.zone?.countryID);
    String _provinceName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, user?.zone?.cityID);
    String _areaName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, user?.zone?.districtID);

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _topPadding = _screenHeight * 0.05;
    double _editProfileBtSize = _topPadding ;

    return Bubble(

      centered: true,
      columnChildren: <Widget>[

        Container(
          height: _topPadding,
          alignment: Aligners.superInverseCenterAlignment(context),
          child: DreamBox(
            height: _editProfileBtSize,
            width: _editProfileBtSize,
            icon: Iconz.Gears,
            iconSizeFactor: 0.6,
            bubble: true,
            onTap: editProfileBtOnTap,
          ),
        ),

        UserBalloon(
          balloonWidth: 80,
          balloonType: user?.userStatus,
          // userPic: user?.pic,
          onTap: (){print(user.userID);},
          loading: loading,
        ),

        // --- USER NAME
        SuperVerse(
          verse: user?.name,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.White10,
        ),

        // --- USER JOB TITLE
        SuperVerse(
          verse: '${user?.title} @ ${user?.company}',
          size: 2,
          italic: true,
          weight: VerseWeight.thin,
        ),

        // --- USER LOCALE
        SuperVerse(
          verse: '${Wordz.inn(context)} $_areaName, $_provinceName, $_countryName',
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.Grey225,
          size: 2,
          margin: 5,
        ),

        // --- Joined at
        SuperVerse(
          verse: Timers.monthYearStringer(context,user?.joinedAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.Grey225,
          size: 1,
        ),

        SizedBox(
          width: _screenWidth,
          height: _screenHeight * 0.05,
        ),

      ],
    );
  }
}
