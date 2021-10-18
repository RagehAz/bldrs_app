import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/firestore/auth_ops.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/a_starters/a_3_auth_screen.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'a_0_user_checker_widget.dart';

class StartingScreen extends StatefulWidget {
// -----------------------------------------------------------------------------
  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
/// TASK : should fetch user current location automatically and suggest them here
//   final Zone currentZone = Zone(countryID: '', cityID: '', districtID: '');
  ZoneProvider _zoneProvider;
  Zone _currentZone;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    /// get user current location
    // TASK : need to trace user current location and pass it here while creating the userModel from firebase User
    _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    _currentZone = _zoneProvider.currentZone;
  }
// -----------------------------------------------------------------------------
  Future<void> _tapContinueWith(BuildContext context, AuthBy authBy) async {

    print('starting _tapGoogleContinue method');

    _triggerLoading();

    /// start auth to return String error or return Map<String,dynamic>
    ///  {
    ///    'userModel' : _existingUserModel or new _finalUserModel
    ///    'firstTimer' : false or true
    ///  };
    dynamic _authResult;
    if(authBy == AuthBy.google) {
    /// start google auth ops,
      _authResult = await AuthOps().googleSignInOps(context, _currentZone);
    }
    else if(authBy == AuthBy.facebook){
      /// start google auth ops
      _authResult = await AuthOps().facebookSignInOps(context, _currentZone);
    }
    else if(authBy == AuthBy.apple){
      // _authResult = await AuthOps().appleSignInOps(context, _currentZone);
    }

    /// if auth returns error string we show dialog
    print('_tapGoogleContinue : googleSignInOps_result : $_authResult');
    if(_authResult.runtimeType == String || _authResult == null){

      _triggerLoading();

      /// pop error dialog
      await Dialogz.authErrorDialog(context: context, result: _authResult);

    }

    /// if auth returns a Map<String, dynamic>, we check its completion
    /// Map<String, dynamic> _map = {
    /// 'userModel' : userModel,
    /// 'firstTimer' : true or false,
    /// };
    else {

      /// so sign in succeeded returning a userModel
      final UserModel _userModel = _authResult['userModel'];
      print('_tapGoogleContinue : _userModel : $_userModel');

      Nav.replaceScreen(context, UserChecker());

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Night,
      appBarType: AppBarType.Intro,
      loading: _loading,
      // tappingRageh: (){
      //   print('current zone : ${_currentZone.cityID}');
      //   print('Wordz.languageCode(context) : ${Wordz.languageCode(context)}');
      //   // print('isa');
      // },
      layoutWidget: Stack(
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const Stratosphere(),

              LogoSlogan(
                showTagLine: true,
                showSlogan: true,
                sizeFactor: 0.7,
              ),

              const SizedBox(height: Ratioz.appBarMargin,),

              /// --- CONTINUE WITH APPLE
              DeviceChecker.deviceIsIOS() ?
              MainButton(
                buttonVerse: Wordz.continueApple(context),
                buttonIcon: Iconz.ComApple,
                buttonColor: Colorz.black230,
                splashColor: Colorz.yellow255,
                buttonVerseShadow: false,
                function: Routez.Home,
                stretched: false,

              )
                  :
              /// CONTINUE WITH GOOGLE
              DeviceChecker.deviceIsAndroid() ?
              MainButton(
                buttonVerse: "Continue with Google",
                buttonIcon: Iconz.ComGooglePlus,
                buttonColor: Colorz.googleRed,
                splashColor: Colorz.yellow255,
                buttonVerseShadow: false,
                function: () => _tapContinueWith(context, AuthBy.google),
                stretched: false,
              )
                  :
              Container(),


              /// --- CONTINUE WITH FACEBOOK
              MainButton(
                buttonVerse: Wordz.continueFacebook(context),
                buttonIcon: Iconz.ComFacebookWhite,
                buttonColor: Colorz.facebook,
                splashColor: Colorz.yellow255,
                buttonVerseShadow: false,
                function: () => _tapContinueWith(context, AuthBy.facebook),
                stretched: false,
              ),

              /// --- CONTINUE WITH EMAIL
              MainButton(
                buttonVerse: Wordz.continueEmail(context),
                buttonIcon: Iconz.ComEmail,
                buttonColor: Colorz.white10,
                splashColor: Colorz.yellow255,
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
