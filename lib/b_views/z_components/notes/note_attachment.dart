import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/notes/notification_flyers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/components/note_image_banner.dart';
import 'package:flutter/material.dart';

class NoteAttachment extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteAttachment({
    @required this.noteModel,
    @required this.boxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteModel noteModel;
  final double boxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (noteModel?.attachmentType == NoteAttachmentType.bzID){

      return FutureBuilder<BzModel>(
        key: ValueKey<String>('noteCard_${noteModel.id}'),
        future: BzzProvider.proFetchBzModel(
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

    else if (noteModel?.attachmentType == NoteAttachmentType.flyersIDs){

      return FutureBuilder<List<FlyerModel>>(
          future: FlyersProvider.proFetchFlyers(
            context: context,
            flyersIDs: noteModel.attachment,
          ),
          builder: (_, AsyncSnapshot snap){

            final List<FlyerModel> _flyers = snap.data;

            return NotificationFlyers(
              bodyWidth: boxWidth,
              flyers: _flyers,
            );

          }
      );

    }

    else if (noteModel?.attachmentType == NoteAttachmentType.imageURL){

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
}
