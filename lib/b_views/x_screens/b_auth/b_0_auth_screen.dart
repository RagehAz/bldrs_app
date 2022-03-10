import 'dart:async';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/b_views/y_views/b_auth/b_0_auth_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AuthScreenState createState() => _AuthScreenState();
  /// --------------------------------------------------------------------------
}

class _AuthScreenState extends State<AuthScreen> {
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _auth(BuildContext context, AuthBy authBy) async {

    await controlOnAuth(context, authBy);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      layoutWidget: AuthScreenView(
        onAuthTap: (AuthBy authBy) => _auth(context, authBy),
      ),
    );
  }
}
