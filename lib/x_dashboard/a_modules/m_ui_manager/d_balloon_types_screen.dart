import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BalloonTypesScreen extends StatelessWidget {

  const BalloonTypesScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const List<UserStatus> _balloonTypes = UserModel.userStatuses;

    return MainLayout(
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      pageTitle: 'Balloon Types',
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        padding: Stratosphere.stratosphereInsets,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          ...List.generate(_balloonTypes.length, (index){

            final UserStatus _balloonType = _balloonTypes[index];

            return Container(
              padding: superMargins(margins: 10),
              margin: superInsets(context: context, enBottom: 2),
              decoration: BoxDecoration(
                color: Colorz.white10,
                borderRadius: superBorderAll(context, 15),
              ),
              child: Row(
                children: <Widget>[

                  UserBalloon(
                    balloonType: _balloonType,
                    userModel: UserModel.dummyUserModel(context),
                    size: 50,
                    loading: false,
                  ),

                  SuperVerse(
                    verse: _balloonType.toString(),
                    margin: 10,
                  ),

                ],
              ),
            );

          }),

        ],
      ),
    );

  }
}
