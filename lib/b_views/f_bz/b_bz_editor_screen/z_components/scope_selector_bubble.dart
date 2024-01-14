// import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
// import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
// import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
// import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_validator.dart';
// import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// 
// import 'package:flutter/material.dart';
// import 'package:basics/helpers/maps/mapper.dart';
// import 'package:basics/components/animators/widget_fader.dart';
//
// class ScopeSelectorBubble extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const ScopeSelectorBubble({
//     required this.flyerTypes,
//     required this.headlineVerse,
//     required this.selectedSpecs,
//     required this.onFlyerTypeBubbleTap,
//     this.bulletPoints,
//     this.addButtonVerse,
//     this.validator,
//     this.autoValidate = true,
//     this.focusNode,
//     this.bubbleWidth,
//     this.onPhidTap,
//     this.onSwitchTap,
//     this.switchValue,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final List<FlyerType> flyerTypes;
//   final Verse headlineVerse;
//   final List<SpecModel> selectedSpecs;
//   final List<Verse> bulletPoints;
//   final Verse addButtonVerse;
//   final String Function() validator;
//   final bool autoValidate;
//   final FocusNode focusNode;
//   final double bubbleWidth;
//   final Function(FlyerType flyerType, String phid) onPhidTap;
//   final Function(FlyerType flyerType) onFlyerTypeBubbleTap;
//   final bool switchValue;
//   final Function(bool switchValue) onSwitchTap;
//   /// --------------------------------------------------------------------------
//   static const double typeButtonSize = 40;
//   /// --------------------------------------------------------------------------
//   @override
//   State<ScopeSelectorBubble> createState() => _ScopeSelectorBubbleState();
//   /// --------------------------------------------------------------------------
// }
//
// class _ScopeSelectorBubbleState extends State<ScopeSelectorBubble> {
//   // -----------------------------------------------------------------------------
//   List<String> _phids = <String>[];
//   bool _flyerTypesExist = false;
//   // -----------------------------------------------------------------------------
//   /*
//   /// --- LOADING
//   final ValueNotifier<bool> _loading = ValueNotifier(false);
//   // --------------------
//   Future<void> _triggerLoading({required bool setTo}) async {
//     setNotifier(
//       notifier: _loading,
//       mounted: mounted,
//       value: setTo,
//     );
//   }
//    */
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _phids = SpecModel.getSpecsIDs(widget.selectedSpecs);
//     _initializeLocalVariables();
//
//   }
//   // --------------------
//   void _initializeLocalVariables(){
//     _flyerTypesExist = Lister.checkCanLoop(widget.flyerTypes) == true;
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       // _triggerLoading(setTo: true).then((_) async {
//       //
//       //
//       //   await _triggerLoading(setTo: false);
//       // });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void didUpdateWidget(covariant ScopeSelectorBubble oldWidget) {
//     if (
//     FlyerTyper.checkFlyerTypesAreIdentical(widget.flyerTypes, oldWidget.flyerTypes) == false
//     ||
//     SpecModel.checkSpecsListsAreIdentical(widget.selectedSpecs, oldWidget.selectedSpecs) == false
//
//     ) {
//       setState(() {
//         _phids = SpecModel.getSpecsIDs(widget.selectedSpecs);
//         _initializeLocalVariables();
//       });
//     }
//     else if (
//         widget.headlineVerse != oldWidget.headlineVerse ||
//         Lister.checkListsAreIdentical(list1: widget.bulletPoints, list2: oldWidget.bulletPoints) == false ||
//         widget.addButtonVerse != oldWidget.addButtonVerse ||
//         widget.validator != oldWidget.validator ||
//         widget.autoValidate != oldWidget.autoValidate ||
//         // widget.focusNode != oldWidget.focusNode ||
//         widget.bubbleWidth != oldWidget.bubbleWidth ||
//         widget.switchValue != oldWidget.switchValue
//         // widget.onPhidTap != oldWidget.onPhidTap ||
//     ){
//       setState(() {});
//     }
//
//     super.didUpdateWidget(oldWidget);
//   }
//   // --------------------
//   @override
//   void dispose() {
//     // _loading.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _width = widget.bubbleWidth ?? Bubble.bubbleWidth(context: context);
//
//     // final double _phidsZoneWidth = Bubble.clearWidth(
//     //     context: context,
//     //     bubbleWidthOverride: _width
//     // )
//     //     - ScopeSelectorBubble.typeButtonSize
//     //     - 10;
//
//
//     return WidgetFader(
//       fadeType: _flyerTypesExist == true ? FadeType.stillAtMax : FadeType.stillAtMin,
//       min: 0.35,
//       ignorePointer: !_flyerTypesExist,
//       child: Bubble(
//         bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
//           context: context,
//           headlineVerse: widget.headlineVerse,
//           headerWidth: Bubble.clearWidth(context: context, bubbleWidthOverride: _width),
//           switchValue: widget.switchValue,
//           hasSwitch: widget.switchValue != null,
//           onSwitchTap: widget.onSwitchTap,
//         ),
//         width: _width,
//         columnChildren: <Widget>[
//
//           /// BULLET POINTS
//           BldrsBulletPoints(
//             bubbleWidth: _width,
//             bulletPoints: widget.bulletPoints,
//           ),
//
//           /// SPECS SELECTION BOXES
//           // SizedBox(
//           //   width: Bubble.clearWidth(context: context, bubbleWidthOverride: _width),
//           //   // color: Colorz.bloodTest,
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     children: <Widget>[
//           //
//           //       /// BZ TYPES BUTTONS BUILDER
//           //       if (_flyerTypesExist == true)
//           //         ...List.generate(widget.flyerTypes.length, (index){
//           //
//           //           final FlyerType _flyerType = widget.flyerTypes[index];
//           //           final List<String> _flyerTypePhids = SpecModel.getPhidsFromSpecsFilteredByFlyerType(
//           //             specs: widget.selectedSpecs,
//           //             flyerType: _flyerType,
//           //           );
//           //
//           //           return Row(
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: <Widget>[
//           //
//           //               /// BZ TYPE BUTTON
//           //               BldrsBox(
//           //                 width: ScopeSelectorBubble.typeButtonSize,
//           //                 height: ScopeSelectorBubble.typeButtonSize,
//           //                 icon: FlyerTyper.flyerTypeIcon(
//           //                   flyerType: _flyerType,
//           //                   isOn: false,
//           //                 ),
//           //               ),
//           //
//           //               /// SPACER
//           //               const SizedBox(
//           //                 width: 10,
//           //                 height: 10,
//           //               ),
//           //
//           //               /// PHIDS
//           //               Bubble(
//           //                 width: _phidsZoneWidth,
//           //                 bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
//           //                   context: context,
//           //                   headlineVerse: Verse(
//           //                     id: FlyerTyper.getFlyerTypePhid(flyerType: _flyerType),
//           //                     translate: true,
//           //                   ),
//           //                   headlineColor: Colorz.yellow200,
//           //                 ),
//           //                 onBubbleTap: () => widget.onFlyerTypeBubbleTap(_flyerType),
//           //                 columnChildren: <Widget>[
//           //
//           //                   /// SELECTED PHIDS
//           //                   if (Lister.checkCanLoop(_phids) == true)
//           //                     PhidsViewer(
//           //                       pageWidth: _phidsZoneWidth,
//           //                       phids: _flyerTypePhids,
//           //                       onPhidTap: (String phid) => widget.onPhidTap(_flyerType, phid),
//           //                       onPhidLongTap: (String phid){
//           //                         blog('scopeSelectorBubble : onPhidLongTap : phid: $phid');
//           //                       },
//           //                     ),
//           //
//           //                   if (Lister.checkCanLoop(_phids) == false)
//           //                     SizedBox(
//           //                       width: _phidsZoneWidth,
//           //                       height: PhidButton.getHeight(),
//           //                     ),
//           //
//           //
//           //                   // /// ADD SPECS BUTTON
//           //                   // if (widget.showAddMoreButtons == true)
//           //                   // BldrsBox(
//           //                   //   height: PhidButton.getHeight(),
//           //                   //   // width: Bubble.clearWidth(context),
//           //                   //   verse: widget.addButtonVerse ?? Verse(
//           //                   //     id: Lister.checkCanLoop(_phids) ?
//           //                   //     'phid_add_bz_scope' // phid_edit_scope
//           //                   //         :
//           //                   //     'phid_add_bz_scope',
//           //                   //     translate: true,
//           //                   //   ),
//           //                   //   bubble: false,
//           //                   //   color: Colorz.white20,
//           //                   //   verseScaleFactor: 1.5,
//           //                   //   verseWeight: VerseWeight.thin,
//           //                   //   icon: Iconz.plus,
//           //                   //   iconSizeFactor: 0.4,
//           //                   //   iconColor: Colorz.white20,
//           //                   //   onTap: () => widget.onAddScope(_flyerType),
//           //                   // ),
//           //
//           //                 ],
//           //               ),
//           //
//           //             ],
//           //           );
//           //
//           //         }),
//           //
//           //     ],
//           //   ),
//           // ),
//
//           /// VALIDATOR
//           if (widget.validator != null)
//             BldrsValidator(
//               width: Bubble.clearWidth(context: context, bubbleWidthOverride: _width) - 20,
//               validator: widget.validator,
//               autoValidate: widget.autoValidate,
//               focusNode: widget.focusNode,
//             ),
//
//         ],
//       ),
//     );
//
//   }
// }
