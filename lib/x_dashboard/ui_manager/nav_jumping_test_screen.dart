import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:flutter/material.dart';

class NavJumpingTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NavJumpingTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<NavJumpingTestScreen> createState() => _NavJumpingTestScreenState();
  /// --------------------------------------------------------------------------
}

class _NavJumpingTestScreenState extends State<NavJumpingTestScreen> {
  // -----------------------------------------------------------------------------
  bool _canStartFromHomeScreen = false;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        id: 'Nav Jumping Test Screen',
        translate: false,
      ),
      skyType: SkyType.black,
      child: ListView(
        padding: Stratosphere.stratosphereSandwich,
        children: <Widget>[

          /// START FROM HOME SCREEN SWITCH
          BldrsTileBubble(
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              headlineVerse: Verse.plain('Start from Home Screen'),
              hasSwitch: true,
              switchValue: _canStartFromHomeScreen,
              onSwitchTap: (bool value){
                setState(() {
                  _canStartFromHomeScreen = value;
                });
              }
            ),
          ),

          /// MY BZ
          WideButton(
            verse: Verse.plain('jump To My First Bz'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.myBzFlyersPage,
                arguments: _userModel.myBzzIDs.first,
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

          /// MY BZ NOTES
          WideButton(
            verse: Verse.plain('jump To My First Bz NOTES PAGE'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.myBzNotesPage,
                arguments: _userModel.myBzzIDs.first,
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

          /// USER PREVIEW
          WideButton(
            verse: Verse.plain('jump To User Preview'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.userPreview,
                arguments: AuthFireOps.superUserID(),
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

          /// BZ PREVIEW
          WideButton(
            verse: Verse.plain('jump To Bz Preview'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.bzPreview,
                arguments: _userModel.myBzzIDs.first,
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

          /// FLYER PREVIEW
          WideButton(
            verse: Verse.plain('jump To Flyer Preview'),
            onTap: () async {

              final BzModel _bzModel = await BzProtocols.fetchBz(
                context: context,
                bzID: _userModel.myBzzIDs.first,
              );

              if (_bzModel != null){

                await BldrsNav.autoNav(
                  context: context,
                  routeName: Routing.flyerPreview,
                  arguments: _bzModel.flyersIDs.first,
                  startFromHome: _canStartFromHomeScreen,
                );

              }

            },
          ),

          /// MY USER SCREEN
          WideButton(
            verse: Verse.plain('jump To My User Screen'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.myUserScreen,
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

          /// MY USER NOTES PAGE
          WideButton(
            verse: Verse.plain('jump To My User NOTES PAGE'),
            onTap: () async {

              await BldrsNav.autoNav(
                context: context,
                routeName: Routing.myUserNotesPage,
                startFromHome: _canStartFromHomeScreen,
              );

            },
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
