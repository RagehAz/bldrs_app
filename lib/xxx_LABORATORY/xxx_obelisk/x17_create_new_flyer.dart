import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_parts/flyer_zone.dart';
import 'package:flutter/material.dart';

class CreateFlyerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      stratosphereIsOn: false,
      appBarIsOn: false,
      pyramidsAreOn: false,
      layoutWidget: FlyerZone(
        flyerSizeFactor: 0.97,
        tappingFlyerZone: (){},
        stackWidgets: <Widget>[
          // HeaderZone()
        ],
      ),
    );
  }
}
