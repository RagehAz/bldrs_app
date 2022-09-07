import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/notes/note_card.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class NoteImageBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoteImageBanner({
    @required this.width,
    @required this.height,
    @required this.attachment,
    @required this.onDelete,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final dynamic attachment;
  final Function onDelete;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, NoteCard.bannerCorners),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            SizedBox(
              width: width,
              height: height,
              child: SuperImage(
                pic: attachment,
                // boxFit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),

            if (onDelete != null)
              Align(
                alignment: Aligners.superBottomAlignment(context),
                child: DreamBox(
                  height: Ratioz.appBarButtonSize,
                  width: Ratioz.appBarButtonSize,
                  icon: Iconz.xLarge,
                  iconSizeFactor: 0.5,
                  color: Colorz.black255,
                  margins: const EdgeInsets.all(Ratioz.appBarPadding),
                  onTap: onDelete,
                ),
              ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
