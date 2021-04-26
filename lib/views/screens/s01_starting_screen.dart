import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/screens/s02_auth_screen.dart';
import 'package:bldrs/views/screens/s16_user_editor_screen.dart';
import 'package:bldrs/views/widgets/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/buttons/bt_main.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 's00_user_checker_widget.dart';

class StartingScreen extends StatefulWidget {
// -----------------------------------------------------------------------------
  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
/// TASK : should fetch user current location automatically and suggest them here
  final Zone currentZone = Zone(countryID: '', provinceID: '', areaID: '');
  CountryProvider _countryPro;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    /// get user current location
    // TASK : need to trace user current location and pass it here while creating the userModel from firebase User
    _countryPro = Provider.of<CountryProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _tapGoogleContinue() async {

    _triggerLoading();

    /// start google auth ops
    dynamic _result = await AuthOps().googleSignInOps(context, _countryPro.currentZone);

    /// if auth returns error string we show dialog
    if(_result.runtimeType == String){

      _triggerLoading();

      /// pop error dialog
      await authErrorDialog(context: context, result: _result);

    }

    /// if auth returns a Map<String, dynamic>, we check its completion
    /// Map<String, dynamic> _map = {
    /// 'userModel' : userModel,
    /// 'firstTimer' : true or false,
    /// };
    else {

          /// so sign in succeeded returning a userModel
          UserModel _userModel = _result['userModel'];
          print('_tapGoogleContinue : _userModel : $_userModel');

          /// check if user model is properly completed
          List<String> _missingFields = UserModel.missingFields(_userModel);
          print('_tapGoogleContinue : _missingFields : $_missingFields');

          /// so if user model is completed
          if (_missingFields.length == 0){

            print('_missingFields.length == 0 : ${_missingFields.length == 0}');
            _triggerLoading();

            /// so userModel required fields are entered route to userChecker screen
            Nav.goToNewScreen(context, UserChecker());

          }

          /// if userModel is not completed
          else {

            _triggerLoading();

            /// pop a dialog
            await superDialog(
              context: context,
              title: 'Ops!',
              body: 'You have to complete your profile info\n ${_missingFields.toString()}',
              boolDialog: false,
            );

            /// check if its his first time or not
            bool _firstTimer = _result['firstTimer'];

            /// and route to complete profile missing data
            await Nav.goToNewScreen(context, EditProfileScreen(user: _userModel, firstTimer: _firstTimer,),);

            /// after returning from edit profile, we go to user checker
            Nav.goToNewScreen(context, UserChecker());


          }

    }

  }

  void _tapFacebookContinue(BuildContext context){
      // signUpWithFacebook(context, currentZone).then((result) {
      //   if (result != null) {return goToNewScreen(context, EditProfileScreen(firstTimer: true, user: xxxxxxxxxxxxxxxxxxxxxx,));}
      // });
    }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      appBarType: AppBarType.Intro,
      loading: _loading,
      layoutWidget: Stack(
        children: <Widget>[
          // --- stuff
          Column(
            children: <Widget>[

              Stratosphere(),

              LogoSlogan(sizeFactor: 0.87,),

              // --- CONTINUE WITH APPLE
              DeviceChecker.deviceIsIOS() ?
              BTMain(
                buttonVerse: Wordz.continueApple(context),
                buttonIcon: Iconz.ComApple,
                buttonColor: Colorz.BlackBlack,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,

              )
                  :
              // CONTINUE WITH GOOGLE
              DeviceChecker.deviceIsAndroid() ?
              BTMain(
                buttonVerse: "Continue with Google",
                buttonIcon: Iconz.ComGooglePlus,
                buttonColor: Colorz.GoogleRed,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: _tapGoogleContinue,
                stretched: false,
              )
                  :
              Container(),


              // --- CONTINUE WITH FACEBOOK
              BTMain(
                buttonVerse: Wordz.continueFacebook(context),
                buttonIcon: Iconz.ComFacebookWhite,
                buttonColor: Colorz.Facebook,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () => _tapFacebookContinue(context),
                stretched: false,
              ),

              // --- CONTINUE WITH EMAIL
              BTMain(
                buttonVerse: Wordz.continueEmail(context),
                buttonIcon: Iconz.ComEmail,
                buttonColor: Colorz.WhiteAir,
                splashColor: Colorz.Yellow,
                buttonVerseShadow: false,
                function: () => Nav.goToNewScreen(context, AuthScreen()),
                stretched: false,
              ),

            ],
          ),

          // // --- SKIP BUTTON
          // BtSkipAuth(),

        ],
      ),
    );
  }
}
