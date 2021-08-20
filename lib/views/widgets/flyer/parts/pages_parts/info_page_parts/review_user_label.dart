import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class ReviewUserLabel extends StatelessWidget {
  final TinyUser tinyUser;

  const ReviewUserLabel({
    @required this.tinyUser,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        DreamBox(
          height: 40,
          // width: 40,
          margins: 5,
          icon: tinyUser.pic,
          verse: tinyUser.name,
          verseScaleFactor: 0.6,
          secondLine: tinyUser.title,
          underLineShadowIsOn: true,
          iconRounded: false,
          bubble: false,
          onTap: () => print('aho'),
        ),


      ],
    );
  }
}
