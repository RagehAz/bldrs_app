import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/x_phrase_editor_controllers.dart';
import 'package:bldrs/x_dashboard/notes_creator/a_screens/a_notes_creator_home_screen/notes_creator_home.dart';
import 'package:flutter/material.dart';

export 'package:bldrs/b_views/z_components/app_bar/app_bar_button.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class PyramidsAdminPanel extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const PyramidsAdminPanel({
    @required this.isInTransScreen,
    @required this.pyramidsAreOn,
    Key key
  }) : super(key: key);
  /// ---------------------------------------------------------------------------
  final bool isInTransScreen;
  final bool pyramidsAreOn;
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
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 10, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              /// TRANSLATION BUTTON
              if (Mapper.checkCanLoopList(_phidsPendingTranslation) == true)
                NoteRedDotWrapper(
                  childWidth: 40,
                  redDotIsOn: true,
                  count: _phidsPendingTranslation.length,
                  shrinkChild: true,
                  child: DreamBox(
                    height: 40,
                    width: 40,
                    corners: 20,
                    color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                    icon: Iconz.language,
                    iconSizeFactor: 0.6,
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
                ),

              /// CREATE NOTES BUTTON
              if (pyramidsAreOn == true)
                NoteRedDotWrapper(
                  childWidth: 40,
                  redDotIsOn: true,
                  count: _badgeNum,
                  shrinkChild: true,
                  child: DreamBox(
                    height: 40,
                    width: 40,
                    corners: 20,
                    color: isInTransScreen == true ? Colorz.yellow255 : Colorz.green50,
                    icon: Iconz.notification,
                    iconSizeFactor: 0.6,
                    onLongTap: () => NotesProvider.proRefreshBadgeNum(context),
                    onTap: () => Nav.goToNewScreen(
                      context: context,
                      screen: const NotesCreatorHome(),
                    ),
                  ),
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
