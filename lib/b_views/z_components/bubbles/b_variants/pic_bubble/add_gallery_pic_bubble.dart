// ignore_for_file: unused_element
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/files/file_size_unit.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

enum BubbleType {
  bzLogo,
  authorPic,
  userPic,
  none,
}

class AddImagePicBubble extends StatelessWidget {
  // --------------------------------------------------------------------------
  const AddImagePicBubble({
    required this.picModel,
    required this.onAddPicture,
    required this.titleVerse,
    required this.redDot,
    this.formKey,
    this.bubbleType = BubbleType.none,
    this.width,
    this.validator,
    this.autoValidate = true,
    this.onPicLongTap,
    this.bulletPoints,
    super.key
  });
  // --------------------
  final ValueChanged<PicMakerType>? onAddPicture;
  final PicModel? picModel;
  final Verse titleVerse;
  final BubbleType bubbleType;
  final bool redDot;
  final double? width;
  final String? Function()? validator;
  final GlobalKey<FormState>? formKey;
  final bool autoValidate;
  final Function? onPicLongTap;
  final List<Verse>? bulletPoints;
  // --------------------
  static BorderRadius getPicBorder ({
    required BuildContext context,
    required BubbleType bubbleType,
    required double picWidth,
  }){

    final double corner = FlyerDim.logoCornerValueByLogoWidth(picWidth);

    return
      bubbleType == BubbleType.bzLogo ?
      Borderers.shapeOfLogo(
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          corner: corner,
          // zeroCornerEnIsRight: true
      )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.shapeOfLogo(
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          corner: corner,
          zeroCornerEnIsRight: false
      )
          :
      bubbleType == BubbleType.userPic ?
      Borderers.cornerAll(picWidth * 0.5)
          :
      Borderers.cornerAll(corner);
  }
  // --------------------
  static const double picWidth = 100;
  static const double btZoneWidth = picWidth * 0.5;
  static const double btWidth = btZoneWidth * 0.8;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context: context);
    // --------------------
    return Bubble(
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator?.call(),
        ),
        bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          headerWidth: _bubbleClearWidth,
          headlineVerse: titleVerse,
          redDot: redDot,
        ),
        columnChildren: <Widget>[

          if (Lister.checkCanLoop(bulletPoints) == true)
          BldrsBulletPoints(
            bulletPoints: bulletPoints,
            showBottomLine: false,
          ),

          /// GALLERY & DELETE LAYER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// FAKE LEFT FOOTPRINT TO CENTER THE ROW IN THE MIDDLE O BUBBLE
              const SizedBox(
                width: btZoneWidth,
                height: picWidth,
              ),

              /// IMAGE BALLOON
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[

                  /// PICTURE LAYER
                  _FilePicSplitter(
                    picModel: picModel,
                    bubbleType: bubbleType,
                    picWidth: picWidth,

                  ),

                  /// PLUS ICON LAYER
                  _PlusIconLayer(
                    picModel: picModel,
                    bubbleType: bubbleType,
                    onAddPic: onAddPicture,
                    picWidth: picWidth,
                    onLongTap: onPicLongTap,
                  ),

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
                    BldrsBox(
                      width: btWidth,
                      height: btWidth,
                      icon: Iconz.phoneGallery,
                      iconSizeFactor: 0.6,
                      onTap: () => onAddPicture?.call(PicMakerType.galleryImage),
                      onLongTap: onPicLongTap,
                    ),

                    /// CAMERA BUTTON
                    BldrsBox(
                      width: btWidth,
                      height: btWidth,
                      icon: Iconz.camera,
                      iconSizeFactor: 0.5,
                      onTap: () => onAddPicture?.call(PicMakerType.cameraImage),
                    ),

                  ],
                ),
              ),

            ],
          ),

          if (validator != null)
            BldrsValidator(
              width: _bubbleClearWidth,
              validator: validator,
            ),

        ]
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}

class _FilePicSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _FilePicSplitter({
    required this.picModel,
    required this.bubbleType,
    required this.picWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PicModel? picModel;
  final BubbleType bubbleType;
  final double picWidth;
  /// --------------------------------------------------------------------------
  static BorderRadius _getPicBorder ({
    required BuildContext context,
    required BubbleType bubbleType,
    required double picWidth,
  }){

    final double corner = FlyerDim.logoCornerValueByLogoWidth(picWidth);

    return
      bubbleType == BubbleType.bzLogo ?
      Borderers.shapeOfLogo(
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          corner: corner,
          // zeroCornerEnIsRight: true
      )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.shapeOfLogo(
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          corner: corner,
          zeroCornerEnIsRight: false
      )
          :
      bubbleType == BubbleType.userPic ?
      Borderers.cornerAll(picWidth * 0.5)
          :
      Borderers.cornerAll(corner);
  }
  // -----------------------------------------------------------------------------
  static dynamic getPic(PicModel? pic){
    dynamic _output;

    if (pic != null && pic.path != Iconz.anonymousUser){
      _output = pic.bytes ?? pic.path;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // picModel?.blogPic(invoker: 'what the pic');

    final BorderRadius _picBorders = _getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );
    final dynamic _pic = getPic(picModel);

    if (bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic){
      return BzLogo(
        width: picWidth,
        image: _pic,
        isVerified: false,
        // margins: const EdgeInsets.all(10),
        corners: _picBorders,
        // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
      );
    }

    else if (bubbleType == BubbleType.userPic){

      return Balloona(
        size: picWidth,
        loading: false,
        pic: _pic,
        balloonType: BalloonType.thinking,
        // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
      );
    }

    else {

      return BldrsBox(
        width: picWidth,
        height: picWidth,
        icon: _pic,
        bubble: false,
        // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
      );
    }

  }
  // -----------------------------------------------------------------------------
}

class _PlusIconLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PlusIconLayer({
    required this.picModel,
    required this.onAddPic,
    required this.bubbleType,
    required this.picWidth,
    required this.onLongTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PicModel? picModel;
  final ValueChanged<PicMakerType>? onAddPic;
  final BubbleType bubbleType;
  final double picWidth;
  final Function? onLongTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _picBorders = AddImagePicBubble.getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );

    picModel?.blogPic(invoker: 'what the pic');

    /// PLUS ICON
    if (picModel == null || picModel?.path == Iconz.anonymousUser){
      return BldrsBox(
        height: AddImagePicBubble.picWidth,
        width: AddImagePicBubble.picWidth,
        corners: _picBorders,
        icon: Iconz.plus,
        iconSizeFactor: 0.4,
        bubble: false,
        opacity: 0.9,
        iconColor: Colorz.white255,
        color: Colorz.white20,
        onTap: () => onAddPic?.call(PicMakerType.galleryImage),
        onLongTap: onLongTap,
      );
    }

    /// FILE SIZE
    else {

      /// SIZE IS NULL
      if (picModel?.bytes == null){
        return const SizedBox();
      }

      /// SIZE
      else {

        final bool _isExceedingMaxSize = (picModel?.bytes?.length ?? 0) > (3 * 1024 * 1024);

        return SizedBox(
          width: AddImagePicBubble.picWidth,
          height: AddImagePicBubble.picWidth,
          // alignment: BldrsAligners.superInverseBottomAlignment(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

              BldrsText(
                width: AddImagePicBubble.picWidth * 0.6,
                verse: Verse.plain('${Filers.calculateSize(picModel?.bytes?.length, FileSizeUnit.megaByte)} Mb'),
                size: 1,
                shadow: true,
                labelColor: _isExceedingMaxSize ? Colorz.red255 : Colorz.black150,
                maxLines: 2,
                // textDirection: TextDirection.ltr,
                margin: 0,
              ),

            ],
          ),
        );
      }
    }

  }
  /// --------------------------------------------------------------------------
}
