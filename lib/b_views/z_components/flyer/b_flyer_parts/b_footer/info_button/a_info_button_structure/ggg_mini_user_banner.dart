import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class MiniUserBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniUserBanner({
    @required this.userModel,
    @required this.size,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[

        DreamBox(
          height: size,
          width: size,
          icon: userModel?.pic,
          margins: Scale.superInsets(context: context, enRight: 5, enLeft: 5),
          onTap: (){},
        ),

        SizedBox(
          width: size+10,
          height: 30,
          child: SuperVerse(
            verse: userModel?.name,
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
