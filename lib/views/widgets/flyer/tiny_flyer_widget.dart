import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:flutter/material.dart';

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

    void _tappingTinyFlyer(){
         print(tinyFlyer.flyerID);
    }

    return FlyerZone(
      flyerSizeFactor: _flyerSizeFactor,
      tappingFlyerZone: _tappingTinyFlyer,
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
            bzLogo: tinyFlyer?.bzLogo,
          ),
          author: AuthorModel(),
          followIsOn: false,
          flyerShowsAuthor: false,
          bzGalleryCount: 0,
          bzPageIsOn: false,
          tappingHeader: _tappingTinyFlyer,
          tappingFollow: (){},

        ),

      ],
    );
  }
}
