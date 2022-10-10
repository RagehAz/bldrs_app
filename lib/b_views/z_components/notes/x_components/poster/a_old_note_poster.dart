import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_old_flyers_poster.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/poster/aa_image_poster_2.dart';
import 'package:flutter/material.dart';

class OLDNotePoster extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OLDNotePoster({
    @required this.noteModel,
    @required this.boxWidth,
    @required this.canOpenFlyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  final double boxWidth;
  final bool canOpenFlyer;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    if (noteModel?.poster == null){
      return const SizedBox();
    }

    else {

      if (noteModel.poster.type == PosterType.bz){

        return FutureBuilder<BzModel>(
            key: ValueKey<String>('noteCard_${noteModel.id}'),
            future: BzProtocols.fetchBz(
              context: context,
              bzID: noteModel.poster.id,
            ),
            builder: (_, AsyncSnapshot<Object> snap){

              final BzModel _bzModel = snap.data;

              if (_bzModel == null){
                return const SizedBox();
              }

              else {
                return BzBanner(
                  boxWidth: boxWidth,
                  boxHeight: boxWidth,
                  bzModel: _bzModel,
                  bigName: false,
                );

              }

            }
        );
      }

      else if (noteModel.poster.type == PosterType.flyer){

        return FutureBuilder<FlyerModel>(
            future: FlyerProtocols.fetchFlyer(
              context: context,
              flyerID: noteModel.poster.id,
            ),
            builder: (_, AsyncSnapshot snap){

              final FlyerModel _flyer = snap.data;

              return OldFlyersPoster(
                noteID: noteModel.id,
                bodyWidth: boxWidth,
                flyers: [_flyer],
                canOpenFlyer: canOpenFlyer,
              );

            }
        );

      }

      else if (noteModel.poster.type == PosterType.image){

        return NoteImagePoster(
          width: boxWidth,
          height: 300,
          attachment: noteModel.poster.id,
          onDelete: null,
        );

      }

      // BldrsWelcomeBanner(
      //   width: _bodyWidth,
      //   corners: _bannerCorner,
      // ),

      else {
        return const SizedBox();
      }

    }

  }
/// --------------------------------------------------------------------------
}
