import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/notes/banner/notification_flyers.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/components/note_image_banner.dart';
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

    if (noteModel?.attachmentType == NoteAttachmentType.bz){

      return FutureBuilder<BzModel>(
        key: ValueKey<String>('noteCard_${noteModel.id}'),
        future: BzProtocols.fetchBz(
            context: context,
          bzID: noteModel.attachment,
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

    else if (noteModel?.attachmentType == NoteAttachmentType.flyer){

      return FutureBuilder<List<FlyerModel>>(
          future: FlyerProtocols.fetchFlyers(
            context: context,
            flyersIDs: noteModel.attachment,
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

    else if (noteModel?.attachmentType == NoteAttachmentType.image){

      return NoteImageBanner(
        width: boxWidth,
        height: 300,
        attachment: noteModel.attachment,
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
/// --------------------------------------------------------------------------
}
