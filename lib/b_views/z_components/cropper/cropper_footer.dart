import 'dart:io';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/cropping_screen.dart';
import 'package:flutter/material.dart';

class CropperFooter extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const CropperFooter({
    @required this.currentImageIndex,
    @required this.onCropImages,
    @required this.files,
    @required this.onImageTap,
    @required this.aspectRatio,
    @required this.screenHeight,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final ValueNotifier<int> currentImageIndex;
  final Function onCropImages;
  final List<File> files;
  final ValueChanged<int> onImageTap;
  final double aspectRatio;
  final double screenHeight;
  /// -----------------------------------------------------------------------------
  static const double imagesSpacing = 5;
// -----------------------------------------------------------------------------
  static double getMiniImageHeight(){
    final double _imagesFooterHeight = CroppingScreen.getFooterHeight();
    return _imagesFooterHeight - (imagesSpacing * 2);
  }
// -----------------------------------------------------------------------------
  static double getMiniImagesWidth({
  @required double aspectRatio,
}){
    final double _miniImageHeight = getMiniImageHeight();
    final double _miniImageWidth = _miniImageHeight * aspectRatio;
    return _miniImageWidth;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _imagesFooterHeight = CroppingScreen.getFooterHeight();

    final double _miniImageHeight = getMiniImageHeight();
    final double _miniImageWidth = getMiniImagesWidth(
      aspectRatio: aspectRatio,
    );

    return Container(
      width: _screenWidth,
      height: _imagesFooterHeight,
      alignment: Alignment.bottomLeft,
      child: ValueListenableBuilder(
        valueListenable: currentImageIndex,
        builder: (_, int imageIndex, Widget confirmButton){

          return Stack(
            children: <Widget>[

              /// MINI PICTURES
              SizedBox(
                width: _screenWidth,
                height: _imagesFooterHeight,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  itemBuilder: (_, int index){

                    final bool _isSelected = imageIndex == index;

                    return GestureDetector(
                      onTap: () => onImageTap(index),
                      child: Center(
                        child: Container(
                          width: _miniImageWidth,
                          height: _miniImageHeight,
                          margin: Scale.superInsets(context: context, enRight: 5),
                          decoration: BoxDecoration(
                            color: _isSelected == true ? Colorz.white125 : Colorz.white50,
                            borderRadius: FlyerBox.corners(context, _miniImageWidth),
                            border: _isSelected == true ? Border.all(color: Colorz.white200) : null,
                          ),
                          child: SuperImage(
                            width: _miniImageWidth,
                            height: _miniImageWidth,
                            pic: files[index],
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),

              /// CONFIRM BUTTON
              confirmButton,

            ],
          );

        },
        child: EditorConfirmButton(
          positionedAlignment: Alignment.bottomRight,
          firstLine: 'Crop Images',
          onTap: onCropImages,
        ),
      ),

    );

  }
}
