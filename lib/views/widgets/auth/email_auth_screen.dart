import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/auth/register.dart';
import 'package:bldrs/views/widgets/auth/signin.dart';
import 'package:bldrs/views/widgets/buttons/bt_skip_auth.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class EmailAuth extends StatefulWidget {
  @override
  _EmailAuthState createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  bool signingIn = true;
  String email = '';
  String password = '';

// ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
  }
// ---------------------------------------------------------------------------
  void switchSignIn (){
    setState(() {
      signingIn = ! signingIn;
    });
  }
// ---------------------------------------------------------------------------
  void emailTextOnChanged(String val){
    setState(() {
      email = val;
    });
  }
// ---------------------------------------------------------------------------
  void passwordTextOnChanged(String val){
    setState(() {
      password = val;
    });
  }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      // tappingRageh: (){print('$email, $password');},
      layoutWidget: Container(
        width: superScreenWidth(context),
        height: superScreenHeight(context),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[

            SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Stratosphere(heightFactor: 0.5,),

                  signingIn == true ?
                  SignIn(
                    switchToSignIn: switchSignIn,
                    email: email,
                    password: password,
                    emailTextOnChanged: emailTextOnChanged,
                    passwordTextOnChanged: passwordTextOnChanged,
                  )
                      :
                      // REGISTER NEW ACCOUNT
                  Register(
                    switchToSignIn: switchSignIn,
                    email: email,
                    password: password,
                    emailTextOnChanged: emailTextOnChanged,
                    passwordTextOnChanged: passwordTextOnChanged,
                  ),

                  PyramidsHorizon(heightFactor: 13,),

                ],
              ),
            ),


            BtSkipAuth(),

          ],
        ),
      ),
    );
  }
}
