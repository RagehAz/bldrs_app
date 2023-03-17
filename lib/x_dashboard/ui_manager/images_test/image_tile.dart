import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:layouts/layouts.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ImageTile({
    @required this.pic,
    @required this.tileWidth,
    @required this.imageSize,
    @required this.text,
    @required this.filter,
    this.title,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final dynamic pic;
  final double tileWidth;
  final Dimensions imageSize;
  final String text;
  final ImageFilterModel filter;
  final Verse title;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (pic == null){
      return const SizedBox();
    }

    else {

      final double _picHeight = Dimensions.getHeightByAspectRatio(
        width: tileWidth,
        aspectRatio: imageSize?.getAspectRatio(),
      );

      return GestureDetector(
        onTap: () => Nav.goToNewScreen(
            context: context,
            screen: SlideFullScreen(
              image: pic,
              imageSize: imageSize,
              filter: filter,
              title: title,
            ),
        ),
        child: SizedBox(
          width: tileWidth,
          height: _picHeight,
          child: Stack(
            children: <Widget>[

              BldrsImage(
                width: tileWidth,
                height: _picHeight,
                pic: pic,
              ),

              SuperVerse(
                width: tileWidth - 10,
                verse: Verse.plain(text),
                margin: 5,
                labelColor: Colorz.black200,
                maxLines: 3,
                size: 1,
              ),

            ],
          ),
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
