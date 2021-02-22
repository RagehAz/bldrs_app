import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/author_label.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

enum PublisherType {
 Business,
 BzAuthor,
 User,
}


class NewFlyerNotification extends StatelessWidget {
  final String publisherName;
  final PublisherType publisherType;
  final double newsAge;
  final String publisherPic;

  NewFlyerNotification({
    @required this.publisherName,
    @required this.publisherType,
    @required this.newsAge,
    @required this.publisherPic,
});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    bool designMode = false;

    return InPyramidsBubble(
          centered: true,
          columnChildren: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                publisherType == PublisherType.Business ?
                BzLogo(
                  width: 55,
                  image: Iconz.DvRageh,
                )
                    :
                publisherType == PublisherType.BzAuthor ?
                AuthorPic(
                  authorPic: publisherPic,
                  flyerZoneWidth: screenWidth * 0.89,
                ) :
                UserBalloon(
                  // userPic: Iconz.DvRageh,
                  balloonWidth: 55,
                  balloonType: UserStatus.PlanningTalking,
                  onTap: (){},
                  blackAndWhite: false,
                  loading: false,
                )
                ,

                SizedBox(
                  width: 5,
                  height: 45,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    SuperVerse(
                      verse: publisherName,
                      size: 3,
                      designMode: designMode,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      SuperVerse(
                        verse: 'published a new flyer',
                        weight: VerseWeight.thin,
                        size: 2,
                        designMode: designMode,
                      ),

                        SizedBox(
                          width: 5,

                        ),
                        SuperVerse(
                          verse: '. ${newsAge.toStringAsFixed(0)} days ago',
                          color: Colorz.Grey,
                          italic: true,
                          weight: VerseWeight.thin,
                          size: 2,
                          designMode: designMode,
                        ),

                      ]
                    ),

                  ],
                ),
              ],
            ),

            SizedBox(
              height: 5,
            ),

           //  DummyFlyer(
           // flyerSizeFactor: 0.4,
           //  ),

          ],
        );
  }
}
