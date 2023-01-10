// import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/c_footer_shadow.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/b_slide_box.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/d_slide_shadow.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/e_slide_headline.dart';
// import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
// import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
// import 'package:bldrs/b_views/z_components/images/super_filter/super_filtered_image.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:flutter/material.dart';
//
// class StaticLightSlide extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const StaticLightSlide({
//     @required this.flyerBoxWidth,
//     @required this.slideModel,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final SlideModel slideModel;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double flyerBoxHeight = FlyerDim.flyerHeightByFlyerWidth(context, flyerBoxWidth);
//     final bool tinyMode = FlyerDim.isTinyMode(context, flyerBoxWidth);
//     // --------------------
//     return SlideBox(
//       key: const ValueKey<String>('SingleSlideBox'),
//       flyerBoxWidth: flyerBoxWidth,
//       flyerBoxHeight: flyerBoxHeight,
//       tinyMode: tinyMode,
//       slideMidColor: slideModel?.midColor,
//       // shadowIsOn: false,
//       stackChildren: <Widget>[
//
//         // BldrsImagePathToUiImage(
//         //   imagePath: slideModel?.picPath,
//         //   builder: (bool isLoading, ui.Image image){
//         //
//         //     return SuperFilteredImage(
//         //       width: flyerBoxWidth,
//         //       height: flyerBoxHeight,
//         //       pic: image,
//         //       filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
//         //       boxFit: slideModel?.picFit ?? BoxFit.cover,
//         //     );
//         //
//         //   },
//         // ),
//
//         SuperFilteredImage(
//           width: flyerBoxWidth,
//           height: flyerBoxHeight,
//           pic: slideModel?.uiImage,
//           filterModel: ImageFilterModel.getFilterByID(slideModel?.filterID),
//           boxFit: slideModel?.picFit ?? BoxFit.cover,
//         ),
//
//         /// SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
//         SlideShadow(
//           key: const ValueKey<String>('SingleSlideShadow'),
//           flyerBoxWidth: flyerBoxWidth,
//         ),
//
//         /// BOTTOM SHADOW
//         FooterShadow(
//           key: const ValueKey<String>('FooterShadow'),
//           flyerBoxWidth: flyerBoxWidth,
//         ),
//
//         /// HEADLINE
//         SlideHeadline(
//           key: const ValueKey<String>('SlideHeadline'),
//           flyerBoxWidth: flyerBoxWidth,
//           verse: Verse(
//             text: slideModel?.headline,
//             translate: false,
//           ),
//         ),
//
//       ],
//     );
//     // --------------------
//   }
// /// --------------------------------------------------------------------------
// }
