import 'package:bldrs/b_views/widgets/general/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:flutter/material.dart';

class QuestionPictureThumbnail extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionPictureThumbnail({
    @required this.picture,
    @required this.picHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String picture;
  final double picHeight;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, 10),
        child: SuperImage(
          height: picHeight,
          pic: picture,
        ),
      ),
    );

  }
}
