import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BldrsTileBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsTileBubble({
    this.bubbleHeaderVM,
    this.bubbleWidth,
    this.verseColor = Colorz.white255,
    this.onTileTap,
    this.secondLineVerse,
    this.iconIsBubble = true,
    this.insideDialog = false,
    this.moreBtOnTap,
    this.child,
    this.bulletPoints,
    this.bulletPointsMaxLines = 10,
    this.bubbleColor = Colorz.white10,
    this.validator,
    this.autoValidate = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? bubbleWidth;
  final BubbleHeaderVM? bubbleHeaderVM;
  final Color verseColor;
  final Function? onTileTap;
  final Verse? secondLineVerse;
  final bool iconIsBubble;
  final bool insideDialog;
  final Function? moreBtOnTap;
  final Widget? child;
  final List<Verse>? bulletPoints;
  final int bulletPointsMaxLines;
  final Color bubbleColor;
  final String? Function()? validator;
  final bool autoValidate;
  /// --------------------------------------------------------------------------
  // static const double iconBoxWidth = 30; /// delete me 5alas (im in BubbleHeader class)
  // /// --------------------------------------------------------------------------
  // static double getBubbleWidth({
  //   required BuildContext context,
  //   double bubbleWidthOverride,
  // }){
  //   final double _bubbleWidth = bubbleWidthOverride ?? BldrsAppBar.width(context);
  //   return _bubbleWidth;
  // }
  // // --------------------
  // static double childWidth({
  //   required BuildContext context,
  //   double bubbleWidthOverride,
  // }) {
  //
  //   final double _bubbleWidth = getBubbleWidth(
  //     context: context,
  //     bubbleWidthOverride: bubbleWidthOverride,
  //   );
  //
  //   return _bubbleWidth - iconBoxWidth - (2 * Ratioz.appBarMargin);
  // }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileBubble(
      key: const ValueKey<String>('BldrsTileBubble'),
      textDirection: UiProvider.getAppTextDir(),
      font: BldrsText.superVerseFont(VerseWeight.bold),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      textColor: verseColor,
      autoValidate: autoValidate,
      validator: validator,
      bubbleColor: bubbleColor,
      bubbleHeaderVM: bubbleHeaderVM,
      bubbleWidth: bubbleWidth,
      bulletPoints: Verse.bakeVerses(verses: bulletPoints),
      bulletPointsMaxLines: bulletPointsMaxLines,
      iconIsBubble: iconIsBubble,
      insideDialog: insideDialog,
      moreBtOnTap: moreBtOnTap,
      onTileTap: onTileTap,
      secondLine: Verse.bakeVerseToString(verse: secondLineVerse),
      secondLineColor: verseColor,
      secondLineTextHeight: BldrsText.superVerseRealHeight(context: context, size: 2, sizeFactor: 1, hasLabelBox: false),
      // focusNode: ,
      child: child,
    );

    // final double _bubbleWidth = getBubbleWidth(
    //   context: context,
    //   bubbleWidthOverride: bubbleWidth,
    // );
    // final double _clearWidth = Bubble.clearWidth(context, bubbleWidthOverride: _bubbleWidth);
    //
    // return Bubble(
    //   bubbleHeaderVM: BldrsBubbleHeaderVM.bake(),
    //   width: _bubbleWidth,
    //   onBubbleTap: onTileTap,
    //   bubbleColor: Formers.validatorBubbleColor(
    //     // canErrorize: true,
    //     defaultColor: bubbleColor,
    //     validator: validator,
    //   ),
    //   columnChildren: <Widget>[
    //
    //     /// BUBBLE HEADER
    //     if (bubbleHeaderVM != null)
    //     BubbleHeader(
    //       viewModel: bubbleHeaderVM.copyWith(
    //         headerWidth: _clearWidth,
    //       ),
    //     ),
    //
    //     /// BULLET POINTS
    //     Padding(
    //       padding: Scale.superInsets(
    //         context: context,
    //         appIsLTR: UiProvider.checkAppIsLeftToRight(),
    //         enLeft: iconBoxWidth,
    //       ),
    //       child: BldrsBulletPoints(
    //         bulletPoints: bulletPoints,
    //       ),
    //     ),
    //
    //     /// SECOND LINE
    //     if (secondLineVerse != null)
    //       SizedBox(
    //         width: Bubble.bubbleWidth(context),
    //         child: Row(
    //           children: <Widget>[
    //
    //             /// UNDER LEADING ICON AREA
    //             const SizedBox(
    //               width: iconBoxWidth,
    //             ),
    //
    //             /// SECOND LINE
    //             SizedBox(
    //               width: childWidth(
    //                 context: context,
    //                 bubbleWidthOverride: _bubbleWidth,
    //               ),
    //               child: SuperVerse(
    //                 verse: secondLineVerse,
    //                 color: Colorz.white200,
    //                 // scaleFactor: 1,
    //                 italic: true,
    //                 maxLines: 100,
    //                 centered: false,
    //                 weight: VerseWeight.thin,
    //                 margin: 5,
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //
    //     /// CHILD
    //     if (child != null)
    //       SizedBox(
    //         width: _bubbleWidth,
    //         // height: 200,
    //         // padding: const EdgeInsets.symmetric(horizontal: 5),
    //         // color: Colorz.Yellow255,
    //         child: Row(
    //           // mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //
    //             /// UNDER LEADING ICON AREA
    //             const SizedBox(
    //               width: iconBoxWidth,
    //             ),
    //
    //             /// CHILD
    //             Container(
    //               width: childWidth(context: context, bubbleWidthOverride: _bubbleWidth),
    //               // decoration: BoxDecoration(
    //               //     color: Colorz.white10,
    //               //     borderRadius: Borderers.superBorderAll(context, Bubble.clearCornersValue)
    //               // ),
    //               alignment: Alignment.center,
    //               child: child,
    //             ),
    //
    //           ],
    //         ),
    //       ),
    //
    //     if (validator != null)
    //       BldrsValidator(
    //         width: _clearWidth,
    //         validator: validator,
    //         autoValidate: autoValidate,
    //       ),
    //
    //   ],
    // );

  }
  // -----------------------------------------------------------------------------
}
