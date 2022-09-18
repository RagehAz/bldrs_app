import 'package:bldrs/a_models/user/user_project.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/b_mission_editor_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class UserMissionPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserMissionPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel _userModel = UsersProvider.proGetMyUserModel(
    //   context: context,
    //   listen: true,
    // );

    final MissionModel dummyMission = MissionModel.dummyMission(context);

    return PageBubble(
      screenHeightWithoutSafeArea: Scale.superScreenHeight(context) - Ratioz.horizon * 2,
      appBarType: AppBarType.basic,
      color: Colorz.white10,
      childrenAlignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        // padding: Stratosphere.stratosphereSandwich,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// TITLE
            const SuperVerse(
              verse: Verse(
                text: 'phid_my_mission',
                translate: true,
              ),
              size: 3,
            ),

            /// MISSION TYPE
            SuperVerse(
                verse: Verse(
                  text: MissionModel.getMissionTypePhid(dummyMission.missionType),
                  translate: true,
                ),
            ),

            DreamBox(
              height: 50,
              verse: const Verse(
                text: 'phid_edit_mission',
                translate: true,
              ),
              onTap: () async {

                await Nav.goToNewScreen(
                  context: context,
                  screen: const MissionEditorScreen(),
                );

              },
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
