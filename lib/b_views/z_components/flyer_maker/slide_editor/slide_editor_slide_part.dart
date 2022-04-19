import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/slide_headline.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SlideEditorSlidePart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideEditorSlidePart({
    @required this.slide,
    @required this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<MutableSlide> slide;
  final double height;
  /// --------------------------------------------------------------------------
  static double getSlideZoneHeight(BuildContext context, double screenHeight){
    final double _slideZoneHeight = screenHeight * 0.75;
    return _slideZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double getFlyerZoneWidth(BuildContext context, double zoneHeight){
    final double _flyerBoxHeight = zoneHeight - (2 * Ratioz.appBarMargin);
    final double _flyerBoxWidth = FlyerBox.widthByHeight(context, _flyerBoxHeight);
    return _flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    final double _slideZoneHeight = height;
    final double _flyerBoxWidth = getFlyerZoneWidth(context, _slideZoneHeight);

    return Container(
      width: _screenWidth,
      height: _slideZoneHeight,
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: slide,
        child: Container(),
        builder: (_, MutableSlide _slide, Widget child){

          return FlyerBox(
            flyerBoxWidth: _flyerBoxWidth,
            boxColor: _slide.midColor,
            stackWidgets: <Widget>[

              /// IMAGE
              Align(
                child: SuperImage(
                  width: _flyerBoxWidth,
                  height: FlyerBox.height(context, _flyerBoxWidth),
                  pic: _slide.picFile,
                  fit: _slide.picFit,
                ),
              ),

              /// HEADLINE
              SlideHeadline(
                flyerBoxWidth: _flyerBoxWidth,
                verse: _slide.headline.text,
              ),

            ],
          );

        },
      ),
    );
  }
}
