import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class BzFlyerScreen extends StatelessWidget {
  final String flyerID;

  BzFlyerScreen({
    @required this.flyerID,
});

  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = 0.7;

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      sky: Sky.Black,
      layoutWidget: flyerModelBuilder(
        context: context,
        flyerID: flyerID,
        flyerSizeFactor: _flyerSizeFactor,
        builder: (ctx, flyerModel){

          return
              AFlyer(
                  flyer: flyerModel,
                  flyerSizeFactor: _flyerSizeFactor,
              );

        }
      ),
    );
  }
}
