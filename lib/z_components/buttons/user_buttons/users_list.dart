import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const UsersList({
    required this.users,
    required this.scrollController,
    this.onTap,
    this.width,
    this.margins,
    this.scrollPadding,
    super.key
  });
  // -----------------------------------------------------------------------------
  final List<UserModel> users;
  final ScrollController scrollController;
  final double? width;
  final dynamic margins;
  final Function(UserModel userModel)? onTap;
  final EdgeInsets? scrollPadding;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(users) == true){
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
                () => Routing.goTo(
                  route: ScreenName.userPreview,
                  arg: userModel.id,
                )
                :
                () => onTap?.call(userModel),
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
