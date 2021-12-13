import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/screens/b_auth/a_3_email_auth_screen.dart';
import 'package:bldrs/b_views/screens/zebala/a_0_user_checker_widget.dart';
import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/dialogz.dart' as Dialogz;
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  @override
  _AuthScreenState createState() => _AuthScreenState();

  /// --------------------------------------------------------------------------
}

class _AuthScreenState extends State<AuthScreen> {
//   final Zone currentZone = Zone(countryID: '', cityID: '', districtID: '');
  ZoneProvider _zoneProvider;
  ZoneModel _currentZone;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
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
    blog('starting _tapGoogleContinue method');

    unawaited(_triggerLoading());

    /// start auth to return String error or return Map<String,dynamic>
    ///  {
    ///    'userModel' : _existingUserModel or new _finalUserModel
    ///    'firstTimer' : false or true
    ///  };
    dynamic _authResult;
    if (authBy == AuthBy.google) {
      /// start google auth ops,
      _authResult = await FireAuthOps.googleSignInOps(
        context: context,
        currentZone: _currentZone,
      );
    } else if (authBy == AuthBy.facebook) {
      /// start google auth ops
      _authResult = await FireAuthOps.facebookSignInOps(
        context: context,
        currentZone: _currentZone,
      );
    } else if (authBy == AuthBy.apple) {
      // _authResult = await AuthOps().appleSignInOps(context, _currentZone);
    }

    /// if auth returns error string we show dialog
    blog('_tapGoogleContinue : googleSignInOps_result : $_authResult');
    if (_authResult.runtimeType == String || _authResult == null) {
      unawaited(_triggerLoading());

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
      blog('_tapGoogleContinue : _userModel : $_userModel');

      await Nav.replaceScreen(context, const UserChecker());
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
      //   blog('current zone : ${_currentZone.cityID}');
      //   blog('Wordz.languageCode(context) : ${Wordz.languageCode(context)}');
      //   // blog('isa');
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

              const SizedBox(
                height: Ratioz.appBarMargin,
              ),

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
                function: () =>
                    Nav.goToNewScreen(context, const EmailAuthScreen()),
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
