import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AddSlidesButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddSlidesButton({
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<ImagePickerType> onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth);
    // --------------------
    return Container(
      width: _flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(context),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER FOOT PRINT
          Container(
            width: _flyerBoxWidth,
            height: DraftShelfSlide.slideNumberBoxHeight,
            alignment: Aligners.superCenterAlignment(context),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// SLIDE
          FlyerBox(
            key: const ValueKey<String>('shelf_slide_flyer_box'),
            flyerBoxWidth: _flyerBoxWidth,
            boxColor: Colorz.white10,
            stackWidgets: <Widget>[

              SizedBox(
                width: DraftShelfSlide.flyerBoxWidth,
                height: _flyerBoxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    /// CAMERA
                    NewSlideImagePickerButton(
                      line:const  Verse(
                        text: 'phid_camera',
                        translate: true,
                      ),
                      icon: Iconz.camera,
                      isTopBox: true,
                      onTap: () => onTap(ImagePickerType.cameraImage),
                    ),

                    /// GALLERY
                    NewSlideImagePickerButton(
                      line: const Verse(
                        text: 'phid_gallery',
                        translate: true,
                      ),
                      icon: Iconz.phoneGallery,
                      isTopBox: false,
                      onTap: () => onTap(ImagePickerType.galleryImage),
                    ),

                  ],
                ),
              ),


            ],
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class NewSlideImagePickerButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NewSlideImagePickerButton({
    @required this.onTap,
    @required this.icon,
    @required this.line,
    @required this.isTopBox,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String icon;
  final Verse line;
  final bool isTopBox;
  /// --------------------------------------------------------------------------
  BorderRadius getBorders({
    @required BuildContext context,
    @required bool isTopBox,
  }){

    const double _spacing = 5;
    final double _topFlyerCorners = FlyerDim.flyerTopCornerValue(DraftShelfSlide.flyerBoxWidth);
    final double _bottomFlyerCorners = FlyerDim.flyerBottomCornerValue(DraftShelfSlide.flyerBoxWidth);

    final double _topCorners = _topFlyerCorners - _spacing;

    final BorderRadius _upperBoxCorners = Borderers.cornerOnly(
      context: context,
      enTopLeft: _topCorners,
      enTopRight: _topCorners,
      enBottomRight: _topCorners,
      enBottomLeft: _topCorners,
    );

    final BorderRadius _bottomBoxCorners = Borderers.cornerOnly(
      context: context,
      enTopLeft: _topCorners,
      enTopRight: _topCorners,
      enBottomRight: _bottomFlyerCorners - _spacing,
      enBottomLeft: _bottomFlyerCorners - _spacing,
    );

    return isTopBox == true ? _upperBoxCorners : _bottomBoxCorners;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, _flyerBoxWidth);
    const double _spacing = 10;
    const double _buttonWidth = _flyerBoxWidth - (_spacing * 3);
    final double _buttonHeight = (_flyerBoxHeight - (_spacing * 3)) * 0.5;
    // --------------------
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _buttonWidth,
        height: _buttonHeight,
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: getBorders(
            context: context,
            isTopBox: isTopBox,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            /// PLUS ICON
            DreamBox(
              height: _buttonHeight * 0.5,
              width: _buttonHeight * 0.5,
              icon: icon,
              iconColor: Colorz.white20,
              bubble: false,
            ),

            SizedBox(
              height: _buttonHeight * 0.05,
            ),

            SizedBox(
              width: _buttonWidth,
              child: SuperVerse(
                verse: line,
                color: Colorz.white20,
                maxLines: 2,
              ),
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
