import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_gradient.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_highlight.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_tap_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/the_box_of_dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class DreamBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconSizeFactor = 1,
    this.color = Colorz.nothing,
    this.corners = Ratioz.boxCorner12,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.white255,
    this.verseWeight = VerseWeight.bold,
    this.verseScaleFactor = 1,
    this.verseShadow,
    this.verseItalic = false,
    this.verseMaxLines = 1,
    this.secondVerseMaxLines = 10,
    this.onTap,
    this.margins,
    this.greyscale = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondLine,
    this.verseCentered = true,
    this.subChild,
    this.childAlignment = Alignment.center,
    this.opacity = 1,
    this.isDeactivated = false,
    this.splashColor = Colorz.white80,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection,
    this.blur,
    this.secondLineColor = Colorz.white255,
    this.redDot = false,
    this.secondLineScaleFactor = 1,
    this.loading = false,
    this.iconBackgroundColor,
    this.onDeactivatedTap,
    this.verseHighlight,
    this.verseHighlightColor = Colorz.bloodTest,
    this.onLongTap,
    this.onDoubleTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  /// works as a verseSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final dynamic corners;
  final Color iconColor;
  final Verse verse;
  final Color verseColor;
  final VerseWeight verseWeight;
  final double verseScaleFactor;
  final bool verseShadow;
  final bool verseItalic;
  final int verseMaxLines;
  final int secondVerseMaxLines;
  final Function onTap;
  final dynamic margins;
  final bool greyscale;
  final bool iconRounded;
  final bool bubble;
  final Verse secondLine;
  final bool verseCentered;
  final Widget subChild;
  final Alignment childAlignment;
  final double opacity;
  final bool isDeactivated;
  final Color splashColor;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;
  final double blur;
  final Color secondLineColor;
  final bool redDot;
  final double secondLineScaleFactor;
  final bool loading;
  final Color iconBackgroundColor;
  final Function onDeactivatedTap;
  final ValueNotifier<dynamic> verseHighlight;
  final Color verseHighlightColor;
  final Function onLongTap;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  static Color getIconColor({
    bool blackAndWhite = false,
    bool inActiveMode = false,
    Color colorOverride
  }) {

    final Color _iconColor = blackAndWhite == true || inActiveMode == true ?
    Colorz.white30
        :
    colorOverride;

    return _iconColor;
  }
  // --------------------
  static double graphicWidth({
    dynamic icon,
    double height,
    bool loading,
    double iconSizeFactor,
  }) {

    final double _svgGraphicWidth = height * iconSizeFactor;
    final double _jpgGraphicWidth = height * iconSizeFactor;

    final double _graphicWidth = icon == null && loading == false ? 0
        :
    ObjectCheck.fileExtensionOf(icon) == 'svg' ? _svgGraphicWidth
        :
    ObjectCheck.fileExtensionOf(icon) == 'jpg' ||
        ObjectCheck.fileExtensionOf(icon) == 'jpeg' ||
        ObjectCheck.fileExtensionOf(icon) == 'png' ?
    _jpgGraphicWidth
        :
    height;

    return _graphicWidth;
  }
  // --------------------
  static double iconMargin({
    dynamic icon,
    double height,
    double graphicWidth,
    String verse,
  }) {

    return verse == null || icon == null ? 0 : (height - graphicWidth) / 2;
  }
  // --------------------
  static Color boxColor({
    bool blackAndWhite,
    Color color
  }) {
    return (blackAndWhite == true && color != Colorz.nothing) ?
    Colorz.grey80
        :
    (color == Colorz.nothing && blackAndWhite == true) ?
    Colorz.nothing
        :
    color;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// double _verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;
    // --------------------
    final double _graphicWidth = graphicWidth(
      icon: icon,
      height: height,
      iconSizeFactor: iconSizeFactor,
      loading: loading,
    );
    // --------------------
    final double _iconMargin = iconMargin(
      height: height,
      icon: icon,
      verse: verse?.text,
      graphicWidth: _graphicWidth,
    );
    // --------------------
    final int _verseSize = iconSizeFactor == 1 ? 4 : 4;
    // --------------------
    /*
     //  double _verseWidth = width != null ? width - (_iconMargin * 2) - _graphicWidth - ((_verseIconSpacing * 2) + _iconMargin) : width;
     */
    // --------------------
    /*
//     BorderRadius _getIconCornerByRadius(){
//       BorderRadius _IconCornerAsBorderRadius;
//       double _iconCorners;
//
//       /// IF ICON IS ROUNDED
//       if(iconRounded == true){
//         _iconCorners =  (Borderers.getCornersAsDouble(corners) - _iconMargin);
//         _IconCornerAsBorderRadius = Borderers.superBorderAll(context, _iconCorners);
//       }
//
//       /// IF CUSTOM BORDER RADIUS PASSES THROUGH corners
//       else if (corners.runtimeType ==  BorderRadius){
//         BorderRadius _cornerBorders;
//
//         _IconCornerAsBorderRadius = Borderers.superBorderOnly(
//           context: context,
//           enTopRight: corners.topRight.x - _iconMargin,
//           enTopLeft: corners.topLeft.x - _iconMargin,
//           enBottomRight: corners.bottomRight.x - _iconMargin,
//           enBottomLeft: corners.bottomLeft.x - _iconMargin,
//         );
//       }
//
//       /// IF corners IS DOUBLE AND ICON IS NOT ROUNDED
//       else {
//         _IconCornerAsBorderRadius = Borderers.superBorderAll(context, 0);
//       }
//
//
//       return _IconCornerAsBorderRadius;
//     }

     */
    // --------------------
    final BorderRadius _iconCorners = Borderers.getCornersAsBorderRadius(context, corners);
    // --------------------
    final Color _boxColor = boxColor(
      color: color,
      blackAndWhite: greyscale,
    );
    // --------------------
    final Color _iconColor = getIconColor(
      inActiveMode: isDeactivated,
      blackAndWhite: greyscale,
      colorOverride: iconColor,
    );
    // --------------------
    final TextDirection _textDirection = textDirection ?? TextDir.textDirectionAsPerAppDirection(context);
    // --------------------
    final EdgeInsets _boxMargins = Scale.superMargins(margins: margins);
    // --------------------
    /*
//     CrossAxisAlignment _versesCrossAlignment =
//     icon == null && textDirection == null && secondLine == null ? CrossAxisAlignment.center
//         :
//     textDirection != null ? CrossAxisAlignment.end // dunno why
//         :
//     (icon != null && secondLine != null) || (verseCentered == false) ? CrossAxisAlignment.start
//         :
//     CrossAxisAlignment.center; // verseCentered
     */
    // --------------------
    /// underline should only available if dreambox is portrait && verse is null && secondVerse is null
    // double _iconBoxHeight = width ?? 0;
    // double _underLineHeight = height?? 0 - _iconBoxHeight;
    // double _underLineTopMargin = underLine == null ? 0 :
    // ObjectChecker.objectIsSVG(icon) ? (width - (_underLineHeight * 0.1)) * 1 : // (width - ((width - _graphicWidth)/2)) * 0.0 :
    // width;
    // double _underlineHeight = underLine == null ? 0 : height - _underLineTopMargin;
// -----------------------------------------------------------------------------
    final BorderRadius _cornersAsBorderRadius = Borderers.getCornersAsBorderRadius(context, corners);
    // --------------------
    return TheBoxOfDreamBox(
      key: const ValueKey<String>('Dream_box_the_box'),
      inActiveMode: isDeactivated,
      opacity: opacity,
      boxMargins: _boxMargins,
      width: width,
      height: height,
      boxColor: _boxColor,
      cornersAsBorderRadius: _cornersAsBorderRadius,
      children: <Widget>[

        // /// --- BLUR LAYER
        // if (blur != null)
        //   BlurLayer(
        //     width: width,
        //     height: height,
        //     blur: blur,
        //     borders: _cornersAsBorderRadius,
        //   ),

        /// --- DREAM CHILD
        if (subChild != null)
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: _cornersAsBorderRadius,
            ),
            alignment: childAlignment,
            child: subChild,
          ),

        /// ICON - VERSE - SECOND LINE
        DreamBoxIconVerseSecondLine(
          key: const ValueKey<String>('DreamBoxIconVerseSecondLine'),
          verse: verse,
          textDirection: _textDirection,
          icon: icon,
          loading: loading,
          height: height,
          width: width,
          iconCorners: _iconCorners,
          iconMargin: _iconMargin,
          greyscale: greyscale,
          bubble: bubble,
          iconColor: _iconColor,
          iconSizeFactor: iconSizeFactor,
          verseScaleFactor: verseScaleFactor,
          verseCentered: verseCentered,
          secondLine: secondLine,
          verseSize: _verseSize,
          verseWeight: verseWeight,
          inActiveMode: isDeactivated,
          verseColor: verseColor,
          verseShadow: verseShadow,
          verseMaxLines: verseMaxLines,
          secondVerseMaxLines: secondVerseMaxLines,
          verseItalic: verseItalic,
          redDot: redDot,
          secondLineScaleFactor: secondLineScaleFactor,
          secondLineColor: secondLineColor,
          centered: verseCentered,
          backgroundColor: iconBackgroundColor,
          highlight: verseHighlight,
          highlightColor: verseHighlightColor,
        ),

        /// --- BOX HIGHLIGHT
        if (bubble == true)
        // GradientLayer(
        //   width: size.hasBoundedWidth ? 100 : SuperVerse.,
        //   height: size.maxHeight,
        //   isWhite: true,
        // ),

          DreamBoxHighlight(
              key: const ValueKey<String>('DreamBoxHighlight'),
              width: width,
              height: height,
              corners: corners
          ),

        /// --- BOX GRADIENT
        if (bubble == true)
          DreamBoxGradient(
            key: const ValueKey<String>('DreamBoxGradient'),
            width: width,
            height: height,
            corners: _cornersAsBorderRadius,
          ),

        /// --- RIPPLE & TAP LAYER
        if (onTap != null || onDeactivatedTap != null || onLongTap != null || onDoubleTap != null)
          DreamBoxTapLayer(
            key: const ValueKey<String>('DreamBoxTapLayer'),
            width: width,
            height: height,
            splashColor: splashColor,
            onTap: onTap,
            onTapUp: onTapUp,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            deactivated: isDeactivated,
            onDeactivatedTap: onDeactivatedTap,
            onLongTap: onLongTap,
            onDoubleTap: onDoubleTap,
          ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
