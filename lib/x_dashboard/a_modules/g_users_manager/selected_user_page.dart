import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/y_views/g_user/b_1_user_profile_page.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/x_dashboard/a_modules/g_users_manager/users_manager_controller.dart';
import 'package:flutter/material.dart';

class SelectedUserPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectedUserPage({
    @required this.screenHeight,
    @required this.selectedUser,
    @required this.selectedUserZone,
    @required this.usersModels,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<UserModel> selectedUser;
  final ValueNotifier<ZoneModel> selectedUserZone;
  final ValueNotifier<List<UserModel>> usersModels;
  /// --------------------------------------------------------------------------
  List<Widget> _pageWidgets({
    @required BuildContext context,
    @required UserModel userModel,
    @required ZoneModel userZone,
    @required ValueNotifier<List<UserModel>> usersModels,
}){

    return <Widget>[

      Align(
        alignment: superInverseCenterAlignment(context),
        child: DreamBox(
          height: 40,
          width: 40,
          icon: Iconz.more,
          iconSizeFactor: 0.7,
          margins: 10,
          onTap: () => onSelectedUserOptions(
            context: context,
            userModel: userModel,
            usersModels: usersModels,
          ),
        ),
      ),
      
      /// PROFILE PAGE
      UserProfilePage(
        userModel: userModel,
        userCountry: userZone.countryModel,
        userCity: userZone.cityModel,
      ),

      /// USER ID
      DataStrip(
        dataKey: 'ID',
        dataValue: userModel.id,
        color: Colorz.black255,
      ),

      /// AUTH BY
      DataStrip(
        color: Colorz.black255,
        dataKey: 'AuthBy',
        dataValue: userModel.authBy,
      ),

      /// ON BLDRS DATE
      DataStrip(
        color: Colorz.black255,
        dataKey: 'on Bldrs',
        dataValue: Timers.generateString_hh_i_mm_ampm_day_dd_month_yyyy(
          context: context,
          time: userModel.createdAt,
        ),
      ),

      /// SINCE
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Since',
        dataValue: Timers.getSuperTimeDifferenceString(
          from: userModel.createdAt,
          to: DateTime.now(),
        ),
      ),

      /// STATUS
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Status',
        dataValue: UserModel.cipherUserStatus(userModel.status),
      ),

      /// GENDER
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Gender',
        dataValue: UserModel.cipherGender(userModel.gender),
      ),

      /// LANGUAGE
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Lang.',
        dataValue: userModel.language,
      ),

      /// POSITION
      DataStrip(
          color: Colorz.black255,
          dataKey: 'Loc.',
          dataValue: userModel.location
      ),

      /// BZZ IDS
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Bzz IDs',
        dataValue: userModel.myBzzIDs,
      ),

      /// EMAIL VERIFIED
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Email Verified',
        dataValue: userModel.emailIsVerified,
      ),

      /// NUMBER OF SAVED FLYERS
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Saves',
        dataValue: '${userModel.savedFlyersIDs.length} Flyers Saved',
      ),

      /// NUMBER OF FOLLOWS
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Follows',
        dataValue: '${userModel.followedBzzIDs.length} Followed Bzz',
      ),

      /// NUMBER OF BZZ
      DataStrip(
        color: Colorz.black255,
        dataKey: '# Bzz',
        dataValue: '${userModel.myBzzIDs.length} Businesses authored',
      ),

      const BubblesSeparator(),

      /// APP VERSION
      DataStrip(
        dataKey: 'App version',
        dataValue: userModel.appState.appVersion,
      ),

      /// LDB VERSION
      DataStrip(
        dataKey: 'LDB version',
        dataValue: userModel.appState.ldbVersion,
      ),

      /// PHRASES VERSION
      DataStrip(
        dataKey: 'Phrases version',
        dataValue: userModel.appState.phrasesVersion,
      ),

      /// KEYWORDS VERSION
      DataStrip(
        dataKey: 'KWs version',
        dataValue: userModel.appState.keywordsChainVersion,
      ),

      /// SPECS CHAIN VERSION
      DataStrip(
        dataKey: 'Specs version',
        dataValue: userModel.appState.specsChainVersion,
      ),

      /// SPECS CHAIN VERSION
      DataStrip(
        dataKey: 'Pickers version',
        dataValue: userModel.appState.specPickersVersion,
      ),

      const BubblesSeparator(),

      /// FCM Token
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'FCM token',
        dataValue: userModel.fcmToken?.token,
      ),

      /// FCM Token
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'FCM platform',
        dataValue: userModel.fcmToken?.platform,
      ),

      const BubblesSeparator(),

      /// IS ADMIN
      DataStrip(
        color: Colorz.white20,
        dataKey: 'is Admin',
        dataValue: userModel.isAdmin,
      ),

    ];

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('wtf');

    return PageBubble(
      appBarType: AppBarType.search,
      screenHeightWithoutSafeArea: screenHeight,
      color: Colorz.white10,
      child: ValueListenableBuilder(
        valueListenable: selectedUser,
        builder: (_, UserModel userModel, Widget child){

          if (userModel == null){
            return const SizedBox();
          }

          else {

            return ValueListenableBuilder(
                valueListenable: selectedUserZone,
                builder: (_, ZoneModel userZone, Widget child){

                  final List<Widget> _widgets = _pageWidgets(
                    context: context,
                    userModel: userModel,
                    userZone: userZone,
                    usersModels: usersModels,
                  );

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _widgets.length,
                    itemBuilder: (_, index){

                      return _widgets[index];

                    },
                  );

                }
            );

          }

        },
      ),
    );
  }
}
