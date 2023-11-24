// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
// import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/b_views/z_components/texting/old_super_text_field.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/c_controllers/i_flyer_maker_controllers/xx_draft_shelf_controllers.dart';
// import 'package:bldrs/d_providers/phrase_provider.dart';
// import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
// import 'package:basics/helpers/classes/maps/mapper.dart';
// import 'package:basics/helpers/classes/space/scale.dart';
//
// 
// 
// import 'package:bldrs/f_helpers/theme/standards.dart';
// import 'package:flutter/material.dart';
//
// class ShelfHeaderPart extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const ShelfHeaderPart({
//     required this.draft,
//     required this.shelfNumber,
//     required this.titleLength,
//     required this.formKey,
//     required this.onMoreTap,
//     required this.loading,
//     required this.onHeadlineChanged,
//     required this.headlineController,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final DraftFlyerModel draft;
//   final int shelfNumber;
//   final ValueNotifier<int> titleLength;
//   final GlobalKey<FormState> formKey;
//   final Function onMoreTap;
//   final ValueNotifier<bool> loading;
//   final ValueChanged<String> onHeadlineChanged;
//   final TextEditingController headlineController;
//   /// --------------------------------------------------------------------------
//   static const double height = 80;
//   static const double shelfNumberZoneHeight = 20;
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // ----------------------------------------------------------------------------------
//     final String _shelfTitle = DraftFlyerModel.generateShelfTitle(
//       context: context,
//       times: draft.times,
//       flyerState: draft.flyerState,
//       shelfNumber: shelfNumber,
//     );
//     // ----------------------------------------------------------------------------------
//     final bool _isPublished = draft.flyerState == FlyerState.published;
//     final bool _hasSlides = canLoopList(draft.mutableSlides);
//     // HEIGHT ----------------------------------------------------------------------------
//     const double _headlineZoneHeight = height - shelfNumberZoneHeight;
//     const double _textFieldHeight = _headlineZoneHeight;
//     // WIDTH ----------------------------------------------------------------------------
//     final double _shelfWidth = Scale.superScreenWidth(context);
//     const double _spacing = Ratioz.appBarMargin;
//     const double _controlPanelWidth = _textFieldHeight * 0.7;
//     const double _moreButtonSize = _textFieldHeight * 0.7;
//     final double _headlineZoneWidth = _shelfWidth - _controlPanelWidth - (_spacing * 3);
//     // ----------------------------------------------------------------------------------
//     return Container(
//       key: const ValueKey<String>('ShelfHeaderPart'),
//       width: _shelfWidth,
//       height: height,
//       alignment: Aligners.superCenterAlignment(context),
//       // color: Colorz.bloodTest,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//
//           /// SPACER
//           const SizedBox(width: _spacing,),
//
//           /// SHELF HEADLINE
//           SizedBox(
//             width: _headlineZoneWidth,
//             height: height,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//
//                 /// SHELF NUMBER + COUNTER
//                 SizedBox(
//                   width: _headlineZoneWidth,
//                   height: shelfNumberZoneHeight,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//
//                       /// CHAIN NUMBER
//                       SuperVerse(
//                         verse: _shelfTitle,
//                         size: 1,
//                         italic: true,
//                         color: _isPublished ? Colorz.green255: Colorz.white80,
//                         weight: VerseWeight.thin,
//                       ),
//
//                       /// TEXT FIELD COUNTER
//                       if  (_isPublished == false && _hasSlides)
//                         ValueListenableBuilder(
//                             valueListenable: titleLength,
//                             builder: (_, int _titleLength, Widget child){
//
//                               final Color _color = _titleLength >= Standards.flyerTitleMaxLength ?
//                               Colorz.red255
//                                   :
//                               Colorz.white80;
//
//                               return SuperVerse(
//                                 verse:  '$_titleLength / ${Standards.flyerTitleMaxLength}',
//                                 size: 1,
//                                 italic: true,
//                                 color: _color,
//                                 weight: VerseWeight.thin,
//                               );
//
//                             }
//                         ),
//
//                     ],
//                   ),
//                 ),
//
//                 /// FIRST HEADLINE TEXT FIELD
//                 // if  (_isPublished == false && _hasSlides)
//                   SizedBox(
//                     width: _headlineZoneWidth,
//                     height: _headlineZoneHeight,
//                     child: Form(
//                       key: formKey,
//                       child: SuperTextField(
//                         // onTap: (){},
//                         fieldIsFormField: true,
//                         height: _textFieldHeight,
//                         width: _headlineZoneWidth,
//                         maxLines: 1,
//                         counterIsOn: false,
//                         validator: (val) => flyerHeadlineValidator(
//                           context: context,
//                           val: val,
//                         ),
//                         onChanged: (val) => onHeadlineChanged(val),
//                         // margin: EdgeInsets.only(top: Ratioz.appBarPadding),
//                         hintText: superPhrase(context, 'phid_flyer_headline_3_dots'),
//                         textController: headlineController,
//                         // maxLength: Standards.flyerTitleMaxLength,
//
//                       ),
//                     ),
//                   ),
//
//                 // /// FIRST HEADLINE AS SUPER VERSE
//                 // if (_isPublished == true && _hasSlides)
//                 //   Container(
//                 //     width: _flyerTitleZoneWidth,
//                 //     height: _deleteFlyerButtonSize,
//                 //     decoration: BoxDecoration(
//                 //       color: Colorz.white10,
//                 //       borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12),
//                 //     ),
//                 //     alignment: Aligners.superCenterAlignment(context),
//                 //     padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
//                 //     child: SuperVerse(
//                 //       verse: draft.mutableSlides[0].headline.text,
//                 //       centered: false,
//                 //       size: 3,
//                 //     ),
//                 //   ),
//
//               ],
//             ),
//           ),
//
//           /// SPACER
//           const SizedBox(width: _spacing,),
//
//           /// CONTROL PANEL
//           Container(
//             width: _controlPanelWidth,
//             height: height,
//             alignment: Alignment.center,
//             // color: Colorz.blue20,
//             child: ValueListenableBuilder(
//                 valueListenable: loading,
//                 builder: (_, bool isLoading, Widget child){
//
//                   return DreamBox(
//                       height: _moreButtonSize,
//                       width: _moreButtonSize,
//                       icon: Iconz.more,
//                       iconSizeFactor: 0.5,
//                       loading: isLoading,
//                       onTap: onMoreTap
//                   );
//
//                 }
//             ),
//           ),
//
//           /// SPACER
//           const SizedBox(width: _spacing,),
//
//         ],
//       ),
//     );
//   }
// }
