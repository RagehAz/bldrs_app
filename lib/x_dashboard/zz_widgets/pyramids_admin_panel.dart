import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramid_floating_button.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/x_dashboard/notes_creator/notes_creator_home.dart';
import 'package:bldrs/x_dashboard/phrase_editor/x_phrase_editor_controllers.dart';
import 'package:flutter/material.dart';

export 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class PyramidsAdminPanel extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const PyramidsAdminPanel({
    @required this.isInTransScreen,
    @required this.pyramidsAreOn,
    this.pyramidButtons,
    Key key
  }) : super(key: key);
  /// ---------------------------------------------------------------------------
  final bool isInTransScreen;
  final bool pyramidsAreOn;
  final List<Widget> pyramidButtons;
  /// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: true);

    final List<String> _phidsPendingTranslation = PhraseProvider.proGetPhidsPendingTranslation(
      context: context,
      listen: true,
    );

    final int _badgeNum = NotesProvider.proGetBadgeNum(
      context: context,
      listen: true,
    );

    if (_user?.isAdmin == true){

      return Container(
        width: Scale.screenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// EXTRA BUTTONS
              if (Mapper.checkCanLoopList(pyramidButtons) == true)
                ...List.generate(pyramidButtons.length, (index){

                  return pyramidButtons[index];

                }),

              /// TRANSLATION BUTTON
              if (Mapper.checkCanLoopList(_phidsPendingTranslation) == true)
                PyramidFloatingButton(
                  color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                  icon: Iconz.language,
                  redDotCount: _phidsPendingTranslation.length,
                  onTap: () async {

                    if (isInTransScreen == true){

                      await showPhidsPendingTranslationDialog(context);

                    }

                    else {

                      await createAPhidFast(
                        context: context,
                        verse: Verse.plain(_phidsPendingTranslation[0]),
                      );

                    }
                  },
                ),

              /// CREATE NOTES BUTTON
              if (pyramidsAreOn == true)
                PyramidFloatingButton(
                  color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                  icon: Iconz.notification,
                  redDotCount: _badgeNum,
                  onTap: () => Nav.goToNewScreen(
                    context: context,
                    screen: const NotesCreatorScreen(),
                  ),
                  onLongTap: () => NotesProvider.proRefreshBadgeNum(context),
                ),

            ],
          ),
        ),
      );

    }

    else {

      return const SizedBox();

    }

  }
/// ---------------------------------------------------------------------------
}
