import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/auth/register_form.dart';
import 'package:bldrs/views/widgets/auth/signin_form.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool signingIn = true;
  String _email = '';
  String _password = '';
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
  void _switchSignIn (String email, String password){
    setState(() {
      _email = email;
      _password = password;
      signingIn = ! signingIn;
    });
  }
// ---------------------------------------------------------------------------
  void moveScreen(double keyboardHeight){
    // double _keyBoardHeight = keyboard.keyboardHeight;
    // print('_keyBoardHeight : ${keyboardHeight}');
    _scrollController.animateTo(keyboardHeight, duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }
// ---------------------------------------------------------------------------
//   void emailTextOnChanged(String val){
//     setState(() {
//       email = val;
//     });
//   }
// ---------------------------------------------------------------------------
//   void passwordTextOnChanged(String val){
//     setState(() {
//       password = val;
//     });
//   }
// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.PyramidzYellow,
      sky: Sky.Black,
      // tappingRageh: (){print('$_keyboardHeight');},
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeight(context),
        alignment: Alignment.topCenter,
        child: Stack(
          children: <Widget>[

            ListView(
              controller: _scrollController,
              shrinkWrap: true,
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              children: <Widget>[

                // Stratosphere(heightFactor: 0.5,),

                signingIn == true ?
                SignInForm(
                  switchSignIn: _switchSignIn,
                  email: _email,
                  password: _password,
                  fieldOnTap: (keyboard) => moveScreen(keyboard),
                )
                    :
                // REGISTER NEW ACCOUNT
                RegisterForm(
                  switchSignIn: _switchSignIn,
                  email: _email,
                  password: _password,
                ),

                PyramidsHorizon(heightFactor: 0,),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
