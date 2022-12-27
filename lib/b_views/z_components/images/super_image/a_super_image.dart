// import 'package:bldrs/b_views/z_components/images/super_image/b_super_image_box.dart';
// import 'package:bldrs/b_views/z_components/images/super_image/c_image_switcher.dart';
// import 'package:flutter/material.dart';
//
// class SuperImage extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SuperImage({
//     @required this.width,
//     @required this.height,
//     @required this.pic,
//     this.fit = BoxFit.cover,
//     this.scale = 1,
//     this.iconColor,
//     this.loading = false,
//     this.backgroundColor,
//     this.corners,
//     this.greyscale = false,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final dynamic pic;
//   final double width;
//   final double height;
//   final BoxFit fit;
//   final double scale;
//   final Color iconColor;
//   final bool loading;
//   final Color backgroundColor;
//   final dynamic corners;
//   final bool greyscale;
//   /// --------------------------------------------------------------------------
//   static DecorationImage decorationImage({
//     @required String picture,
//     BoxFit boxFit
//   }) {
//     DecorationImage _image;
//
//     if (picture != null && picture != '') {
//       _image = DecorationImage(
//         image: AssetImage(picture),
//         fit: boxFit ?? BoxFit.cover,
//       );
//     }
//
//     return picture == '' ? null : _image;
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return SuperImageBox(
//       width: width,
//       height: height,
//       boxFit: fit,
//       scale: scale,
//       backgroundColor: backgroundColor,
//       corners: corners,
//       greyscale: greyscale,
//       child: ImageSwitcher(
//         width: width,
//         height: height,
//         pic: pic,
//         boxFit: fit,
//         scale: scale,
//         iconColor: iconColor,
//         loading: loading,
//         backgroundColor: backgroundColor,
//       ),
//     );
//
//   }
// // -----------------------------------------------------------------------------
// }
