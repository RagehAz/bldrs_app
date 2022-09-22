import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class StaticFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyer({
    @required this.bzModel,
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBox(
      key: const ValueKey<String>('StaticFlyer'),
      flyerBoxWidth: flyerBoxWidth,
      // boxColor: Colorz.bloodTest,
      stackWidgets: <Widget>[

        SingleSlide(
            flyerBoxWidth: flyerBoxWidth,
            flyerBoxHeight: FlyerBox.height(context, flyerBoxWidth),
            slideModel: flyerModel.slides[0],
            tinyMode: false,
            onSlideNextTap: (){},
            onSlideBackTap: (){},
            onDoubleTap: (){},
        ),

        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: bzModel,
          authorID: flyerModel.authorID,
          flyerShowsAuthor: flyerModel.showsAuthor,
          // opacity: 1,
          // onTap: ,
        ),

        StaticFooter(
          flyerBoxWidth: flyerBoxWidth,
          isSaved: true,
          onMoreTap: (){
            blog('fukk');
          },
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
