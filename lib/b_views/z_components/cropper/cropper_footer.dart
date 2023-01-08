import 'dart:typed_data';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/material.dart';

class CropperFooter extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const CropperFooter({
    @required this.currentImageIndex,
    @required this.onCropImages,
    @required this.bytezz,
    @required this.onImageTap,
    @required this.aspectRatio,
    @required this.screenHeight,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final ValueNotifier<int> currentImageIndex;
  final Function onCropImages;
  final List<Uint8List> bytezz;
  final ValueChanged<int> onImageTap;
  final double aspectRatio;
  final double screenHeight;
  // --------------------
  static const double imagesSpacing = 5;
  // --------------------
  static double getMiniImageHeight(){
    const double _imagesFooterHeight = Ratioz.horizon;
    return _imagesFooterHeight - (imagesSpacing * 2);
  }
  // --------------------
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
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    const double _imagesFooterHeight = Ratioz.horizon;
    // --------------------
    final double _miniImageHeight = getMiniImageHeight();
    final double _miniImageWidth = getMiniImagesWidth(
      aspectRatio: aspectRatio,
    );
    // --------------------
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
                  itemCount: bytezz.length,
                  padding: Scale.superInsets(context: context, enRight: _screenWidth * 0.5),
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
                            borderRadius: FlyerDim.flyerCorners(context, _miniImageWidth),
                            border: _isSelected == true ? Border.all(color: Colorz.white200) : null,
                          ),
                          child: OldSuperImage(
                            width: _miniImageWidth,
                            height: _miniImageWidth,
                            pic: bytezz[index],
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
        child: ConfirmButton(
          confirmButtonModel: ConfirmButtonModel(
            firstLine: const Verse(
              text: 'phid_crop_images',
              translate: true,
            ),
            onTap: onCropImages,
          ),
          positionedAlignment: Alignment.bottomRight,
        ),
      ),

    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
