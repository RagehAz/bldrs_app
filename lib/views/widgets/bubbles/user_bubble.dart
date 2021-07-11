import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/localization/localization_constants.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
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
    String _countryName = translate(context, user?.zone?.countryID);
    String _countryFlag = Flagz.getFlagByIso3(user?.zone?.countryID);
    String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, user?.zone?.provinceID);
    String _areaName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, user?.zone?.districtID);

    double screenWidth = Scale.superScreenWidth(context);
    double screenHeight = Scale.superScreenHeight(context);

    double topPadding = screenHeight * 0.05;
    double editProfileBtSize = topPadding ;

    return InPyramidsBubble(

      centered: true,
      columnChildren: <Widget>[

        Container(
          height: topPadding,
          alignment: Aligners.superInverseCenterAlignment(context),
          child: DreamBox(
            height: editProfileBtSize,
            width: editProfileBtSize,
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
          labelColor: Colorz.WhiteAir,
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
          color: Colorz.Grey,
          size: 2,
          margin: 5,
        ),

        // --- Joined at
        SuperVerse(
          verse: TextGenerator.monthYearStringer(context,user?.joinedAt),
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.Grey,
          size: 1,
        ),

        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.05,
        ),

      ],
    );
  }
}
