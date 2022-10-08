import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:flutter/material.dart';

class NoteAttachment extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteAttachment({
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

    return const SizedBox();
    /*
    if (noteModel?.posterType == NoteAttachmentType.bz){

      return FutureBuilder<BzModel>(
        key: ValueKey<String>('noteCard_${noteModel.id}'),
        future: BzProtocols.fetchBz(
            context: context,
          bzID: noteModel.model,
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

    else if (noteModel?.posterType == NoteAttachmentType.flyer){

      return FutureBuilder<List<FlyerModel>>(
          future: FlyerProtocols.fetchFlyers(
            context: context,
            flyersIDs: noteModel.model,
          ),
          builder: (_, AsyncSnapshot snap){

            final List<FlyerModel> _flyers = snap.data;

            return NotificationFlyers(
              noteID: noteModel.id,
              bodyWidth: boxWidth,
              flyers: _flyers,
              canOpenFlyer: canOpenFlyer,
            );

          }
      );

    }

    else if (noteModel?.posterType == NoteAttachmentType.image){

      return NoteImageBanner(
        width: boxWidth,
        height: 300,
        attachment: noteModel.model,
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

     */
  }
/// --------------------------------------------------------------------------
}
