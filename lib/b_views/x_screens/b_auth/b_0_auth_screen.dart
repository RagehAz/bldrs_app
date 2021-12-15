import 'dart:async';

import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/artworks/bldrs_name_logo_slogan.dart';
import 'package:bldrs/b_views/widgets/general/buttons/main_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/y_views/b_auth/b_0_auth_screen_view.dart';
import 'package:bldrs/c_controllers/b_0_auth_controller.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthScreen({Key key}) : super(key: key);
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

    await controlAuth(context, authBy);

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pyramids: Iconz.pyramidzYellow,
      appBarType: AppBarType.non,
      layoutWidget: AuthScreenView(
        onAuthTap: (AuthBy authBy) => _auth(context, authBy),
      ),
    );
  }
}
