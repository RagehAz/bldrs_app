import 'package:bldrs/controllers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/images/super_image.dart';
import 'package:bldrs/views/widgets/specific/notifications/notification_card.dart';
import 'package:flutter/material.dart';

class NotiBannerEditor extends StatelessWidget {
  final double width;
  final double height;
  final dynamic attachment;
  final Function onDelete;

  const NotiBannerEditor({
    @required this.width,
    @required this.height,
    @required this.attachment,
    @required this.onDelete,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: Borderers.superBorderAll(context, NotificationCard.bannerCorners),
        child: Stack(
          children: <Widget>[

            SuperImage(
              attachment,
              fit: BoxFit.fitWidth,
              width: width,
              height: height,
            ),

            if (onDelete != null)
            Align(
              alignment: Aligners.superBottomAlignment(context),
              child: DreamBox(
                height: Ratioz.appBarButtonSize,
                width: Ratioz.appBarButtonSize,
                icon: Iconz.XLarge,
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
}
