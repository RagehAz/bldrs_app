import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class MiniUserBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniUserBanner({
    required this.userModel,
    required this.size,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        BldrsBox(
          height: size,
          width: size,
          icon: userModel?.picPath,
          margins: Scale.constantHorizontal5,
          onTap: () => BldrsNav.jumpToUserPreviewScreen(
            userID: userModel?.id,
          ),
        ),

        SizedBox(
          width: size+10,
          height: 30,
          child: BldrsText(
            verse: Verse(
              id: userModel?.name,
              translate: false,
            ),
            size: 1,
            weight: VerseWeight.thin,
            maxLines: 2,
          ),
        ),

      ],
    );

  }
/// --------------------------------------------------------------------------
}
