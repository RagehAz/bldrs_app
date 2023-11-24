import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/z_new_slide_image_picker_button.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class AddSlidesButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddSlidesButton({
    required this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<PicMakerType> onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    final double _flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(
      flyerBoxWidth: _flyerBoxWidth,
    );
    // --------------------
    return Container(
      width: _flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(),
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
            alignment: BldrsAligners.superCenterAlignment(context),
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
                        id: 'phid_camera',
                        translate: true,
                      ),
                      icon: Iconz.camera,
                      isTopBox: true,
                      onTap: () => onTap(PicMakerType.cameraImage),
                    ),

                    /// GALLERY
                    NewSlideImagePickerButton(
                      line: const Verse(
                        id: 'phid_gallery',
                        translate: true,
                      ),
                      icon: Iconz.phoneGallery,
                      isTopBox: false,
                      onTap: () => onTap(PicMakerType.galleryImage),
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
