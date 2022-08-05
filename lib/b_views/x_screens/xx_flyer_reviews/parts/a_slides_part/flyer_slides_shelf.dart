import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/single_slide.dart';
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

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _flyerBoxHeight = shelfHeight;
    final double _flyerBoxWidth = FlyerBox.widthByHeight(context, _flyerBoxHeight);

    return SizedBox(
      width: _screenWidth,
      height: shelfHeight,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: flyerModel.slides.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (_, index){

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

          }
      ),
    );

  }
}
