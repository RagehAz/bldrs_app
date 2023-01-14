import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/new_user_editor.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/new_bz_editor.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/new_author_editor.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/new_flyer_editor.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/customs/super_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/animations_lab.dart';
import 'package:bldrs/x_dashboard/ui_manager/balloon_types_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/dialog_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/emojis_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/go_back_widget_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/images_test/images_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/keyboard_field_widget_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/nav_jumping_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/pdf_testing/pdf_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/poster_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/reorder_list_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/slider_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/sounds_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/static_flyer_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/stop_watch_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_rage7.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_text_test/super_text_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/video_player.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/packed_screen.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/zz_widgets/wide_button.dart';
import 'package:flutter/material.dart';

class UIManager extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UIManager({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
      pageTitle: 'UI Manager',
      listWidgets: <Widget>[

        // ------------------------------------------------

        /// GRAPHICS
        SuperHeadline(verse: Verse.plain('Graphics'),),

        /// BLDRS ICONS
        WideButton(
          verse: Verse.plain('Bldrs icons'),
          icon: Iconz.dvGouran,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const BldrsIconsScreen(),
            );

          },
        ),

        /// EMOJIS
        WideButton(
          verse: Verse.plain('Emojis'),
          icon: Iconz.emoji,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const EmojiTestScreen(),
            );

          },
        ),

        /// BALLOON TYPES
        WideButton(
          verse: Verse.plain('Balloons'),
          icon: Iconz.balloonRoundCornered,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const BalloonTypesScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// ANIMATIONS
        SuperHeadline(verse: Verse.plain('Animations'),),

        /// SUPER RAGE7
        WideButton(
          verse: Verse.plain('Super Rage7'),
          icon: Iconz.dvRageh,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SuperRage7Screen(),
            );

          },
        ),

        /// SUPER TEXT
        WideButton(
          verse: Verse.plain('Super Text Screen'),
          icon: Iconz.language,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SuperTextScreen(),
            );

          },
        ),

        /// LOCK SCREEN
        WideButton(
          verse: Verse.plain('Lock Screen'),
          icon: Iconz.password,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const LockScreen(),
            );

          },
        ),

        /// ANIMATIONS LAB
        WideButton(
          verse: Verse.plain('Animations Lab'),
          icon: Iconz.dvDonaldDuck,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const AnimationsLab(),
            );

          },
        ),

        // ------------------------------------------------

        /// IMAGES
        SuperHeadline(verse: Verse.plain('Images'),),

        /// IMAGE TEST SCREEN
        WideButton(
          verse: Verse.plain('Images testing'),
          icon: Iconz.camera,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const ImagesTestScreen(),
            );

          },
        ),

        /// POSTER TEST
        WideButton(
          verse: Verse.plain('Poster Test'),
          icon: Iconz.flyerCollection,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const PosterTestScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// SOUNDS
        SuperHeadline(verse: Verse.plain('Sounds'),),

        /// SOUNDS TEST
        WideButton(
          verse: Verse.plain('Sounds'),
          icon: Iconz.advertise,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SoundsTestScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// VIDEOS
        SuperHeadline(verse: Verse.plain('Videos'),),

        /// VIDEO EDITOR
        WideButton(
          verse: Verse.plain('Video Player'),
          icon: Iconz.play,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const VideoPlayerScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// VIDEOS
        SuperHeadline(verse: Verse.plain('PDF'),),

        /// VIDEO EDITOR
        WideButton(
          verse: Verse.plain('PDF Tested'),
          icon: Iconz.form,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const PDFTestingScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// TIME
        SuperHeadline(verse: Verse.plain('Time'),),

        /// STOP WATCH TEST
        WideButton(
          verse: Verse.plain('StopWatch test'),
          icon: Iconz.clock,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const StopWatchTest(),
            );

          },
        ),

        // ------------------------------------------------

        /// NAVIGATION
        SuperHeadline(verse: Verse.plain('Navigation'),),

        /// NAV JUMPING TEST
        WideButton(
          verse: Verse.plain('Nav Jumping test'),
          icon: Iconz.arrowUp,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const NavJumpingTestScreen(),
            );

          },
        ),

        /// GO BACK WIDGET
        WideButton(
          verse: Verse.plain('GO BACK WIDGET'),
          icon: Iconz.back,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const GoBackWidgetTest(),
            );

          },
        ),

        // ------------------------------------------------

        /// COMPONENTS
        SuperHeadline(verse: Verse.plain('Components'),),

        /// KEYBOARD FIELD TEST
        WideButton(
          verse: Verse.plain('KEYBOARD FIELD TEST'),
          icon: Iconz.language,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const KeyboardFieldWidgetTest(),
            );

          },
        ),

        /// RE-ORDER-ABLE LIST
        WideButton(
          verse: Verse.plain('RE-ORDER-ABLE LIST TEST'),
          icon: Iconz.statistics,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const ReOrderListTest(),
            );

          },
        ),

        /// STATIC FLYER TEST
        WideButton(
          verse: Verse.plain('Static Flyer test'),
          icon: Iconz.flyer,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const StaticFlyerTestScreen(),
            );

          },
        ),

        /// SLIDER TEST
        WideButton(
          verse: Verse.plain('Slider Test Screen'),
          icon: Iconz.dashBoard,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SliderTestScreen(),
            );

          },
        ),

        /// DIALOG TEST
        WideButton(
          verse: Verse.plain('Dialogs test Screen'),
          icon: Iconz.achievement,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const DialogsTestScreen(),
            );

          },
        ),

        // ------------------------------------------------

        /// NEW EDITORS
        SuperHeadline(verse: Verse.plain('New Editors'),),

        /// NEW USER EDITOR
        WideButton(
          verse: Verse.plain('New User Editor'),
          icon: Iconz.users,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: NewUserEditor(
                canGoBack: true,
                userModel: UsersProvider.proGetMyUserModel(context: context, listen: false),
                onFinish: (){},
                reAuthBeforeConfirm: false,
                validateOnStartup: true,
                // checkLastSession: true,
              ),
            );

          },
        ),

        /// NEW BZ EDITOR
        WideButton(
          verse: Verse.plain('New Bz Editor'),
          icon: Iconz.bz,
          onTap: () async {

            final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);

            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _user.myBzzIDs?.first,
            );

            await Nav.goToNewScreen(
              context: context,
              screen: NewBzEditor(
                // checkLastSession: true,
                validateOnStartup: true,
                bzModel: _bzModel,
              ),
            );

          },
        ),

        /// NEW AUTHOR EDITOR
        WideButton(
          verse: Verse.plain('New Author Editor'),
          icon: Iconz.cleopatra,
          onTap: () async {

            final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);

            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _user.myBzzIDs?.first,
            );

            await Nav.goToNewScreen(
              context: context,
              screen: NewAuthorEditor(
                bzModel: _bzModel,
                author: _bzModel.authors.first,
              ),
            );

          },
        ),

        /// NEW FLYER EDITOR
        WideButton(
          verse: Verse.plain('New Flyer Editor'),
          icon: Iconz.addFlyer,
          onTap: () async {

            final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);

            final BzModel _bzModel = await BzProtocols.fetchBz(
              context: context,
              bzID: _user.myBzzIDs?.first,
            );

            final FlyerModel _flyer = await FlyerProtocols.fetchFlyer(
              context: context,
              flyerID: _bzModel.flyersIDs.first
            );

            await Nav.goToNewScreen(
              context: context,
              screen: NewFlyerEditor(
                flyerToEdit: _flyer,
                validateOnStartup: false,
              ),
            );

          },
        ),

        // ------------------------------------------------

        /// LAYOUTS
        SuperHeadline(verse: Verse.plain('Layout'),),

        /// ZOOMABLE LAYOUT
        WideButton(
          verse: Verse.plain('New Flyer Editor'),
          icon: Iconz.addFlyer,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const PackedZoomedLayout(),
            );

          },
        ),


        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
