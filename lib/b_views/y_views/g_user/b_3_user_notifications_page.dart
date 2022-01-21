import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/status_bubble.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class UserNotificationsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const UserNotificationsPage({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return const Center(
      child: SuperVerse(
        verse: 'User\nNotifications\nPage',
        maxLines: 3,
        size: 4,
      ),
    );

  }
}
