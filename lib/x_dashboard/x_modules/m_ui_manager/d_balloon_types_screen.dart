import 'package:bldrs/a_models/user/need_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BalloonTypesScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BalloonTypesScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const List<NeedType> _needTypes = NeedModel.needsTypes;

    return MainLayout(
      sectionButtonIsOn: false,
      pageTitleVerse: Verse.plain('Balloon Types'),
      appBarType: AppBarType.basic,
      layoutWidget: ListView(
        padding: Stratosphere.stratosphereInsets,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          ...List.generate(_needTypes.length, (index){

            final NeedType _needType = _needTypes[index];

            return Container(
              padding: Scale.superMargins(margins: 10),
              margin: Scale.superInsets(context: context, bottom: 2),
              decoration: BoxDecoration(
                color: Colorz.white10,
                borderRadius: Borderers.superBorderAll(context, 15),
              ),
              child: Row(
                children: <Widget>[

                  UserBalloon(
                    balloonTypeOverride: Balloon.concludeBalloonByNeedType(_needType),
                    userModel: UserModel.dummyUserModel(context),
                    size: 50,
                    loading: false,
                  ),

                  SuperVerse(
                    verse: Verse(
                      text: _needType.toString(),
                      translate: false,
                    ),
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
  /// --------------------------------------------------------------------------
}
