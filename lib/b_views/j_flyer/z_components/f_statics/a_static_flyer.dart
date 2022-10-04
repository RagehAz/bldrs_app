import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/a_single_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/d_static_footer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

class StaticFlyer extends StatelessWidget {

  const StaticFlyer({
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);

  final FlyerModel flyerModel;
  final double flyerBoxWidth;

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: BzProtocols.fetchBz(context: context, bzID: flyerModel?.bzID),
        builder: (_, AsyncSnapshot<BzModel> snap){

        final BzModel bzModel = snap.data;

        if (Streamer.connectionIsLoading(snap) == true){
          return FlyerBox(
            flyerBoxWidth: flyerBoxWidth,
          );
        }
        else {
          return FlyerBox(
            key: const ValueKey<String>('StaticFlyer'),
            flyerBoxWidth: flyerBoxWidth,
            stackWidgets: <Widget>[

              /// STATIC SINGLE SLIDE
              SingleSlide(
                flyerBoxWidth: flyerBoxWidth,
                flyerBoxHeight: FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth),
                slideModel: flyerModel.slides[0],
                tinyMode: false,
                onSlideNextTap: null,
                onSlideBackTap: null,
                onDoubleTap: null,
              ),

              /// STATIC HEADER
              StaticHeader(
                flyerBoxWidth: flyerBoxWidth,
                bzModel: bzModel,
                authorID: flyerModel?.authorID,
                flyerShowsAuthor: flyerModel?.showsAuthor,
                flightTweenValue: 0,
              ),

              /// STATIC FOOTER
              StaticFooter(
                flyerBoxWidth: flyerBoxWidth,
                isSaved: true,
                flightTweenValue: 0,
                // showHeaderLabels: false,
              ),

            ],
          );
        }

        }
    );

  }
}
