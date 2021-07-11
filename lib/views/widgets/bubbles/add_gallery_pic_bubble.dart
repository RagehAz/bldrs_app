import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

enum BubbleType{
  bzLogo,
  authorPic,
  userPic,
  none,
}

class AddGalleryPicBubble extends StatelessWidget {
  final Function addBtFunction;
  final dynamic pic;
  final Function deletePicFunction;
  final String title;
  final BubbleType bubbleType;

  AddGalleryPicBubble({
    @required this.addBtFunction,
    @required this.pic,
    @required this.deletePicFunction,
    this.title = '',
    this.bubbleType = BubbleType.none,
  });
  @override
  Widget build(BuildContext context) {

    final double picWidth = 100;
    final double btZoneWidth = picWidth * 0.5;
    final double btWidth = btZoneWidth * 0.8;

    final double corner = Ratioz.boxCorner12;

    BorderRadius _picBorders =
    bubbleType == BubbleType.bzLogo ?
    Borderers.superBorderRadius(context:context, enTopLeft:corner, enBottomLeft:corner, enBottomRight:0, enTopRight:corner)
        :
    bubbleType == BubbleType.authorPic ?
    Borderers.superBorderRadius(context: context, enTopLeft: corner, enBottomLeft: 0, enBottomRight: corner, enTopRight: corner,)
        :
    Borderers.superBorderRadius(context: context, enTopLeft: corner, enBottomLeft: corner, enBottomRight: corner, enTopRight: corner,);


    return InPyramidsBubble(
        centered: true,
        columnChildren: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              // --- GALLERY & DELETE LAYER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- FAKE LEFT FOOTPRINT TO CENTER THE ROW IN THE MIDDLE O BUBBLE
                  Container(
                    width: btZoneWidth,
                    height: picWidth,
                  ),

                  // --- FAKE FOOTPRINT UNDER PIC
                  Container(
                    width: picWidth*1.1,
                    height: picWidth,
                  ),

                  // --- GALLERY & DELETE BUTTONS
                  Container(
                    width: btZoneWidth,
                    height: picWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        // --- GALLERY BUTTON
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.PhoneGallery,
                          iconSizeFactor: 0.6,
                          bubble: true,
                          onTap: addBtFunction,
                        ),

                        // --- DELETE pic
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.XLarge,
                          iconSizeFactor: 0.5,
                          bubble: true,
                          onTap: deletePicFunction,
                        ),

                      ],
                    ),
                  ),

                ],
              ),

              // --- PICTURE LAYER
              GestureDetector(
                onTap: pic == null ? (){} : addBtFunction,
                child:

                bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic ?
                BzLogo(
                  width: picWidth,
                  image: pic,
                  margins: const EdgeInsets.all(10),
                  corners: _picBorders,
                )
                :
                bubbleType == BubbleType.userPic ?
                UserBalloon(
                  balloonWidth: picWidth,
                  loading: false,
                  pic: pic,
                  balloonType: UserStatus.SearchingThinking,
                )
                    :
                DreamBox(
                  width: picWidth,
                  height: picWidth,
                  icon: pic,
                  bubble: false,
                ),
              ),

              // --- PLUS ICON LAYER
              if (pic == null)
              DreamBox(
                height: picWidth,
                width: picWidth,
                icon: Iconz.Plus,
                iconSizeFactor: 0.4,
                bubble: false,
                opacity: 0.9,
                iconColor: Colorz.White,
                onTap: addBtFunction,
              ),

            ],
          ),

          // --- BUBBLE TITLE
          SuperVerse(
            verse: title,
            centered: true,
            margin: 5,
            redDot: true,
          ),

        ]
    );
  }
}
