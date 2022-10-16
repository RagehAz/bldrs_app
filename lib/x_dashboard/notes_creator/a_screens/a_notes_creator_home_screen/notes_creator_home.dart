import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/a_notes_creator_screen.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/a_notes_creator_home_screen/notes_creator_home_button.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/x_lab/a_notes_lab_home.dart';
import 'package:flutter/material.dart';

class NotesCreatorHome extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotesCreatorHome({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _buttonHeight = (_screenHeight - Stratosphere.smallAppBarStratosphere - 40 - Ratioz.horizon) / 4;
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: const Verse(
        text: 'Send Note to',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// NOTES LAB
        AppBarButton(
          // verse: Verse.plain('Templates'),
          icon: Iconz.lab,
          onTap: () => Nav.goToNewScreen(
            context: context,
            screen: const NotesLabHome(),
          ),
        ),

      ],
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          /// USER
          NotesCreatorHomeButton(
            height: _buttonHeight,
            icon: Iconz.normalUser,
            text: 'User',
            onTap: () => Nav.goToNewScreen(
                context: context,
                screen: const NotesCreatorScreen(),
            ),
          ),

          /// USERS
          NotesCreatorHomeButton(
            height: _buttonHeight,
            icon: Iconz.users,
            text: 'Users',
            onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const NotesCreatorScreen(),
            ),
          ),

          /// BZ
          NotesCreatorHomeButton(
            height: _buttonHeight,
            icon: Iconz.bz,
            text: 'Business',
            onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const NotesCreatorScreen(),
            ),
          ),

          /// BZZ
          NotesCreatorHomeButton(
            height: _buttonHeight,
            icon: Iconz.sphinx,
            text: 'Businesses',
            onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const NotesCreatorScreen(),
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
