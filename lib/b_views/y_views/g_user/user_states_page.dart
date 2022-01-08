import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class UserStatsPage extends StatelessWidget {

  const UserStatsPage({
    @required this.userModel,
    Key key
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {

    blog('BUILDING UserStatsPage');

    return Center(
      child: SuperVerse(
        verse: 'User states : ${userModel.status.toString()}',
        size: 5,
        maxLines: 5,
      ),
    );
  }
}
