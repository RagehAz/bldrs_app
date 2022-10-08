import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/page_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/e_users_manager/x_users_manager_controller.dart';
import 'package:flutter/material.dart';

class SelectedUserPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectedUserPage({
    @required this.screenHeight,
    @required this.selectedUser,
    @required this.usersModels,
    @required this.pageController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double screenHeight;
  final ValueNotifier<UserModel> selectedUser;
  final ValueNotifier<List<UserModel>> usersModels;
  final PageController pageController;
  /// --------------------------------------------------------------------------
  List<Widget> _pageWidgets({
    @required BuildContext context,
    @required UserModel userModel,
    @required ValueNotifier<List<UserModel>> usersModels,
  }){

    return <Widget>[

      Align(
        alignment: Aligners.superInverseCenterAlignment(context),
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
            selectedUserModel: selectedUser,
            pageController: pageController,
          ),
        ),
      ),

      /// PROFILE PAGE
      UserProfileBanners(
        userModel: userModel,
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
        dataValue: Timers.calculateSuperTimeDifferenceString(
          from: userModel.createdAt,
          to: DateTime.now(),
        ),
      ),

      /// NEED TYPE
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Need type',
        dataValue: NeedModel.cipherNeedType(userModel.need?.needType),
      ),

      /// NEED NOTES
      DataStrip(
        color: Colorz.black255,
        dataKey: 'need notes',
        dataValue: userModel.need?.notes,
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

      /// NUMBER OF BZZ
      DataStrip(
        color: Colorz.black255,
        dataKey: 'Image URL',
        dataValue: userModel.pic,
      ),

      const DotSeparator(),

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

      /// CHAINS VERSION
      DataStrip(
        dataKey: 'Chains version',
        dataValue: userModel.appState.chainsVersion,
      ),

      /// SPECS CHAIN VERSION
      DataStrip(
        dataKey: 'Pickers version',
        dataValue: userModel.appState.pickersVersion,
      ),

      const DotSeparator(),

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

      const DotSeparator(),

      /// IS ADMIN
      TileBubble(
        bubbleWidth: PageBubble.clearWidth(context),
        bubbleHeaderVM: BubbleHeaderVM(
          hasSwitch: true,
          switchValue: userModel.isAdmin,
          headlineVerse: const Verse(
            text: 'is Admin',
            translate: false,
          ),
          onSwitchTap: (bool value) async {

            final bool _continue = await Dialogs.confirmProceed(
              context: context,
              titleVerse: const Verse(
                text: 'Are you sure ?',
                translate: false,
              ),
              bodyVerse: Verse(
                text: value == true ? '${userModel.name} will become an Admin' : '${userModel.name} will be removed from admins',
                translate: false,
              ),
            );

            if (_continue == true){

              await Future.wait(<Future>[

                Fire.updateDocField(
                  context: context,
                  collName: FireColl.users,
                  docName: userModel.id,
                  field: 'isAdmin',
                  input: value,
                ),

                if (value == true)
                NoteFireOps.createNote(
                  context: context,
                  noteModel: NoteModel.quickUserNotice(
                    userID: userModel.id,
                    title: 'Use these sacred words to go to the way beyond',
                    body: '[ Rage7 ] - [ sees ] - [ planet ]',
                  ),
                ),

              ]);

            }

          },
        ),
      ),

    ];

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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

            final List<Widget> _widgets = _pageWidgets(
              context: context,
              userModel: userModel,
              usersModels: usersModels,
            );

            return SizedBox(
              width: PageBubble.width(context),
              height: PageBubble.height(appBarType: AppBarType.search, context: context, screenHeight: screenHeight),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _widgets.length,
                itemBuilder: (_, index){

                  return _widgets[index];

                },
              ),
            );

          }

        },
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
