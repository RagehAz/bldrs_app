import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';

class UsersList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UsersList({
    @required this.users,
    @required this.scrollController,
    this.onTap,
    this.width,
    this.margins,
    this.scrollPadding,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final List<UserModel> users;
  final ScrollController scrollController;
  final double width;
  final dynamic margins;
  final Function(UserModel userModel) onTap;
  final EdgeInsets scrollPadding;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(users) == true){
      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: users.length,
        padding: scrollPadding ?? const EdgeInsets.only(bottom: Ratioz.grandHorizon),
        itemExtent: 70,
        itemBuilder: (BuildContext context, int index) {

          final UserModel userModel = users[index];

          return BldrsBox(
            height: 60,
            width: width,
            icon: userModel.picPath,
            color: Colorz.white20,
            verse: Verse.plain(userModel.name),
            secondLine: UserModel.generateUserJobLine(userModel),
            verseScaleFactor: 0.6,
            verseCentered: false,
            secondLineScaleFactor: 0.9,
            margins: Scale.superMargins(margin: margins),
            onTap: onTap == null ?
                () => BldrsNav.jumpToUserPreviewScreen(context: context, userID: userModel.id)
                :
                () => onTap(userModel),
          );
        },
      );
    }
    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}