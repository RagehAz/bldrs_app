import 'package:bldrs/b_screens/a_home_screen/pages/d_auth_page/a_auth_screen.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AuthPage({
    super.key
  });
  // --------------------
  ///
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return const AuthScreen(
      appBarType: AppBarType.non,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
