import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/ankh_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class FlyerStatsTest extends StatefulWidget {
  final BzModel bz;

  FlyerStatsTest({
    @required this.bz,
});


  @override
  _FlyerStatsTestState createState() => _FlyerStatsTestState();
}

class _FlyerStatsTestState extends State<FlyerStatsTest> {


  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 1;
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Non,
      layoutWidget: FlyerZone(
        flyerSizeFactor: _flyerSizeFactor,
        tappingFlyerZone: (){},
        onLongPress: (){},
        stackWidgets: <Widget>[

          /// Slide
          Container(
            width: _flyerZoneWidth,
            height: _flyerZoneHeight,
            color: Colorz.BloodTest,
          ),

          Header(
            tinyBz: TinyBz.getTinyBzFromBzModel(widget.bz),
            tinyAuthor: TinyUser.getTinyAuthorFromAuthorModel(widget.bz.bzAuthors[0]),
            flyerShowsAuthor: true,
            followIsOn: false,
            flyerZoneWidth: Scale.superFlyerZoneWidth(context, _flyerSizeFactor),
            bzPageIsOn: false,
            tappingHeader: (){},
            onFollowTap: (){},
            onCallTap: (){
              print('call');
            },
          ),

          FlyerFooter(
            flyerZoneWidth: _flyerZoneWidth,
            saves: 0,
            shares: 0,
            views: 0,
            tappingShare: null,
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
      ),
    );
  }
}
