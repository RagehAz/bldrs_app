import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
    @required this.picModel,
    @required this.onAddPicture,
    @required this.titleVerse,
    @required this.redDot,
    this.formKey,
    this.bubbleType = BubbleType.none,
    this.width,
    this.validator,
    this.autoValidate = true,
    this.onPicLongTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onAddPicture;
  final PicModel picModel;
  final Verse titleVerse;
  final BubbleType bubbleType;
  final bool redDot;
  final double width;
  final String Function() validator;
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  final Function onPicLongTap;
  /// --------------------------------------------------------------------------
  static BorderRadius getPicBorder ({
    @required BuildContext context,
    @required BubbleType bubbleType,
    @required double picWidth,
  }){

    final double corner = FlyerDim.logoCornerValueByLogoWidth(picWidth);

    return
      bubbleType == BubbleType.bzLogo ?
      Borderers.shapeOfLogo(
          context: context,
          corner: corner,
          zeroCornerEnIsRight: true
      )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.shapeOfLogo(
          context: context,
          corner: corner,
          zeroCornerEnIsRight: false
      )
          :
      bubbleType == BubbleType.userPic ?
      Borderers.cornerAll(context, picWidth * 0.5)
          :
      Borderers.cornerAll(context, corner);
  }
  // -----------------------------------------------------------------------------
  static const double picWidth = 100;
  static const double btZoneWidth = picWidth * 0.5;
  static const double btWidth = btZoneWidth * 0.8;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    // --------------------
    return Bubble(
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator(),
        ),
        bubbleHeaderVM: BubbleHeaderVM(
          headerWidth: _bubbleClearWidth,
          headlineVerse: titleVerse,
          redDot: redDot,
        ),
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

              /// IMAGE BALLOON
              Stack(
                children: <Widget>[

                  /// PICTURE LAYER
                  _FilePicSplitter(
                      picModel: picModel,
                      bubbleType: bubbleType,
                      picWidth: picWidth
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
                    DreamBox(
                      width: btWidth,
                      height: btWidth,
                      icon: Iconz.phoneGallery,
                      iconSizeFactor: 0.6,
                      onTap: () => onAddPicture(PicMakerType.galleryImage),
                      onLongTap: onPicLongTap,
                    ),

                    /// CAMERA BUTTON
                    DreamBox(
                      width: btWidth,
                      height: btWidth,
                      icon: Iconz.camera,
                      iconSizeFactor: 0.5,
                      onTap: () => onAddPicture(PicMakerType.cameraImage),
                    ),

                  ],
                ),
              ),

            ],
          ),

          if (validator != null)
            SuperValidator(
              width: _bubbleClearWidth,
              validator: validator,
              // autoValidate: true,
              focusNode: null,
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
    @required this.picModel,
    @required this.bubbleType,
    @required this.picWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PicModel picModel;
  final BubbleType bubbleType;
  final double picWidth;
  /// --------------------------------------------------------------------------
  static BorderRadius _getPicBorder ({
    @required BuildContext context,
    @required BubbleType bubbleType,
    @required double picWidth,
  }){

    final double corner = FlyerDim.logoCornerValueByLogoWidth(picWidth);

    return
      bubbleType == BubbleType.bzLogo ?
      Borderers.shapeOfLogo(
          context: context,
          corner: corner,
          zeroCornerEnIsRight: true
      )
          :
      bubbleType == BubbleType.authorPic ?
      Borderers.shapeOfLogo(
          context: context,
          corner: corner,
          zeroCornerEnIsRight: false
      )
          :
      bubbleType == BubbleType.userPic ?
      Borderers.cornerAll(context, picWidth * 0.5)
          :
      Borderers.cornerAll(context, corner);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _picBorders = _getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );

    if (bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic ){
      return BzLogo(
        width: picWidth,
        image: picModel,
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
        pic: picModel,
        balloonType: BalloonType.thinking,
        // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
      );
    }

    else {

      return DreamBox(
        width: picWidth,
        height: picWidth,
        icon: picModel,
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
    @required this.picModel,
    @required this.onAddPic,
    @required this.bubbleType,
    @required this.picWidth,
    @required this.onLongTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PicModel picModel;
  final ValueChanged<PicMakerType> onAddPic;
  final BubbleType bubbleType;
  final double picWidth;
  final Function onLongTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _picBorders = AddImagePicBubble.getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );

    /// PLUS ICON
    if (picModel == null){
      return DreamBox(
        height: AddImagePicBubble.picWidth,
        width: AddImagePicBubble.picWidth,
        corners: _picBorders,
        icon: Iconz.plus,
        iconSizeFactor: 0.4,
        bubble: false,
        opacity: 0.9,
        iconColor: Colorz.white255,
        onTap: () => onAddPic(PicMakerType.galleryImage),
        onLongTap: onLongTap,
      );
    }

    /// FILE SIZE
    else {

      /// SIZE IS NULL
      if (picModel?.bytes == null || picModel.bytes.length < (3 * 1024 * 1024)){
        return const SizedBox();
      }

      /// SIZE
      else {
        return Container(
          width: AddImagePicBubble.picWidth,
          height: AddImagePicBubble.picWidth,
          alignment: Aligners.superInverseBottomAlignment(context),
          child: SuperVerse(
            verse: Verse.plain('${Filers.calculateSize(picModel.bytes.length, FileSizeUnit.megaByte)} ${xPhrase( context, 'phid_mega_byte')}'),
            size: 1,
            centered: false,
            shadow: true,
            labelColor: Colorz.red255,
          ),
        );
      }

    }

  }
/// --------------------------------------------------------------------------
}

// /// TASK : @deprecated
// class OldAddImagePicBubble extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const OldAddImagePicBubble({
//     @required this.fileModel,
//     @required this.onAddPicture,
//     @required this.titleVerse,
//     @required this.redDot,
//     this.bubbleType = BubbleType.none,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final Function onAddPicture;
//   final ValueNotifier<FileModel> fileModel;
//   final String titleVerse;
//   final BubbleType bubbleType;
//   final bool redDot;
//   /// --------------------------------------------------------------------------
//   static BorderRadius _getPicBorder ({
//     @required BuildContext context,
//     @required BubbleType bubbleType,
//     @required double picWidth,
//   }){
//
//     final double corner = BzLogo.cornersValue(picWidth);
//
//     return
//       bubbleType == BubbleType.bzLogo ?
//       Borderers.superLogoShape(
//           context: context,
//           corner: corner,
//           zeroCornerEnIsRight: true
//       )
//           :
//       bubbleType == BubbleType.authorPic ?
//       Borderers.superLogoShape(
//           context: context,
//           corner: corner,
//           zeroCornerEnIsRight: false
//       )
//           :
//       bubbleType == BubbleType.userPic ?
//       Borderers.superBorderAll(context, picWidth * 0.5)
//           :
//       Borderers.superBorderAll(context, corner);
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     const double picWidth = 100;
//     const double btZoneWidth = picWidth * 0.5;
//     const double btWidth = btZoneWidth * 0.8;
//
//     final BorderRadius _picBorders = _getPicBorder(
//       context: context,
//       bubbleType: bubbleType,
//       picWidth: picWidth,
//     );
//
//     return Bubble(
//         headerViewModel: BubbleHeaderVM(
//           headlineVerse: titleVerse,
//           redDot: redDot,
//         ),
//         columnChildren: <Widget>[
//
//           /// GALLERY & DELETE LAYER
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               /// FAKE LEFT FOOTPRINT TO CENTER THE ROW IN THE MIDDLE O BUBBLE
//               const SizedBox(
//                 width: btZoneWidth,
//                 height: picWidth,
//               ),
//
//               Stack(
//                 children: <Widget>[
//
//                   /// PICTURE LAYER
//                   ValueListenableBuilder(
//                       valueListenable: fileModel,
//                       builder: (_, FileModel fileModel, Widget child){
//
//                         final dynamic pic = fileModel.file ?? fileModel.url;
//
//                         if (bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic ){
//                           return BzLogo(
//                             width: picWidth,
//                             image: pic,
//                             // margins: const EdgeInsets.all(10),
//                             corners: _picBorders,
//                             // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
//                           );
//                         }
//
//                         else if (bubbleType == BubbleType.userPic){
//
//                           return Balloona(
//                             balloonWidth: picWidth,
//                             loading: false,
//                             pic: pic,
//                             balloonType: concludeBalloonByUserStatus(UserStatus.searching),
//                             // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
//                           );
//                         }
//
//                         else {
//
//                           return DreamBox(
//                             width: picWidth,
//                             height: picWidth,
//                             icon: pic,
//                             bubble: false,
//                             // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
//                           );
//                         }
//
//
//                       }
//                   ),
//
//                   /// PLUS ICON LAYER
//                   ValueListenableBuilder(
//                     valueListenable: fileModel,
//                     builder: (_, FileModel fileModel, Widget child){
//
//                       /// PLUS ICON
//                       if (fileModel == null){
//                         return child;
//                       }
//
//                       /// FILE SIZE
//                       else {
//
//                         /// SIZE IS NULL
//                         if (fileModel.size == null || fileModel.size < (3 * 1024 * 1024)){
//                           return const SizedBox();
//                         }
//
//                         /// SIZE
//                         else {
//                           return Container(
//                             width: picWidth,
//                             height: picWidth,
//                             alignment: Aligners.superInverseBottomAlignment(context),
//                             child: SuperVerse(
//                               verse:  '${fileModel.size} ${xPhrase( context, 'phid_mb')}',
//                               size: 1,
//                               centered: false,
//                               shadow: true,
//                               labelColor: Colorz.red255,
//                             ),
//                           );
//                         }
//
//                       }
//
//                     },
//
//                     child: DreamBox(
//                       height: picWidth,
//                       width: picWidth,
//                       corners: _picBorders,
//                       icon: Iconz.plus,
//                       iconSizeFactor: 0.4,
//                       bubble: false,
//                       opacity: 0.9,
//                       iconColor: Colorz.white255,
//                       onTap: () => onAddPicture(ImagePickerType.galleryImage),
//                     ),
//
//                   )
//
//                 ],
//               ),
//
//
//               /// GALLERY & DELETE BUTTONS
//               SizedBox(
//                 width: btZoneWidth,
//                 height: picWidth,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//
//                     /// GALLERY BUTTON
//                     DreamBox(
//                       width: btWidth,
//                       height: btWidth,
//                       icon: Iconz.phoneGallery,
//                       iconSizeFactor: 0.6,
//                       onTap: () => onAddPicture(ImagePickerType.galleryImage),
//                     ),
//
//                     /// DELETE pic
//                     DreamBox(
//                       width: btWidth,
//                       height: btWidth,
//                       icon: Iconz.camera,
//                       iconSizeFactor: 0.5,
//                       onTap: () => onAddPicture(ImagePickerType.cameraImage),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//             ],
//           )
//
//         ]
//     );
//
//   }
// }
