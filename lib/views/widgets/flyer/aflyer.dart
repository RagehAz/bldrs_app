import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides.dart';
import 'package:flutter/material.dart';

class AFlyer extends StatelessWidget {
  final FlyerModel flyer;
  final BzModel bz;
  final double flyerSizeFactor;

  AFlyer({
    @required this.flyer,
    @required this.bz,
    @required this.flyerSizeFactor,
  });

  @override
  Widget build(BuildContext context) {

    final double _flyerZoneWidth = superFlyerZoneWidth(context, flyerSizeFactor);

    return FlyerZone(
      flyerSizeFactor: flyerSizeFactor,
      tappingFlyerZone: (){},
      stackWidgets: <Widget>[

        Slides(
          slides: flyer.slides,
          flyerZoneWidth: _flyerZoneWidth,
          slidingIsOn: true,
          sliding: (x){print(x);},
          currentSlideIndex: 0,
        ),

        Header(
          flyerZoneWidth: _flyerZoneWidth,
          bzPageIsOn: false,
          tappingHeader: (){},
          tappingFollow: (){},
          tappingUnfollow: (){},
          bz: bz,
          flyerShowsAuthor: flyer.flyerShowsAuthor,
          author: getAuthorFromBzByAuthorID(bz, flyer.authorID),
          followIsOn: false,
        ),

        ProgressBar(
          flyerZoneWidth: _flyerZoneWidth,
          numberOfSlides: flyer.slides.length,
          barIsOn: true,
          currentSlide: 0,
        ),

        AnkhButton(
            microMode: false,
            bzPageIsOn: false,
            flyerZoneWidth: _flyerZoneWidth,
            slidingIsOn: true,
            ankhIsOn: false,
            tappingAnkh: (){},
        ),

      ],
    );
  }
}