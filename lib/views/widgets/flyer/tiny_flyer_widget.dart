import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer_parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/flyer/super_flyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// void _tappingTinyFlyer(BuildContext context, String flyerID){
//   openFlyer(context, flyerID);
// }

void _onLongPress(String flyerID){
  print('flyerID is : $flyerID');
}

class TinyFlyerWidget extends StatelessWidget {
  final SuperFlyer superFlyer;
  // final double flyerSizeFactor;
  // final TinyFlyer tinyFlyer;
  // final Function onTap;

  TinyFlyerWidget({
    this.superFlyer,
    // this.flyerSizeFactor,
    // this.tinyFlyer,
    // this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: true);
    bool _ankhIsOn=_pro.checkAnkh(superFlyer.flyerID);
    double _flyerZoneWidth = superFlyer.flyerZoneWidth; //Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _flyerSizeFactor = Scale.superFlyerSizeFactorByWidth(context, _flyerZoneWidth); //flyerSizeFactor ?? 0.5;

    return FlyerZone(
      flyerSizeFactor: _flyerSizeFactor,
      tappingFlyerZone: (){
        // print('tapping flyer zone');
        // onTap(tinyFlyer);
      },
      // onLongPress: () => superFlyer.onLo(superFlyer.flyerID),
      stackWidgets: <Widget>[

        SingleSlide(
          flyerID: superFlyer?.flyerID,
          flyerZoneWidth: superFlyer.flyerZoneWidth,
          slideMode: SlideMode.View,
          picture: superFlyer?.slides[0].picture,
          slideIndex: superFlyer?.currentSlideIndex,
          onTap:  (){
            print('tapping slide zone');
            // superFlyer.onSlideRightTap(tinyFlyer);
          },
        ),

        MiniHeader(
          superFlyer: superFlyer,
          // flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
          // tinyBz: tinyFlyer.tinyBz,
          // tinyAuthor: TinyUser(userID: tinyFlyer.authorID, name: null, title: null, pic: null, email: null, phone: null, userStatus: null),
          // followIsOn: false,
          // flyerShowsAuthor: false,
          // bzGalleryCount: 0,
          // bzPageIsOn: false,
          // tappingHeader: () => onTap(tinyFlyer.flyerID),
          // onFollowTap: (){},
          // onCallTap: (){},
        ),

        AnkhButton(
          bzPageIsOn: false,
          flyerZoneWidth: _flyerZoneWidth,
          slidingIsOn: false,
          ankhIsOn: _ankhIsOn,
          tappingAnkh: (){},
        ),

      ],
    );
  }
}
