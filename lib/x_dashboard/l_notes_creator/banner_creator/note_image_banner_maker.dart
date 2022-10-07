import 'dart:io';

import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/notes/banner/note_banner_box.dart';
import 'package:flutter/material.dart';

class NoteImageBannerMaker extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteImageBannerMaker({
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

    final double _bannerHeight = NoteBannerBox.getBoxHeight(width);

    return NoteBannerBox(
      width: width,
      child: SuperImage(
        width: width,
        height: _bannerHeight,
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
