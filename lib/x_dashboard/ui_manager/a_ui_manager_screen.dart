import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/x_dashboard/a_dashboard_home/a_lock_screen/lock_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/animations_lab.dart';
import 'package:bldrs/x_dashboard/ui_manager/balloon_types_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/dialog_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/images_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/stop_watch_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/super_rage7.dart';
import 'package:bldrs/x_dashboard/ui_manager/go_back_widget_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/keyboard_field_widget_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/reorder_list_test.dart';
import 'package:bldrs/x_dashboard/ui_manager/sounds_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/static_flyer_test_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/video_player.dart';
import 'package:bldrs/x_dashboard/ui_manager/slider_test.dart';
import 'package:bldrs/x_dashboard/zz_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/ui_manager/emojis_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/bldrs_icons_screen.dart';
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

        /// SOUNDS TEST
        WideButton(
          verse: Verse.plain('Sounds'),
          icon: Iconz.play,
          onTap: () async {

            await Nav.goToNewScreen(
              context: context,
              screen: const SoundsTestScreen(),
            );

          },
        ),

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
          icon: Iconz.statistics,
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

        const Horizon(),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
