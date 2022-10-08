import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/banner/note_bz_banner_maker.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/banner/note_flyer_poster_maker.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/banner/note_image_banner_maker.dart';
import 'package:flutter/material.dart';

class PosterMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const PosterMaker({
    @required this.width,
    @required this.posterType,
    @required this.model,
    @required this.modelHelper,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double width;
  final PosterType posterType;
  final dynamic model;
  final dynamic modelHelper; // is a secondary model like bz for a flyer attachment and slides flyer for a bz attachment
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (posterType == PosterType.flyer){
      return NoteFlyerPosterMaker(
        width: width,
        flyerModel: model,
        flyerBzModel: modelHelper,
      );
    }

    else if (posterType == PosterType.bz){
      return NoteBzPosterMaker(
        width: width,
        bzModel: model,
        bzSlidesInOneFlyer: modelHelper,
      );
    }

    else if (posterType == PosterType.image){
      return NoteImagePosterMaker(
        width: width,
        file: model,
      );
    }
    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
