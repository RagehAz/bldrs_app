import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/poster/structure/x_note_poster_box.dart';
import 'package:flutter/material.dart';

class ImagePoster extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ImagePoster({
    required this.width,
    required this.pic,
    super.key
  });
  // --------------------
  final double width;
  final dynamic pic;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _posterHeight = NotePosterBox.getBoxHeight(width);

    return NotePosterBox(
      width: width,
      child: BldrsImage(
        width: width,
        height: _posterHeight,
        pic: pic,
        // corners: NoteBannerBox.getCorners(
        //   context: context,
        //   boxWidth: width,
        // ),
      )

    );
  }
  // -----------------------------------------------------------------------------
}
