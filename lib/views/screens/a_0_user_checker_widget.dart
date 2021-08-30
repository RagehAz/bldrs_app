import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/screens/a_2_starting_screen.dart';
import 'package:bldrs/views/screens/a_4_loading_screen.dart';
import 'package:bldrs/views/screens/g_x_user_editor_screen.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

/// TASK : if appNeedsUpdate = true ? goTO(AppStore) : check the user as you wish
/// TASK : if device is offline
/// and we get this value from database and to be controlled from dashboard
class UserChecker extends StatefulWidget {

  @override
  _UserCheckerState createState() => _UserCheckerState();
}

class _UserCheckerState extends State<UserChecker> {
  bool _isInit = true;
  bool _logoIsShown = false;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;

  void _triggerLoading() {
    setState(() {
      _loading = !_loading;
    });
    _loading == true ?
    print('LOADING--------------------------------------') : print(
        'LOADING COMPLETE--------------------------------------');
  }

// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {

      print('userChecker 1 : trigger loading');
      _triggerLoading();

      /// A - if user is signed in

        _showLogo().
        then((_) async {

          print('User is signed in : ${AuthOps.userIsSignedIn()}');
          if (AuthOps.userIsSignedIn() == true) {

            UserModel _userModel = await UserOps().readUserOps(
              context: context,
              userID: superUserID(),
            );

            /// B -  if user has a userModel
            if (_userModel != null) {

              /// check if user model is properly completed
              List<String> _missingFields = UserModel.missingFields(_userModel);
              print(' _missingFields : $_missingFields');

              /// C - if userModel is completed
              if (_missingFields.length == 0) {
                _triggerLoading();

                /// XX - userModel is completed : go to LoadingScreen()
                print('userModel is completed : go to LoadingScreen()');
                // var _result = await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);
                await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);

                print('user has a completed userModel and was in home screen and came back to user checker');
                /// so we loop once more to user check
                await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
              }

              /// C - if userModel is not completed
              else {
                _triggerLoading();

                /// pop a dialog
                await superDialog(
                  context: context,
                  title: 'Ops!',
                  body: 'You have to complete your profile info\n ${_missingFields.toString()}',
                  boolDialog: false,
                );

                /// route to complete profile missing data
                await Nav.goToNewScreen(context, EditProfileScreen(
                  user: _userModel, firstTimer: false,),);

                /// after returning from edit profile, we go to LoadingScreen()
                print('user has completed profile and good to go to LoadingScreen()');
                // var _result = await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);
                await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);

              }
            }

            /// B - if user has no userModel
            else {
            _triggerLoading();

            /// route to complete profile missing data
            await Nav.goToNewScreen(context, EditProfileScreen(
              user: _userModel, firstTimer: true,),);

            /// after returning from creating profile, we go to LoadingScreen()
            print('user has created profile and good to go to LoadingScreen()');
            var _result = await Nav.goToNewScreen(context, LoadingScreen(), transitionType: PageTransitionType.fade);
          }

      }

          /// A - if user is not signed in
          else {
            _triggerLoading();

            /// route to sign in
            var _result = await Nav.goToNewScreen(context, StartingScreen(), transitionType: PageTransitionType.fade);

            print('just came back from starting screen');
            /// and we loop again in userChecker
            await Nav.pushNamedAndRemoveAllBelow(context, Routez.UserChecker);
          }

        });

    }

    _isInit = false;
    super.didChangeDependencies();

  }
// -----------------------------------------------------------------------------
  Future<void> _showLogo() async {
    setState(() {
      _logoIsShown = true;
    });
  }
// -----------------------------------------------------------------------------
  void _exitApp(BuildContext context) {
    Nav.goBack(context);
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userProvided = Provider.of<UserModel>(context);
    List<String> _missingFields = UserModel.missingFields(_userProvided);

    Tracer.traceWidgetBuild(widgetName: 'UserChecker', varName: 'userID', varValue: _userProvided?.userID);
    return

      MainLayout(
        loading: _loading,
        pyramids: Iconz.PyramidzYellow,
        appBarType: AppBarType.Non,
        // tappingRageh: (){
        //   Nav.goBack(context);
        // },
        layoutWidget: _logoIsShown ? Center(child: LogoSlogan(sizeFactor: 0.7)) : null,

      );

    // /// when the user is null after sign out, or did not auth yet
    //   _userProvided?.userID == null ?
    //   WillPopScope(
    //     onWillPop: () => Future.value(true),
    //     child: StartingScreen(
    //       // exitApp: () =>_exitApp(context),
    //     ),
    //   )
    //
    //   // :
    //   //
    //   // /// when user has his account not finished
    //   // _missingFields.length != 0 ?
    //   // EditProfileScreen(user: _userProvided, firstTimer: false,)
    //
    //       :
    //
    //   /// when user is valid to enter home screen, start loading screen then home
    //   LoadingScreen();

    // }
  }
}