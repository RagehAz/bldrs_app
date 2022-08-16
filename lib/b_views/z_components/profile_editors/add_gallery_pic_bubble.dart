import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

enum BubbleType {
  bzLogo,
  authorPic,
  userPic,
  none,
}

class AddImagePicBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddImagePicBubble({
    @required this.fileModel,
    @required this.onAddPicture,
    @required this.title,
    @required this.redDot,
    this.bubbleType = BubbleType.none,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onAddPicture;
  final ValueNotifier<FileModel> fileModel;
  final String title;
  final BubbleType bubbleType;
  final bool redDot;
  /// --------------------------------------------------------------------------
  static BorderRadius _getPicBorder ({
    @required BuildContext context,
    @required BubbleType bubbleType,
    @required double picWidth,
  }){

    final double corner = BzLogo.cornersValue(picWidth);

    return
      bubbleType == BubbleType.bzLogo ?
          Borderers.superLogoShape(
            context: context,
            corner: corner,
            zeroCornerEnIsRight: true
          )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.superLogoShape(
          context: context,
          corner: corner,
          zeroCornerEnIsRight: false
      )
          :
      bubbleType == BubbleType.userPic ?
      Borderers.superBorderAll(context, picWidth * 0.5)
          :
      Borderers.superBorderAll(context, corner);
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
      picWidth: picWidth,
    );

    return Bubble(
        title: title,
        redDot: redDot,
        columnChildren: <Widget>[

          /// GALLERY & DELETE LAYER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// FAKE LEFT FOOTPRINT TO CENTER THE ROW IN THE MIDDLE O BUBBLE
              const SizedBox(
                width: btZoneWidth,
                height: picWidth,
              ),

              Stack(
                children: <Widget>[

                  /// PICTURE LAYER
                  ValueListenableBuilder(
                      valueListenable: fileModel,
                      builder: (_, FileModel fileModel, Widget child){

                        final dynamic pic = fileModel.file ?? fileModel.url;

                        if (bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic ){
                          return BzLogo(
                            width: picWidth,
                            image: pic,
                            margins: const EdgeInsets.all(10),
                            corners: _picBorders,
                            // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
                          );
                        }

                        else if (bubbleType == BubbleType.userPic){

                          return Balloona(
                            balloonWidth: picWidth,
                            loading: false,
                            pic: pic,
                            balloonType: concludeBalloonByUserStatus(UserStatus.searching),
                            // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
                          );
                        }

                        else {

                          return DreamBox(
                            width: picWidth,
                            height: picWidth,
                            icon: pic,
                            bubble: false,
                            // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
                          );
                        }


                      }
                  ),

                  /// PLUS ICON LAYER
                  ValueListenableBuilder(
                    valueListenable: fileModel,
                    builder: (_, FileModel fileModel, Widget child){

                      /// PLUS ICON
                      if (fileModel == null){
                        return child;
                      }

                      /// FILE SIZE
                      else {

                        /// SIZE IS NULL
                        if (fileModel.size == null){
                          return const SizedBox();
                        }

                        /// SIZE
                        else {
                          return Container(
                            width: picWidth,
                            height: picWidth,
                            alignment: Aligners.superInverseBottomAlignment(context),
                            child: SuperVerse(
                              verse: '${fileModel.size} Mb',
                              size: 1,
                              centered: false,
                              shadow: true,
                              labelColor: Colorz.white20,
                            ),
                          );
                        }

                      }

                    },

                    child: DreamBox(
                      height: picWidth,
                      width: picWidth,
                      corners: _picBorders,
                      icon: Iconz.plus,
                      iconSizeFactor: 0.4,
                      bubble: false,
                      opacity: 0.9,
                      iconColor: Colorz.white255,
                      onTap: () => onAddPicture(ImagePickerType.galleryImage),
                    ),

                  )

                ],
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
                      onTap: () => onAddPicture(ImagePickerType.galleryImage),
                    ),

                    /// DELETE pic
                    DreamBox(
                      width: btWidth,
                      height: btWidth,
                      icon: Iconz.camera,
                      iconSizeFactor: 0.5,
                      onTap: () => onAddPicture(ImagePickerType.cameraImage),
                    ),

                  ],
                ),
              ),

            ],
          )

        ]
    );
  }
}
