import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class FlyerSlidesShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerSlidesShelf({
    @required this.flyerModel,
    this.shelfHeight = 120,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double shelfHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _flyerBoxHeight = shelfHeight;
    final double _flyerBoxWidth = FlyerDim.flyerWidthByFlyerHeight(_flyerBoxHeight);
    // --------------------
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: shelfHeight,
        constraints: BoxConstraints(
          minWidth: _screenWidth + 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ...List.generate(flyerModel.slides.length, (index){

              return Container(
                margin: Scale.superInsets(context: context, enRight: 5),
                alignment: Alignment.center,
                child: SingleSlide(
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerBoxHeight: _flyerBoxHeight,
                  slideModel: flyerModel.slides[index],
                  tinyMode: false,
                  onSlideNextTap: null,
                  onSlideBackTap: null,
                  onDoubleTap: null,
                ),
              );

            }),

          ],
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
