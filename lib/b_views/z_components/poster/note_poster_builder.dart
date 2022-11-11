import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/j_poster/poster_type.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/poster/variants/aa_bz_poster.dart';
import 'package:bldrs/b_views/z_components/poster/variants/aa_flyer_poster.dart';
import 'package:bldrs/b_views/z_components/poster/variants/aa_image_poster.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

class NotePosterBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotePosterBuilder({
    @required this.noteModel,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _empty = NotePosterBox(
        width: width,
    );

    /// POSTER IS NULL
    if (noteModel?.poster == null){
      return _empty;
    }

    /// POSTER STARTERS
    else {

      /// FLYER POSTER
      if (noteModel?.poster?.type == PosterType.flyer){

        return FutureBuilder(
          future: FlyerProtocols.fetchFlyer(context: context, flyerID: noteModel?.poster?.modelID),
            builder: (_, AsyncSnapshot<FlyerModel> flyerSnap){

            final FlyerModel _flyer = flyerSnap.data;

            /// LOADING OR NOT FOUND
            if (Streamer.connectionIsLoading(flyerSnap) == true || _flyer == null){
              return _empty;
            }

            /// FLYER IS FOUND
            else {

              return FutureBuilder(
                future: BzProtocols.fetch(context: context, bzID: _flyer.bzID),
                  builder: (_, AsyncSnapshot<BzModel> bzSnap){

                  final BzModel _bzModel = bzSnap.data;

                  /// LOADING
                  if (Streamer.connectionIsLoading(bzSnap) == true){
                    return _empty;
                  }

                  /// FLYER POSTER
                  else {

                    return FlyerPoster(
                      width: width,
                      flyerModel: _flyer,
                      flyerBzModel: _bzModel,
                      screenName: noteModel.id,
                    );

                  }

                  }
              );

            }

            }
        );

      }

      /// BZ POSTER
      else if (noteModel?.poster?.type == PosterType.bz){

        return FutureBuilder(
            future: BzProtocols.fetch(context: context, bzID: noteModel.poster.modelID),
            builder: (_, AsyncSnapshot<BzModel> bzSnap){

              final BzModel _bzModel = bzSnap.data;

              /// LOADING OR BZ NOT FOUND
              if (Streamer.connectionIsLoading(bzSnap) == true || _bzModel == null){
                return _empty;
              }

              /// BZ FOUND
              else {

                return FutureBuilder(
                  future: FlyerProtocols.fetchAndCombineBzSlidesInOneFlyer(
                    context: context,
                    bzModel: _bzModel,
                    maxSlides: 7,
                  ),
                  builder: (_, AsyncSnapshot<FlyerModel> flyerSnap){

                    final FlyerModel _bzSlidesInFlyer = flyerSnap.data;

                    /// LOADING
                    if (Streamer.connectionIsLoading(flyerSnap) == true){
                      return _empty;
                    }

                    /// BZ POSTER
                    else {
                      return BzPoster(
                        width: width,
                        bzModel: _bzModel,
                        bzSlidesInOneFlyer: _bzSlidesInFlyer,
                        screenName: noteModel.id,
                      );
                    }

                  },
                );

              }

            }
        );

      }

      /// IMAGE POSTER
      else if (
      noteModel?.poster?.type == PosterType.galleryImage
      ||
      noteModel?.poster?.type == PosterType.cameraImage
      ||
      noteModel?.poster?.type == PosterType.url
      ){

        return ImagePoster(
          width: width,
          pic: noteModel.poster.picModel ?? noteModel.poster.path,
        );

      }

      /// OTHERWISE
      else {
        return _empty;
      }

    }

  }
/// --------------------------------------------------------------------------
}
