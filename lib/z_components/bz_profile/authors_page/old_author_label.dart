// import 'package:bldrs/a_models/bz/author_model.dart';
// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/bz_profile/authors_page/author_pic.dart';
// import 'package:bldrs/z_components/images/bldrs_image.dart';
// import 'package:bldrs/z_components/texting/super_verse.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart';
// import 'package:basics/helpers/nums/numeric.dart';
// import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
// import 'package:basics/helpers/space/scale.dart';
// import 'package:basics/helpers/files/filers.dart';
// 
// 
//
// import 'package:flutter/material.dart';
//
// /// NEED FIXATION
// class OldAuthorLabel extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const OldAuthorLabel({
//     required this.flyerBoxWidth,
//     required this.authorID,
//     required this.bzModel,
//     required this.showLabel,
//     required this.authorGalleryCount,
//     required this.onTap,
//     this.labelIsOn = false,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final String authorID;
//   final BzModel bzModel;
//   final bool showLabel;
//   final int authorGalleryCount;
//   final bool labelIsOn;
//   final ValueChanged<String> onTap;
//
//   /// --------------------------------------------------------------------------
// // tappingAuthorLabel (){
// //     setState(() {
// //       labelIsOn == true ? labelIsOn = false : labelIsOn = true;
// //     });
// // }
//
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     // const bool _versesShadow = false;
// // -----------------------------------------------------------------------------
//     final double _headerTextSidePadding =
//         flyerBoxWidth * Ratioz.xxflyersGridSpacing;
// // -----------------------------------------------------------------------------
//     final double _authorDataHeight =
//         // flyerShowsAuthor == true ?
//         flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth
//         //     :
//         // (flyerBoxWidth * ((Ratioz.xxflyerHeaderHeight* 0.3)-(2*Ratioz.xxflyerHeaderMainPadding)) )
//         ;
// // -----------------------------------------------------------------------------
//     final double _authorDataWidth = flyerBoxWidth *
//         (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
// // -----------------------------------------------------------------------------
//     /// --- FOLLOWERS COUNTER
//     final int _followersCount = bzModel?.totalFollowers;
//     final int _bzGalleryCount = bzModel?.totalFlyers;
//
//     final String _galleryCountCalibrated = Numeric.counterCaliber(context, _bzGalleryCount);
//     final String _followersCounter =
//     (authorGalleryCount == 0 && _followersCount == 0)
//         ||
//         (authorGalleryCount == null && _followersCount == null)
//         ?
//     ''
//         :
//     showLabel == true ?
//     '${Numeric.separateKilos(number: authorGalleryCount)} '
//         '${superPhrase(context, 'phid_flyers')}'
//             :
//     '${Numeric.counterCaliber(context, _followersCount)} '
//         '${superPhrase(context, 'followers')} . '
//         '$_galleryCountCalibrated ${superPhrase(context, 'flyers')}';
// // -----------------------------------------------------------------------------
//     final double _authorImageCorners = flyerBoxWidth * Ratioz.xxflyerAuthorPicCorner;
// // -----------------------------------------------------------------------------
//     final AuthorModel _author = AuthorModel.getAuthorFromBzByAuthorID(
//         bz: bzModel,
//         authorID: authorID,
//     );
//
//     return GestureDetector(
//       onTap: showLabel == true ? () => onTap(authorID) : null,
//       child: Container(
//         height: _authorDataHeight,
//         width: labelIsOn == true ? _authorDataWidth : _authorDataHeight,
//         // margin: showLabel == true ? EdgeInsets.symmetric(horizontal : flyerBoxWidth * 0.01) : const EdgeInsets.all(0),
//         decoration: BoxDecoration(
//           color: showLabel == false ? Colorz.nothing : Colorz.white20,
//           borderRadius: Borderers.superBorderOnly(
//               context: context,
//               enTopLeft: _authorImageCorners,
//               enBottomLeft: 0,
//               enBottomRight: _authorImageCorners,
//               enTopRight: _authorImageCorners),
//         ),
//
//         child: Row(
//           children: <Widget>[
//
//             /// AUTHOR IMAGE
//             AuthorPicInBzPage(
//               width: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
//               authorPic: _author?.pic,
//               // tinyBz:
//             ),
//
//             /// AUTHOR LABEL : NAME, TITLE, FOLLOWERS COUNTER
//             if (labelIsOn == true)
//               Container(
//                 width: flyerBoxWidth * Ratioz.xxflyerAuthorNameWidth,
//                 padding: EdgeInsets.symmetric(horizontal: _headerTextSidePadding),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//
//                     /// AUTHOR NAME
//                     SuperVerse(
//                       verse: _author?.name,
//                       centered: false,
//                       scaleFactor: flyerBoxWidth / _screenWidth,
//                     ),
//
//                     /// AUTHOR TITLE
//                     SuperVerse(
//                       verse: _author?.title,
//                       size: 1,
//                       weight: VerseWeight.regular,
//                       centered: false,
//                       italic: true,
//                       scaleFactor: flyerBoxWidth / _screenWidth,
//                     ),
//
//                     /// FOLLOWERS COUNTER
//                     SuperVerse(
//                       verse: _followersCounter,
//                       italic: true,
//                       centered: false,
//                       weight: VerseWeight.regular,
//                       size: 0,
//                       scaleFactor: flyerBoxWidth / _screenWidth,
//                     ),
//
//                   ],
//                 ),
//               ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
