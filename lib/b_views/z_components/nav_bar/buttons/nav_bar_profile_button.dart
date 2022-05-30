import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/b_auth/b_0_auth_screen.dart';
import 'package:bldrs/b_views/x_screens/g_user/g_0_user_profile_screen.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/nav_bar/bar_button.dart';
import 'package:bldrs/b_views/z_components/nav_bar/nav_bar.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class NavBarProfileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NavBarProfileButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  bool _checkNoteDotIsOn({
    @required bool thereAreMissingFields,
    @required List<NoteModel> notes,
  }){

    bool _isOn = false;

    if (thereAreMissingFields == true){
      _isOn = true;
    }
    else {

      if (Mapper.canLoopList(notes) == true){
        _isOn = true;
      }

    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  int _getNotesCount({
    @required bool thereAreMissingFields,
    @required List<NoteModel> notes,
}){
    int _count;

    if (thereAreMissingFields == false){
      if (Mapper.canLoopList(notes) == true){
        _count = notes?.length;
      }
    }

    return _count;
}
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _userIsSignedIn = AuthModel.userIsSignedIn();

    /// SIGNED IN
    if (_userIsSignedIn == true){

      final UserModel _userModel = UsersProvider.proFetchMyUserModel(context, listen: true);
      final bool _thereAreMissingFields = UserModel.thereAreMissingFields(_userModel);

      return NoteFireOps.noteStreamBuilder(
        context: context,
        stream: NotesProvider.proGetUserNotesStream(context: context, listen: true),
        builder: (_, List<NoteModel> notes){

          final bool _noteDotIsOn = _checkNoteDotIsOn(
            thereAreMissingFields: _thereAreMissingFields,
            notes : notes,
          );

          final int _notesCount = _getNotesCount(
            thereAreMissingFields: _thereAreMissingFields,
            notes : notes,
          );

          // blog('the notes count is wtfffff : $_notesCount');

          return BarButton(
              size: NavBar.navBarButtonWidth,
              text: superPhrase(context, 'phid_profile'),
              icon: Iconz.normalUser,
              iconSizeFactor: 0.7,
              barType: NavBar.barType,
              notesDotIsOn: _noteDotIsOn,
              notesCount: _notesCount,
              onTap: () => Nav.goToNewScreen(
                  context: context,
                  screen: const UserProfileScreen()
              ),
              clipperWidget: UserBalloon(
                size: NavBar.circleWidth,
                loading: false,
                userModel: _userModel,
              )
          );
          },
      );


    }

    /// NOT SIGNED IN
    else {

      return BarButton(
        size: NavBar.navBarButtonWidth,
        text: superPhrase(context, 'phid_sign'),
        icon: Iconz.normalUser,
        iconSizeFactor: 0.45,
        barType: NavBar.barType,
        notesDotIsOn: true,
        onTap: () async {
          await Nav.goToNewScreen(
            context: context,
            screen: const AuthScreen(),
          );
          },
      );

    }

  }
}
