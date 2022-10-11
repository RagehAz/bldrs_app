import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_flyer_poster.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_bz_poster.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_image_poster.dart';
import 'package:flutter/material.dart';

class NotePoster extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePoster({
    @required this.width,
    @required this.posterType,
    @required this.model,
    @required this.modelHelper,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final PosterType posterType;
  final dynamic model;
  final dynamic modelHelper; // is a secondary model like bz for a flyer attachment and slides flyer for a bz attachment
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (posterType == PosterType.flyer){
      return FlyerPoster(
        width: width,
        flyerModel: model,
        flyerBzModel: modelHelper,
        screenName: 'NotePoster',
      );
    }

    else if (posterType == PosterType.bz){
      return BzPoster(
        width: width,
        bzModel: model,
        bzSlidesInOneFlyer: modelHelper,
        screenName: 'NotePoster',
      );
    }

    else if (
    posterType == PosterType.url
    ||
    posterType == PosterType.cameraImage
    ||
    posterType == PosterType.galleryImage
    ){
      return ImagePoster(
        width: width,
        pic: model,
      );
    }

    else {
      return const SizedBox();
    }

  }
  /// --------------------------------------------------------------------------
}
