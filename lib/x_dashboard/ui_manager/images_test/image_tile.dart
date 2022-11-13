import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ImageTile({
    @required this.pic,
    @required this.tileWidth,
    @required this.imageSize,
    @required this.text,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final dynamic pic;
  final double tileWidth;
  final Dimensions imageSize;
  final String text;
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
        onTap: () => Nav.goToNewScreen(context: context, screen: SlideFullScreen(image: pic, imageSize: imageSize)),
        child: SizedBox(
          width: tileWidth,
          height: _picHeight,
          child: Stack(
            children: <Widget>[

              SuperImage(
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
