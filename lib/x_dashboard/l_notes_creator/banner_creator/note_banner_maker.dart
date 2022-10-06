import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/banner_creator/note_bz_banner_maker.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/banner_creator/note_flyer_banner_maker.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/banner_creator/note_image_banner_maker.dart';
import 'package:flutter/material.dart';

class NoteBannerMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteBannerMaker({
    @required this.width,
    @required this.attachmentType,
    @required this.attachment,
    @required this.attachmentHelper,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double width;
  final NoteAttachmentType attachmentType;
  final dynamic attachment;
  final dynamic attachmentHelper; // is a secondary model like bz for a flyer attachment and slides flyer for a bz attachment
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (attachmentType == NoteAttachmentType.flyer){
      return NoteFlyerBannerMaker(
        width: width,
        flyerModel: attachment,
        flyerBzModel: attachmentHelper,
      );
    }

    else if (attachmentType == NoteAttachmentType.bz){
      return NoteBzBannerMaker(
        width: width,
        bzModel: attachment,
        bzSlidesInOneFlyer: attachmentHelper,
      );
    }

    else if (attachmentType == NoteAttachmentType.image){
      return NoteImageBannerMaker(
        width: width,
        file: attachment,
      );
    }
    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
