import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/z_components/poster/variants/aa_bz_poster.dart';
import 'package:bldrs/z_components/poster/variants/aa_flyer_poster.dart';
import 'package:bldrs/z_components/poster/variants/aa_image_poster.dart';
import 'package:flutter/material.dart';

class PosterSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PosterSwitcher({
    required this.width,
    required this.posterType,
    required this.model,
    required this.modelHelper,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final PosterType? posterType;
  final dynamic model;
  final dynamic modelHelper; // is a secondary model like bz for a flyer attachment and slides flyer for a bz attachment
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (posterType == PosterType.flyer){
      return FlyerPoster(
        width: width,
        flyerModel: model is FlyerModel ? model : null,
        draft: model is DraftFlyer ? model : null,
        // flyerBzModel: modelHelper is BzModel ? modelHelper : null,
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
