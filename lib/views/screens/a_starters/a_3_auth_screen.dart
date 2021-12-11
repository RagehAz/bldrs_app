import 'package:bldrs/helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/specific/auth/register_form.dart';
import 'package:bldrs/views/widgets/specific/auth/signin_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {

  const AuthScreen({
    Key key
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool signingIn = true;
  String _email = '';
  String _password = '';
  ScrollController _scrollController;
  // final _keyboardHeight = EdgeInsets.fromWindowPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio).bottom;
  // final _keyboardHeight = viewInsets.bottom;
  // -----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
// -----------------------------------------------------------------------------
  void _switchSignIn (String email, String password){
    setState(() {
      _email = email;
      _password = password;
      signingIn = ! signingIn;
    });
  }
// -----------------------------------------------------------------------------
  Future<void> moveScreen(double keyboardHeight) async {
    // double _keyBoardHeight = keyboard.keyboardHeight;
    // print('_keyBoardHeight : ${keyboardHeight}');
    await _scrollController.animateTo(keyboardHeight, duration: const Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }
// -----------------------------------------------------------------------------
//   void emailTextOnChanged(String val){
//     setState(() {
//       email = val;
//     });
//   }
// -----------------------------------------------------------------------------
//   void passwordTextOnChanged(String val){
//     setState(() {
//       password = val;
//     });
//   }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      skyType: SkyType.black,
      appBarType: AppBarType.non,
      layoutWidget: Stack(
        children: <Widget>[

          ListView(
            controller: _scrollController,
            shrinkWrap: true,
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            children: <Widget>[

              // Stratosphere(heightFactor: 0.5,),

              if (signingIn == true)
              SignInForm(
                switchSignIn: _switchSignIn,
                email: _email,
                password: _password,
                fieldOnTap: (double keyboardHeight) => moveScreen(keyboardHeight),
              ),

              if (signingIn == false)
              RegisterForm(
                switchSignIn: _switchSignIn,
                email: _email,
                password: _password,
              ),

              const PyramidsHorizon(),

            ],
          ),

        ],
      ),
    );
  }
}
