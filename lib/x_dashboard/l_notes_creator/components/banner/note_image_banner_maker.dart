import 'dart:io';

import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_poster_box.dart';
import 'package:flutter/material.dart';

class NoteImagePosterMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteImagePosterMaker({
    @required this.width,
    @required this.file,
    Key key
  }) : super(key: key);
  // --------------------
  final double width;
  final File file;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _posterHeight = NotePosterBox.getBoxHeight(width);

    return NotePosterBox(
      width: width,
      child: SuperImage(
        width: width,
        height: _posterHeight,
        pic: file,
        // corners: NoteBannerBox.getCorners(
        //   context: context,
        //   boxWidth: width,
        // ),
      )

    );
  }
  // -----------------------------------------------------------------------------
}
