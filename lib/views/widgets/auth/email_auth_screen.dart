import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/screens/s02_signin_page.dart';
import 'package:bldrs/views/screens/s03_register_page.dart';
import 'package:bldrs/views/widgets/buttons/bt_skip_auth.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class EmailAuth extends StatefulWidget {
  @override
  _EmailAuthState createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  bool signingIn = true;
  String email = '';
  String password = '';
  ScrollController _scrollController;
  final _keyboardHeight = EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio).bottom;
  // final _keyboardHeight = viewInsets.bottom;
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
// ---------------------------------------------------------------------------
  void switchSignIn (){
    setState(() {
      signingIn = ! signingIn;
    });
  }
// ---------------------------------------------------------------------------
  void moveScreen(double keyboardHeight){
    // double _keyBoardHeight = keyboard.keyboardHeight;
    print('_keyBoardHeight : ${keyboardHeight}');
    _scrollController.animateTo(keyboardHeight, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
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
      tappingRageh: (){print('$_keyboardHeight');},
      layoutWidget: Container(
        width: superScreenWidth(context),
        height: superScreenHeight(context),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[

            ListView(
              controller: _scrollController,
              shrinkWrap: true,
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              children: <Widget>[

                Stratosphere(heightFactor: 0.5,),

                signingIn == true ?
                SignIn(
                  switchToSignIn: switchSignIn,
                  email: email,
                  password: password,
                  emailTextOnChanged: (val) => emailTextOnChanged(val),
                  passwordTextOnChanged: (val) => passwordTextOnChanged(val),
                  fieldOnTap: (keyboard) => moveScreen(keyboard),
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

            BtSkipAuth(),

          ],
        ),
      ),
    );
  }
}
