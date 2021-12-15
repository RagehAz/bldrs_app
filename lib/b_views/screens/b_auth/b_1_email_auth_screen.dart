import 'package:bldrs/b_views/widgets/components/horizon.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/auth/register_form.dart';
import 'package:bldrs/b_views/widgets/specific/auth/signin_form.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

class EmailAuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EmailAuthScreen({Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();

  /// --------------------------------------------------------------------------
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  bool signingIn = true;
  String _email = '';
  String _password = '';
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  void _switchSignIn(String email, String password) {
    setState(() {
      _email = email;
      _password = password;
      signingIn = !signingIn;
    });
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
            shrinkWrap: true,
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            children: <Widget>[
              // Stratosphere(heightFactor: 0.5,),

              if (signingIn == true)
                SignInForm(
                  switchSignIn: _switchSignIn,
                  email: _email,
                  password: _password,
                //   fieldOnTap: (double keyboardHeight) =>
                //       moveScreen(keyboardHeight),
                ),

              if (signingIn == false)
                RegisterForm(
                  switchSignIn: _switchSignIn,
                  email: _email,
                  password: _password,
                ),

              const Horizon(),
            ],
          ),

        ],
      ),
    );
  }
}
