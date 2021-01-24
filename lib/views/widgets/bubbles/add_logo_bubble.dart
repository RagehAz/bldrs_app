import 'dart:io';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AddLogoBubble extends StatelessWidget {
  final Function addBtFunction;
  final File logo;
  final Function deleteLogoFunction;

  AddLogoBubble({
    @required this.addBtFunction,
    @required this.logo,
    @required this.deleteLogoFunction,
  });
  @override
  Widget build(BuildContext context) {

    final double logoWidth = 100;
    final double btZoneWidth = logoWidth * 0.5;
    final double btWidth = btZoneWidth * 0.8;

    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        centered: true,
        columnChildren: <Widget>[

          Stack(
            alignment: Alignment.center,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Container(
                    width: btZoneWidth,
                    height: logoWidth,
                  ),

                  Container(
                    width: logoWidth*1.1,
                    height: logoWidth,
                  ),

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

              GestureDetector(
                onTap: logo == null ? (){} : addBtFunction,
                child: BzLogo(
                  width: logoWidth,
                  image: logo,
                  margins: EdgeInsets.all(10),
                ),
              ),

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

          SuperVerse(
            verse: Wordz.businessLogo(context) ,
            centered: true,
            margin: 5,
          ),

        ]
    );
  }
}
