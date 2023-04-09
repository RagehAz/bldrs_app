import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

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
      title: Verse.plain('Balloon Types'),
      appBarType: AppBarType.basic,
      child: ListView(
        padding: Stratosphere.stratosphereInsets,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[

          ...List.generate(_needTypes.length, (index){

            final NeedType _needType = _needTypes[index];

            return Container(
              padding: Scale.constantMarginsAll10,
              margin: const EdgeInsets.only(bottom: 2),
              decoration: const BoxDecoration(
                color: Colorz.white10,
                borderRadius: Borderers.constantCornersAll15,
              ),
              child: Row(
                children: <Widget>[

                  UserBalloon(
                    balloonTypeOverride: Balloon.concludeBalloonByNeedType(_needType),
                    userModel: UserModel.dummyUserModel(context),
                    size: 50,
                    loading: false,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      /// NEED NAME
                      BldrsText(
                        verse: Verse(
                          id: _needType.toString(),
                          translate: false,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colorz.yellow255,
                      ),

                      /// BALLOON NAME
                      BldrsText(
                        verse: Verse(
                          id: Balloon.concludeBalloonByNeedType(_needType).toString(),
                          translate: false,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        size: 1,
                        italic: true,
                        weight: VerseWeight.thin,
                        color: Colorz.white200,
                      ),

                    ],
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
