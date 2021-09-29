import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class ReviewUserLabel extends StatelessWidget {
  final TinyUser tinyUser;
  final bool hasEditButton;
  final Function onReviewOptions;

  const ReviewUserLabel({
    @required this.tinyUser,
    @required this.hasEditButton,
    @required this.onReviewOptions,
  });


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

        Expanded(
          child: Container(),
        ),

        if(tinyUser?.userID == superUserID() && hasEditButton == true)
        DreamBox(
          height: 30,
          width: 30,
          icon: Iconz.More,
          iconSizeFactor: 0.6,
          margins: EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
          color: Colorz.White10,
          onTap: () => onReviewOptions(),
        ),

      ],
    );
  }
}
