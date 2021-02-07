import 'dart:io';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

enum PicOwner{
  bzLogo,
  author,
  none,
}

class AddGalleryPicBubble extends StatelessWidget {
  final Function addBtFunction;
  final File logo;
  final Function deleteLogoFunction;
  final String title;
  final PicOwner picOwner;

  AddGalleryPicBubble({
    @required this.addBtFunction,
    @required this.logo,
    @required this.deleteLogoFunction,
    this.title = '',
    this.picOwner = PicOwner.none,
  });
  @override
  Widget build(BuildContext context) {

    final double logoWidth = 100;
    final double btZoneWidth = logoWidth * 0.5;
    final double btWidth = btZoneWidth * 0.8;

    final double corner = Ratioz.ddBoxCorner12;

    BorderRadius _picBorders =
    picOwner == PicOwner.bzLogo ?
    superBorderRadius(context, corner, corner, 0, corner) :
    picOwner == PicOwner.author ?
    superBorderRadius(context, corner, 0, corner, corner) :

    superBorderRadius(context, corner, corner, corner, corner);


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
                    height: logoWidth,
                  ),

                  // --- FAKE FOOTPRINT UNDER PIC
                  Container(
                    width: logoWidth*1.1,
                    height: logoWidth,
                  ),

                  // --- GALLERY & DELETE BUTTONS
                  Container(
                    width: btZoneWidth,
                    height: logoWidth,
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
                          boxFunction: addBtFunction,
                        ),

                        // --- DELETE LOGO
                        DreamBox(
                          width: btWidth,
                          height: btWidth,
                          icon: Iconz.XLarge,
                          iconSizeFactor: 0.5,
                          bubble: true,
                          boxFunction: deleteLogoFunction,
                        ),

                      ],
                    ),
                  ),

                ],
              ),

              // --- PICTURE LAYER
              GestureDetector(
                onTap: logo == null ? (){} : addBtFunction,
                child: BzLogo(
                  width: logoWidth,
                  image: logo,
                  margins: EdgeInsets.all(10),
                  corners: _picBorders,
                ),
              ),

              // --- PLUS ICON LAYER
              logo == null ?
              DreamBox(
                height: logoWidth,
                width: logoWidth,
                icon: Iconz.Plus,
                iconSizeFactor: 0.4,
                bubble: false,
                opacity: 0.9,
                iconColor: Colorz.White,
                boxFunction: addBtFunction,
              ) : Container(),

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
