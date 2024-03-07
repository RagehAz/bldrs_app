import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/z_new_slide_image_picker_button.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class AddPhotosButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddPhotosButton({
    required this.onTap,
    required this.isDisabled,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<MediaOrigin> onTap;
  final bool isDisabled;
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
      key: const ValueKey<String>('AddPhotosButton'),
      width: _flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(),
      margin: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: Ratioz.appBarPadding,
      ),
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

              Disabler(
                isDisabled: isDisabled,
                disabledOpacity: 0.2,
                child: SizedBox(
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
                        onTap: () => onTap(MediaOrigin.cameraImage),
                      ),

                      /// GALLERY
                      NewSlideImagePickerButton(
                        line: const Verse(
                          id: 'phid_photo',
                          translate: true,
                        ),
                        icon: Iconz.phoneGallery,
                        isTopBox: false,
                        onTap: () => onTap(MediaOrigin.galleryImage),
                      ),

                    ],
                  ),
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

class AddVideosButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AddVideosButton({
    required this.onTap,
    required this.isDisabled,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<MediaOrigin> onTap;
  final bool isDisabled;
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
      key: const ValueKey<String>('AddVideosButton'),
      width: _flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(),
      margin: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: Ratioz.appBarPadding,
      ),
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

              Disabler(
                isDisabled: isDisabled,
                disabledOpacity: 0.2,
                child: SizedBox(
                  width: DraftShelfSlide.flyerBoxWidth,
                  height: _flyerBoxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                        /// RECORD
                      NewSlideImagePickerButton(
                        line:const  Verse(
                          id: 'phid_record',
                          translate: true,
                        ),
                        icon: Iconz.recorder,
                        isTopBox: true,
                        onTap: () => onTap(MediaOrigin.cameraVideo),
                      ),

                      /// GALLERY
                      NewSlideImagePickerButton(
                        line: const Verse(
                          id: 'phid_video',
                          translate: true,
                        ),
                        icon: Iconz.video,
                        isTopBox: false,
                        onTap: () => onTap(MediaOrigin.galleryVideo),
                      ),

                    ],
                  ),
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
