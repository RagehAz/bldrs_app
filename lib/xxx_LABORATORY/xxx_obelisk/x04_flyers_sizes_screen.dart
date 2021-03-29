import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/single_slide.dart';
import 'package:bldrs/views/widgets/flyer/tiny_flyer_widget.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersSizesScreen extends StatelessWidget {
  final double flyerSizeFactor;
  final TinyFlyer tinyFlyer;

  FlyersSizesScreen({
    this.flyerSizeFactor,
    this.tinyFlyer,
});

  @override
  Widget build(BuildContext context) {

    double _flyerSizeFactor = flyerSizeFactor ?? 0.5;

    return MainLayout(
      pageTitle: 'FlyerSizes Screen',
      appBarBackButton: true,
      appBarType: AppBarType.Basic,
      tappingRageh: (){print(tinyFlyer.bzLogo,);},
      layoutWidget: ListView(
        children: <Widget>[

          Stratosphere(),

          TinyFlyerWidget(
            flyerSizeFactor: _flyerSizeFactor,
            tinyFlyer: tinyFlyer,
          ),

        ],
      ),
    );
  }
}
