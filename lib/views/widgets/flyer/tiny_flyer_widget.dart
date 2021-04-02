import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';


void _tappingTinyFlyer(BuildContext context, String flyerID){
  openFlyer(context, flyerID);
}

void _onLongPress(String flyerID){
  print('flyerID is : $flyerID');
}

class TinyFlyerWidget extends StatelessWidget {
  final double flyerSizeFactor;
  final TinyFlyer tinyFlyer;

  TinyFlyerWidget({
    this.flyerSizeFactor,
    this.tinyFlyer,
  });



  @override
  Widget build(BuildContext context) {


    double _flyerSizeFactor = flyerSizeFactor ?? 0.5;

    return FlyerZone(
      flyerSizeFactor: _flyerSizeFactor,
      tappingFlyerZone: () => _tappingTinyFlyer(context, tinyFlyer.flyerID),
      onLongPress: () => _onLongPress(tinyFlyer.flyerID),
      stackWidgets: <Widget>[

        SingleSlide(
          flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
          slideMode: SlideMode.View,
          picture: tinyFlyer?.slidePic,
          slideIndex: 0,

        ),

        MiniHeader(
          flyerZoneWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
          bz: BzModel(
            bzLogo: tinyFlyer?.tinyBz?.bzLogo,
          ),
          author: AuthorModel(),
          followIsOn: false,
          flyerShowsAuthor: false,
          bzGalleryCount: 0,
          bzPageIsOn: false,
          tappingHeader: () =>_tappingTinyFlyer(context, tinyFlyer.flyerID),
          tappingFollow: (){},

        ),

      ],
    );
  }
}
