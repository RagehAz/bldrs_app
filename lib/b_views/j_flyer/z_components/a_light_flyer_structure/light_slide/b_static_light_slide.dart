import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class StaticLightSlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticLightSlide({
    @required this.flyerBoxWidth,
    @required this.slideModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final SlideModel slideModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        text: '',
        translate: false,
      ),
      skyType: SkyType.black,
      appBarRowWidgets: <Widget>[

        const Expander(),

        AppBarButton(
          verse: Verse.plain(''),
        ),

      ],
      child: Container(),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
