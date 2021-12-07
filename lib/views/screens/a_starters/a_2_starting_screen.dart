import 'package:bldrs/controllers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/a_starters/a_0_user_checker_widget.dart';
import 'package:bldrs/views/screens/a_starters/a_3_auth_screen.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StartingScreen extends StatefulWidget {

  const StartingScreen({
    Key key
  }) : super(key: key);

// -----------------------------------------------------------------------------
  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
/// TASK : should fetch user current location automatically and suggest them here
//   final Zone currentZone = Zone(countryID: '', cityID: '', districtID: '');
  ZoneProvider _zoneProvider;
  ZoneModel _currentZone;
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
      _authResult = await FireAuthOps.googleSignInOps(
          context: context,
          currentZone: _currentZone,
      );
    }
    else if(authBy == AuthBy.facebook){
      /// start google auth ops
      _authResult = await FireAuthOps.facebookSignInOps(
          context: context,
          currentZone: _currentZone,
      );
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

      Nav.replaceScreen(context, const UserChecker());

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      appBarType: AppBarType.non,
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

              // const Stratosphere(),

              const LogoSlogan(
                showTagLine: true,
                showSlogan: true,
                sizeFactor: 0.8,
              ),

              const SizedBox(height: Ratioz.appBarMargin,),

              /// --- CONTINUE WITH APPLE
              if (DeviceChecker.deviceIsIOS() == true)
              MainButton(
                buttonVerse: Wordz.continueApple(context),
                buttonIcon: Iconz.comApple,
                buttonColor: Colorz.black230,
                buttonVerseShadow: false,
                function: Routez.home,

              ),

              /// CONTINUE WITH GOOGLE
              if (DeviceChecker.deviceIsAndroid() == true)
              MainButton(
                buttonVerse: 'Continue with Google',
                buttonIcon: Iconz.comGooglePlus,
                buttonColor: Colorz.googleRed,
                buttonVerseShadow: false,
                function: () => _tapContinueWith(context, AuthBy.google),
              ),

              /// --- CONTINUE WITH FACEBOOK
              MainButton(
                buttonVerse: Wordz.continueFacebook(context),
                buttonIcon: Iconz.comFacebookWhite,
                buttonColor: Colorz.facebook,
                buttonVerseShadow: false,
                function: () => _tapContinueWith(context, AuthBy.facebook),
              ),

              /// --- CONTINUE WITH EMAIL
              MainButton(
                buttonVerse: Wordz.continueEmail(context),
                buttonIcon: Iconz.comEmail,
                buttonColor: Colorz.white10,
                buttonVerseShadow: false,
                function: () => Nav.goToNewScreen(context, const AuthScreen()),
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
