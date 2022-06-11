import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:flutter/material.dart';


class BzSettingsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSettingsPage({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final UserModel userModel = UsersProvider.proGetMyUserModel(context, listen: true);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: Stratosphere.stratosphereSandwich,
      children: const <Widget>[

        SuperVerse(
          verse: 'Bz Settings page',
        ),

      ],
    );

  }
}
