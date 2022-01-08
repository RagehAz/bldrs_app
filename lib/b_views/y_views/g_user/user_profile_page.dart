import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {

  const UserProfilePage({
    @required this.userModel,
    Key key
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {

    blog('BUILDING UserProfilePage');

    return Center(
      child: SuperVerse(
        verse: 'User screen : ${userModel.name}',
        size: 5,
    ),
    );
  }
}
