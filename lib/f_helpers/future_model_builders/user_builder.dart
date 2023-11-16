import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:flutter/material.dart';

class UserBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const UserBuilder({
    required this.userID,
    required this.builder,
    super.key
  });
  // ------------------------
  final String? userID;
  final Widget Function(bool loading, UserModel? userModel) builder;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FutureBuilder(
        future: UserProtocols.fetch(
          userID: userID,
        ),
        builder: (context, AsyncSnapshot<UserModel?> snap) {

          return builder(snap.connectionState == ConnectionState.waiting, snap.data);

        }
        );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
