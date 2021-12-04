import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class ReviewUserLabel extends StatelessWidget {
  final UserModel tinyUser;
  final bool hasEditButton;
  final Function onReviewOptions;

  const ReviewUserLabel({
    @required this.tinyUser,
    @required this.hasEditButton,
    @required this.onReviewOptions,
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        DreamBox(
          height: 40,
          // width: 40,
          margins: 5,
          icon: tinyUser?.pic,
          verse: tinyUser?.name,
          verseScaleFactor: 0.6,
          secondLine: tinyUser?.title,
          underLineShadowIsOn: true,
          iconRounded: false,
          bubble: false,
          onTap: () => print('aho'),
        ),

        const Expander(),

        if(tinyUser?.id == FireAuthOps.superUserID() && hasEditButton == true)
        DreamBox(
          height: 30,
          width: 30,
          icon: Iconz.More,
          iconSizeFactor: 0.6,
          margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          color: Colorz.white10,
          onTap: () => onReviewOptions(),
        ),

      ],
    );
  }
}
