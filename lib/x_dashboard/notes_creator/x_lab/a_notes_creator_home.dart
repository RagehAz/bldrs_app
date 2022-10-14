import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_notes_creator_screen.dart';
import 'package:flutter/material.dart';

class NotesCreatorHome extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotesCreatorHome({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
    final double _buttonHeight = ((_screenHeight - Stratosphere.smallAppBarStratosphere - 40) / 4) - 10;
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: const Verse(
        text: 'Notes',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      layoutWidget: Column(
        children: <Widget>[

          const Stratosphere(),

          /// USER
          NoteHomeButton(
            height: _buttonHeight,
            icon: Iconz.normalUser,
            text: 'User',
            onTap: () => Nav.goToNewScreen(
                context: context,
                screen: const NotesCreatorScreen(),
            ),
          ),

          /// USERS
          NoteHomeButton(
            height: _buttonHeight,
            icon: Iconz.users,
            text: 'Users',
            onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const NotesCreatorScreen(),
            ),
          ),

          /// BZ
          NoteHomeButton(
            height: _buttonHeight,
            icon: Iconz.bz,
            text: 'Business',
            onTap: () => Nav.goToNewScreen(
              context: context,
              screen: const NotesCreatorScreen(),
            ),
          ),

          /// BZZ
          NoteHomeButton(
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

class NoteHomeButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteHomeButton({
    @required this.height,
    @required this.text,
    @required this.icon,
    @required this.onTap,
    Key key
  }) : super(key: key);

  final double height;
  final String text;
  final String icon;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: PageBubble.width(context),
      icon: icon,
      verse: Verse(
        text: text,
        translate: false,
        casing: Casing.upperCase,
      ),
      verseCentered: false,
      verseWeight: VerseWeight.black,
      verseItalic: true,
      iconSizeFactor: 0.8,
      onTap: onTap,
      margins: const EdgeInsets.only(bottom: 10),
    );

  }
  /// --------------------------------------------------------------------------
}
