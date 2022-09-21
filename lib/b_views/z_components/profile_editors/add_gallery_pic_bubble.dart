import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/b_views/z_components/balloons/balloons.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/super_text_field/super_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
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
    @required this.titleVerse,
    @required this.redDot,
    this.formKey,
    this.bubbleType = BubbleType.none,
    this.width,
    this.validator,
    this.autoValidate = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onAddPicture;
  final FileModel fileModel;
  final Verse titleVerse;
  final BubbleType bubbleType;
  final bool redDot;
  final double width;
  final String Function() validator;
  final GlobalKey<FormState> formKey;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  static BorderRadius getPicBorder ({
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
  static const double picWidth = 100;
  static const double btZoneWidth = picWidth * 0.5;
  static const double btWidth = btZoneWidth * 0.8;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _bubbleClearWidth = Bubble.clearWidth(context);
    // --------------------
    return Bubble(
        width: _screenWidth,
        bubbleColor: Formers.validatorBubbleColor(
          validator: validator == null ? null : () => validator(),
        ),
        headerViewModel: BubbleHeaderVM(
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
                      fileModel: fileModel,
                      bubbleType: bubbleType,
                      picWidth: picWidth
                  ),

                  /// PLUS ICON LAYER
                  _PlusIconLayer(
                    fileModel: fileModel,
                    bubbleType: bubbleType,
                    onAddPic: onAddPicture,
                    picWidth: picWidth,
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
          ),

          if (validator != null)
            SuperValidator(
              width: _bubbleClearWidth,
              validator: validator,
              // autoValidate: true,
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
    @required this.fileModel,
    @required this.bubbleType,
    @required this.picWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FileModel fileModel;
  final BubbleType bubbleType;
  final double picWidth;
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

    final BorderRadius _picBorders = _getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );

    final dynamic pic = fileModel?.file ?? fileModel?.url;

    if (bubbleType == BubbleType.bzLogo || bubbleType == BubbleType.authorPic ){
      return BzLogo(
        width: picWidth,
        image: pic,
        // margins: const EdgeInsets.all(10),
        corners: _picBorders,
        // onTap: () => onAddImage(ImagePickerType.galleryImage), /// no need due to tap layer below in tree
      );
    }

    else if (bubbleType == BubbleType.userPic){

      return Balloona(
        balloonWidth: picWidth,
        loading: false,
        pic: pic,
        balloonType: BalloonType.thinking,
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
// -----------------------------------------------------------------------------
}

class _PlusIconLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _PlusIconLayer({
    @required this.fileModel,
    @required this.onAddPic,
    @required this.bubbleType,
    @required this.picWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FileModel fileModel;
  final ValueChanged<ImagePickerType> onAddPic;
  final BubbleType bubbleType;
  final double picWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BorderRadius _picBorders = AddImagePicBubble.getPicBorder(
      context: context,
      bubbleType: bubbleType,
      picWidth: picWidth,
    );

    /// PLUS ICON
    if (fileModel == null){
      return DreamBox(
        height: AddImagePicBubble.picWidth,
        width: AddImagePicBubble.picWidth,
        corners: _picBorders,
        icon: Iconz.plus,
        iconSizeFactor: 0.4,
        bubble: false,
        opacity: 0.9,
        iconColor: Colorz.white255,
        onTap: () => onAddPic(ImagePickerType.galleryImage),
      );
    }

    /// FILE SIZE
    else {

      /// SIZE IS NULL
      if (fileModel.size == null || fileModel.size < (3 * 1024 * 1024)){
        return const SizedBox();
      }

      /// SIZE
      else {
        return Container(
          width: AddImagePicBubble.picWidth,
          height: AddImagePicBubble.picWidth,
          alignment: Aligners.superInverseBottomAlignment(context),
          child: SuperVerse(
            verse: Verse.plain('${fileModel.size} ${xPhrase( context, 'phid_mega_byte')}'),
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
//                               verse:  '${fileModel.size} ${xPhrase( context, '##Mb')}',
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
