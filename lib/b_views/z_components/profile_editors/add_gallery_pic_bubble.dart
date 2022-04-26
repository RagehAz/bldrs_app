import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

enum BubbleType {
  bzLogo,
  authorPic,
  userPic,
  none,
}

class AddGalleryPicBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddGalleryPicBubble({
    @required this.picture,
    @required this.onAddPicture,
    @required this.onDeletePicture,
    this.title = '',
    this.bubbleType = BubbleType.none,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onAddPicture;
  final ValueNotifier<dynamic> picture; /// p
  final Function onDeletePicture;
  final String title;
  final BubbleType bubbleType;
  /// --------------------------------------------------------------------------
  static BorderRadius _getPicBorder ({
    @required BuildContext context,
    @required BubbleType bubbleType,
    @required double corner,
  }){
    return
      bubbleType == BubbleType.bzLogo ?
      Borderers.superBorderOnly(
          context: context,
          enTopLeft: corner,
          enBottomLeft: corner,
          enBottomRight: 0,
          enTopRight: corner
      )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.superBorderOnly(
        context: context,
        enTopLeft: corner,
        enBottomLeft: 0,
        enBottomRight: corner,
        enTopRight: corner,
      )
          :
      Borderers.superBorderOnly(
        context: context,
        enTopLeft: corner,
        enBottomLeft: corner,
        enBottomRight: corner,
        enTopRight: corner,
      );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double picWidth = 100;
    const double btZoneWidth = picWidth * 0.5;
    const double btWidth = btZoneWidth * 0.8;

    final BorderRadius _picBorders = _getPicBorder(
      context: context,
      bubbleType: bubbleType,
      corner: Ratioz.boxCorner12,
    );

    return Bubble(
        centered: true,
        columnChildren: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// GALLERY & DELETE LAYER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  /// FAKE LEFT FOOTPRINT TO CENTER THE ROW IN THE MIDDLE O BUBBLE
                  const SizedBox(
                    width: btZoneWidth,
                    height: picWidth,
                  ),

                  /// FAKE FOOTPRINT UNDER PIC
                  const SizedBox(
                    width: picWidth * 1.1,
                    height: picWidth,
                  ),

                  /// GALLERY & DELETE BUTTONS
                  SizedBox(
                    width: btZoneWidth,
                    height: picWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                        /// GALLERY BUTTON
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.phoneGallery,
                          iconSizeFactor: 0.6,
                          onTap: onAddPicture,
                        ),

                        /// DELETE pic
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.xLarge,
                          iconSizeFactor: 0.5,
                          onTap: onDeletePicture,
                        ),

                      ],
                    ),
                  ),
                ],
              ),

              /// PICTURE LAYER
              ValueListenableBuilder(
                  valueListenable: picture,
                  builder: (_, dynamic pic, Widget child){

                    return GestureDetector(
                      onTap: pic == null ? () {} : onAddPicture,
                      child: bubbleType == BubbleType.bzLogo
                          ||
                          bubbleType == BubbleType.authorPic ?
                      BzLogo(
                        width: picWidth,
                        image: pic,
                        margins: const EdgeInsets.all(10),
                        corners: _picBorders,
                      )
                          :
                      bubbleType == BubbleType.userPic ?
                      Balloona(
                        balloonWidth: picWidth,
                        loading: false,
                        pic: pic,
                        userStatus: UserStatus.searching,
                      )
                          :
                      DreamBox(
                        width: picWidth,
                        height: picWidth,
                        icon: pic,
                        bubble: false,
                      ),

                    );

                  }
              ),

              /// PLUS ICON LAYER
              ValueListenableBuilder(
                valueListenable: picture,
                builder: (_, dynamic pic, Widget child){

                  if (pic == null){
                    return child;
                  }

                  else {
                    return const SizedBox();
                  }

                  },

                child: DreamBox(
                  height: picWidth,
                  width: picWidth,
                  icon: Iconz.plus,
                  iconSizeFactor: 0.4,
                  bubble: false,
                  opacity: 0.9,
                  iconColor: Colorz.white255,
                  onTap: onAddPicture,
                ),

              )

            ],
          ),

          /// BUBBLE TITLE
          SuperVerse(
            verse: title,
            margin: 5,
            redDot: true,
          ),

        ]
    );
  }
}
