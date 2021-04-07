import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';


// void _tappingTinyFlyer(BuildContext context, String flyerID){
//   openFlyer(context, flyerID);
// }

void _onLongPress(String flyerID){
  print('flyerID is : $flyerID');
}

class TinyFlyerWidget extends StatelessWidget {
  final double flyerSizeFactor;
  final TinyFlyer tinyFlyer;
  final Function onTap;

  TinyFlyerWidget({
    this.flyerSizeFactor,
    this.tinyFlyer,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = flyerSizeFactor ?? 0.5;

    return FlyerZone(
      flyerSizeFactor: _flyerSizeFactor,
      tappingFlyerZone: () => onTap(tinyFlyer.flyerID),
      onLongPress: () => _onLongPress(tinyFlyer.flyerID),
      stackWidgets: <Widget>[

        SingleSlide(
          flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
          slideMode: SlideMode.View,
          picture: tinyFlyer?.slidePic,
          slideIndex: tinyFlyer?.slideIndex,
        ),

        MiniHeader(
          flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
          tinyBz: tinyFlyer.tinyBz,
          tinyAuthor: TinyUser(userID: tinyFlyer.authorID, name: null, title: null, pic: null, contact: null, userStatus: null),
          followIsOn: false,
          flyerShowsAuthor: false,
          bzGalleryCount: 0,
          bzPageIsOn: false,
          tappingHeader: () => onTap(context, tinyFlyer.flyerID),
          tappingFollow: (){},
        ),

      ],
    );
  }
}
