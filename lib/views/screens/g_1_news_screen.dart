import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/in_pyramids/news/new_flyer.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, 0.8);

    return ListView(
      children: <Widget>[

        // --- ALL NEWS : NEW PUBLISHED FLYER BY BZ WITHOUT AUTHOR : (INSTANTANEOUS)
        NewFlyerNotification(
          publisherName: 'Company Name',
          publisherType: PublisherType.Business,
          newsAge: 5,
          publisherPic: Iconz.Bz,
          superFlyer: SuperFlyer.createEmptySuperFlyer(context: context, flyerZoneWidth: _flyerZoneWidth),
        ),

        // --- ALL NEWS : NEW PUBLISHED FLYER BY BZ WITH AUTHOR : (INSTANTANEOUS)
        NewFlyerNotification(
          publisherName: 'Rageh The Author',
          publisherPic: Iconz.DumAuthorPic,
          newsAge: 15,
          publisherType: PublisherType.BzAuthor,
          superFlyer: SuperFlyer.createEmptySuperFlyer(context: context, flyerZoneWidth: _flyerZoneWidth),
        ),

        // --- ALL NEWS : NEW PUBLISHED FLYER BY USER OF TYPE : (INSTANTANEOUS)
        NewFlyerNotification(
          publisherName: 'Rageh The dude',
          publisherPic: Iconz.DvRageh,
          newsAge: 150,
          publisherType: PublisherType.User,
          superFlyer: SuperFlyer.createEmptySuperFlyer(context: context, flyerZoneWidth: _flyerZoneWidth),
        ),

        // o ( FOLLOWING NOTIFICATIONS )
        // --- BZ NEWS : NEW FOLLOWERS : (MIN OF NUMBER = X && MIN OF DURATION = T)

        // o ( CONNECTION NOTIFICATION )
        // --- BZ NEWS : NEW RECEIVED CONNECTION REQUEST : (INSTANTANEOUS)
        // --- BZ NEWS : SENT CONNECTION REPLY 'ACCEPTED, REJECTED' : (INSTANTANEOUS)

        // o ( BZ AUTHOR REQUEST NOTIFICATION )
        // --- BZ NEWS : USER REPLIED TO YOUR SENT AUTHORSHIP REQUEST 'ACCEPTED, REJECTED' : (INSTANTANEOUS)
        // --- USER NEWS : BZ SENT YOU AUTHORSHIP REQUEST 'ACCEPT, REJECT' : (INSTANTANEOUS)

        // o ( BZ PUBLISHED FLYER EDITOR'S REPLY )
        // --- BZ NEWS : BLDRS EDITORS 'REJECTED, EDITED, HIGHLIGHTED' YOUR FLYER : (INSTANTANEOUS)

        // o ( FLYERS SHARING )
        // --- ANY USER : RECEIVED A FLYER : (INSTANTANEOUS)
        // --- ANY USER : RECEIVED A COLLECTION OF FLYERS : (INSTANTANEOUS)

        // o ( PAID NEWS )
        // --- USER NEWS : BZ PAID NEWS : ( LIMITED AMOUNT PER WEEK AND LIMITED AMOUNT OF NOTIFICATION ALERTS )


        // o ( STATISTICS )
        // --- BZ NEWS : COMPETITION SIGNUPS IN SAME FIELD : (MIN OF NUM = X && MIN OF DURATION = T)
        // --- BZ NEWS : ALL BZ SIGNUPS IN ALL FIELDS : (MIN OF NUM = X && MIN OF DURATION = T)
        // --- BZ NEWS : DAILY BZ PROFILE STATISTICS 'FOLLOWERS, VIEWS, SAVES, SHARES, CONTACTS, CALLS'
        // --- ANY USER : WEEKLY NATIONAL STATISTICS
        // --- ANY USER : MONTHLY GLOBAL STATISTICS


      ],
    );
  }
}
