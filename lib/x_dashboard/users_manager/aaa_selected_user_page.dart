import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/z_components/banners/a_user_profile_banners.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/c_protocols/note_protocols/fire/note_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/users_manager/x_users_manager_controller.dart';
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
  Widget headline(String text){
    return SuperVerse(
      verse: Verse.plain(text),
      size: 4,
      centered: false,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      italic: true,
      labelColor: Colorz.white10,
    );
  }
  // --------------------
  List<Widget> _pageWidgets({
    @required BuildContext context,
    @required UserModel userModel,
    @required ValueNotifier<List<UserModel>> usersModels,
  }){

    return <Widget>[

      // -----------------------------------

      /// IS ADMIN
      TileBubble(
        bubbleWidth: PageBubble.width(context),
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
                  collName: FireColl.users,
                  docName: userModel.id,
                  field: 'isAdmin',
                  input: value,
                ),


                if (value == true)
                  NoteFireOps.createNote(
                    noteModel: NoteModel.quickUserNotice(
                      userID: userModel.id,
                      title: 'Use these sacred words to go to the way beyond',
                      body: '[ Rage7 ] - [ sees ] - [ planet ]',
                    ),
                  ),

              ]);

            }

          },
          hasMoreButton: true,
          onMoreButtonTap: () => onSelectedUserOptions(
            context: context,
            userModel: userModel,
            usersModels: usersModels,
            selectedUserModel: selectedUser,
            pageController: pageController,
          ),
        ),
      ),

      // -----------------------------------

      /// PROFILE PAGE
      UserProfileBanners(
        userModel: userModel,
      ),

      // -----------------------------------

      headline('Main'),

      /// NAME
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Name',
        dataValue: userModel.name,
      ),

      /// TRIGRAM
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Name',
        dataValue: userModel.trigram,
      ),

      /// GENDER
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Gender',
        dataValue: UserModel.cipherGender(userModel.gender),
      ),

      /// LANGUAGE
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Lang.',
        dataValue: userModel.language,
      ),

      /// PIC URL
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Pic URL',
        dataValue: userModel.picPath,
      ),

      // -----------------------------------

      headline('Work'),

      /// COMPANY
      DataStrip(
        color: Colorz.green50,
        dataKey: 'Company',
        dataValue: userModel.company,
      ),

      /// TITLE
      DataStrip(
        color: Colorz.green50,
        dataKey: 'Title',
        dataValue: userModel.title,
      ),


      // -----------------------------------

      headline('GeoLocation'),

      /// ZONE
      DataStrip(
        color: Colorz.blue80,
        dataKey: 'Zone',
        dataValue: '${userModel.zone.districtName} : ${userModel.zone.cityName} : ${userModel.zone.countryName}',
      ),

      /// LOCATION
      DataStrip(
          color: Colorz.blue80,
          dataKey: 'Loc.',
          dataValue: userModel.location
      ),

      // -----------------------------------

      headline('Needs'),

      /// NEED TYPE
      DataStrip(
        color: Colorz.yellow50,
        dataKey: 'Need type',
        dataValue: NeedModel.cipherNeedType(userModel.need?.needType),
      ),

      /// NEED NOTES
      DataStrip(
        color: Colorz.yellow50,
        dataKey: 'need notes',
        dataValue: userModel.need?.notes,
      ),

      // -----------------------------------

      headline('Auth'),

      /// USER ID
      DataStrip(
        dataKey: 'ID',
        dataValue: userModel.id,
        color: Colorz.black50,
      ),

      /// AUTH BY
      DataStrip(
        color: Colorz.black50,
        dataKey: 'AuthBy',
        dataValue: userModel.authBy,
      ),

      /// ON BLDRS DATE
      DataStrip(
        color: Colorz.black50,
        dataKey: 'on Bldrs',
        dataValue: Timers.generateString_hh_i_mm_ampm_day_dd_month_yyyy(
          context: context,
          time: userModel.createdAt,
        ),
      ),

      /// SINCE
      DataStrip(
        color: Colorz.black50,
        dataKey: 'Since',
        dataValue: Timers.calculateSuperTimeDifferenceString(
          context: context,
          from: userModel.createdAt,
          to: DateTime.now(),
        ),
      ),

      /// EMAIL VERIFIED
      DataStrip(
        color: Colorz.black50,
        dataKey: 'Email Verified',
        dataValue: userModel.emailIsVerified,
      ),

      // -----------------------------------

      headline('Contacts'),

      /// CONTACTS
      ...List.generate(userModel.contacts.length, (index){

        final ContactModel contact = userModel.contacts[index];

        return DataStrip(
          dataKey: Verse.transBake(
              context,
              ContactModel.getContactTypePhid(
                  context: context,
                  contactType: contact.type
              )
          ),
          dataValue: contact.value,
          color: Colorz.red50,
        );


      }),

      // -----------------------------------

      headline('Authorship'),

      /// NUMBER OF BZZ
      DataStrip(
        color: Colorz.blue125,
        dataKey: '# Bzz',
        dataValue: '${userModel.myBzzIDs.length} Businesses authored',
      ),

      /// BZZ IDS
      DataStrip(
        color: Colorz.blue125,
        dataKey: 'Bzz IDs',
        dataValue: userModel.myBzzIDs,
      ),

      // -----------------------------------

      headline('Saved flyers'),

      /// NUMBER OF SAVED FLYERS
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Saves',
        dataValue: '${userModel.savedFlyers.all.length} Flyers Saved',
      ),

      // -----------------------------------

      headline('Follows'),

      /// NUMBER OF FOLLOWS
      DataStrip(
        color: Colorz.white50,
        dataKey: 'Follows',
        dataValue: '${userModel.followedBzzIDs.length} Followed Bzz',
      ),

      // -----------------------------------

      headline('App state'),

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

      /// PICKERS VERSION
      DataStrip(
        dataKey: 'Pickers version',
        dataValue: userModel.appState.pickersVersion,
      ),

      /// APP CONTROLS VERSION
      DataStrip(
        dataKey: 'App controls version',
        dataValue: userModel.appState.appControlsVersion,
      ),

      // -----------------------------------

      headline('Device'),

      /// DEVICE ID
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'Device ID',
        dataValue: userModel.device?.id,
      ),

      /// DEVICE NAME
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'Device name',
        dataValue: userModel.device?.name,
      ),

      /// DEVICE PLATFORM
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'Platform',
        dataValue: userModel.device?.platform,
      ),

      /// DEVICE FCM TOKEN
      DataStrip(
        color: Colorz.yellow125,
        dataKey: 'FCM Token',
        dataValue: userModel.device?.token,
      ),

      // -----------------------------------

      headline('FCM TOPICS'),

      /// BLOCKED FCM Topics
      DataStrip(
        color: Colorz.black255,
        dataKey: 'FCM Topics count',
        dataValue: userModel.fcmTopics.length,
      ),

      /// FCM Blocked Topics
      DataStrip(
        color: Colorz.black255,
        dataKey: 'FCM Topics',
        dataValue: userModel.fcmTopics,
      ),

      // -----------------------------------

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
