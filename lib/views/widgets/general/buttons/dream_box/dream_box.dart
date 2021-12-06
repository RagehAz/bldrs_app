import 'dart:io';

import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box_gradient.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box_highlight.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box_tap_layer.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box_underline.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box_verse.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DreamBox extends StatelessWidget {
  final String icon;
  final File iconFile;
  /// works as a verseSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final dynamic corners;
  final Color iconColor;
  final String verse;
  final Color verseColor;
  final VerseWeight verseWeight;
  final double verseScaleFactor;
  final bool verseShadow;
  final bool verseItalic;
  final int verseMaxLines;
  final Function onTap;
  final dynamic margins;
  final bool blackAndWhite;
  final bool iconRounded;
  final bool bubble;
  final String secondLine;
  final bool verseCentered;
  final Widget subChild;
  final Alignment childAlignment;
  final double opacity;
  final bool inActiveMode;
  final String underLine;
  final Color splashColor;
  final Color underLineColor;
  final bool underLineShadowIsOn;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;
  final double blur;
  final Color secondLineColor;
  final bool redDot;
  final double secondLineScaleFactor;
  final bool loading;

  const DreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconFile,
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
    this.onTap,
    this.margins,
    this.blackAndWhite = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondLine,
    this.verseCentered = true,
    this.subChild,
    this.childAlignment = Alignment.center,
    this.opacity = 1,
    this.inActiveMode = false,
    this.underLine,
    this.splashColor = Colorz.white80,
    this.underLineColor = Colorz.white255,
    this.underLineShadowIsOn = true,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection,
    this.blur,
    this.secondLineColor = Colorz.white255,
    this.redDot = false,
    this.secondLineScaleFactor = 1,
    this.loading = false,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  static Color getIconColor({bool blackAndWhite = false, bool inActiveMode = false, Color colorOverride}){

    final Color _iconColor =
    blackAndWhite == true || inActiveMode == true ? Colorz.white30 :
    colorOverride;

    return _iconColor;
  }
// -----------------------------------------------------------------------------
  static double graphicWidth({String icon, double height, bool loading, double iconSizeFactor}){

    final double _svgGraphicWidth = height * iconSizeFactor;
    final double _jpgGraphicWidth = height * iconSizeFactor;

    final double _graphicWidth = icon == null && loading == false ? 0 :
    ObjectChecker.fileExtensionOf(icon) == 'svg' ? _svgGraphicWidth :
    ObjectChecker.fileExtensionOf(icon) == 'jpg' ||
        ObjectChecker.fileExtensionOf(icon) == 'jpeg' ||
        ObjectChecker.fileExtensionOf(icon) == 'png' ? _jpgGraphicWidth : height;

    return _graphicWidth;
  }
// -----------------------------------------------------------------------------
  static double iconMargin({double height, double graphicWidth, String icon, String verse}){
    return
      verse == null || icon == null ? 0 : (height - graphicWidth)/2;
  }
// -----------------------------------------------------------------------------
  static Color boxColor({bool blackAndWhite, Color color}){
    return
      (blackAndWhite == true && color != Colorz.nothing) ?
      Colorz.grey80 :
      (color == Colorz.nothing && blackAndWhite == true) ?
      Colorz.nothing :
      color;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final Color _imageSaturationColor =
        blackAndWhite == true ? Colorz.grey255 : Colorz.nothing;
// -----------------------------------------------------------------------------
//     double _verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;
// -----------------------------------------------------------------------------
    final double _graphicWidth = graphicWidth(
      icon: icon,
      height: height,
      iconSizeFactor: iconSizeFactor,
      loading: loading,
    );
// -----------------------------------------------------------------------------
    final double _iconMargin = iconMargin(
      height: height,
      icon: icon,
      verse: verse,
      graphicWidth: _graphicWidth,
    );
// -----------------------------------------------------------------------------
//     double _verseWidth = width != null ? width - (_iconMargin * 2) - _graphicWidth - ((_verseIconSpacing * 2) + _iconMargin) : width;
    final int _verseSize =  iconSizeFactor == 1 ? 4 : 4;
// -----------------------------------------------------------------------------
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
    final BorderRadius _iconCorners = Borderers.getCornersAsBorderRadius(context, corners);
// -----------------------------------------------------------------------------
    final Color _boxColor = boxColor(
      color: color,
      blackAndWhite: blackAndWhite,
    );
// -----------------------------------------------------------------------------
    final Color _iconColor = getIconColor(
      inActiveMode: inActiveMode,
      blackAndWhite: blackAndWhite,
      colorOverride: iconColor,
    );
// -----------------------------------------------------------------------------
    final TextDirection _textDirection = textDirection == null ? superTextDirection(context) : textDirection;
// -----------------------------------------------------------------------------
    final EdgeInsets _boxMargins = Scale.superMargins(margins : margins);
// -----------------------------------------------------------------------------
//     CrossAxisAlignment _versesCrossAlignment =
//     icon == null && textDirection == null && secondLine == null ? CrossAxisAlignment.center
//         :
//     textDirection != null ? CrossAxisAlignment.end // dunno why
//         :
//     (icon != null && secondLine != null) || (verseCentered == false) ? CrossAxisAlignment.start
//         :
//     CrossAxisAlignment.center; // verseCentered
// -----------------------------------------------------------------------------
    /// underline should only available if dreambox is portrait && verse is null && secondVerse is null
    // double _iconBoxHeight = width ?? 0;
    // double _underLineHeight = height?? 0 - _iconBoxHeight;
    // double _underLineTopMargin = underLine == null ? 0 :
    // ObjectChecker.objectIsSVG(icon) ? (width - (_underLineHeight * 0.1)) * 1 : // (width - ((width - _graphicWidth)/2)) * 0.0 :
    // width;
    // double _underlineHeight = underLine == null ? 0 : height - _underLineTopMargin;
// -----------------------------------------------------------------------------

    final BorderRadius _cornersAsBorderRadius = Borderers.getCornersAsBorderRadius(context, corners);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        IntrinsicWidth(

          child: Opacity(
            opacity: inActiveMode == true ? 0.35 : opacity,
            child: Padding(
              padding: _boxMargins,
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: inActiveMode == true ? Colorz.white10 : _boxColor,
                    borderRadius: _cornersAsBorderRadius,
                    boxShadow: const <BoxShadow>[
                      // CustomBoxShadow(
                      //     color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                      //     offset: new Offset(0, 0),
                      //     blurRadius: height * 0.15,
                      //     blurStyle: BlurStyle.outer
                      // ),
                    ]
                ),
                child: ClipRRect(
                  borderRadius: _cornersAsBorderRadius,
                  child: Stack(
                    alignment: Alignment.center,
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
                        verse : verse,
                        textDirection : _textDirection,
                        icon : icon,
                        loading : loading,
                        underLine : underLine,
                        height : height,
                        width : width,
                        iconCorners : _iconCorners,
                        iconFile : iconFile,
                        iconMargin : _iconMargin,
                        imageSaturationColor : _imageSaturationColor,
                        bubble : bubble,
                        blackAndWhite : blackAndWhite,
                        iconColor : _iconColor,
                        iconSizeFactor : iconSizeFactor,
                        verseScaleFactor : verseScaleFactor,
                        verseCentered : verseCentered,
                        secondLine : secondLine,
                        verseSize : _verseSize,
                        verseWeight : verseWeight,
                        inActiveMode : inActiveMode,
                        verseColor : verseColor,
                        verseShadow : verseShadow,
                        verseMaxLines : verseMaxLines,
                        verseItalic : verseItalic,
                        redDot : redDot,
                        secondLineScaleFactor : secondLineScaleFactor,
                        secondLineColor : secondLineColor,
                        centered: verseCentered,
                      ),

                      /// --- BOX HIGHLIGHT
                      if (bubble == true)
                      // GradientLayer(
                      //   width: size.hasBoundedWidth ? 100 : SuperVerse.,
                      //   height: size.maxHeight,
                      //   isWhite: true,
                      // ),
                        DreamBoxHighlight(width: width, height: height, corners: corners),

                      /// --- BOX GRADIENT
                      if (bubble == true)
                      // GradientLayer(
                      //   width: size.hasBoundedWidth ? 100 : 200,
                      //   height: size.maxHeight,
                      //   isWhite: false,
                      // ),
                        DreamBoxGradient(
                          width: width,
                          height: height,
                          corners: _cornersAsBorderRadius,
                        ),

                      /// --- UNDERLINE
                      if (underLine != null)
                        DreamBoxUnderLine(
                          width: width,
                          height: height,
                          underLine: underLine,
                          icon: icon,
                          scaleFactor: verseScaleFactor * 0.45,
                          underLineShadowIsOn: underLineShadowIsOn,
                          underLineColor: underLineColor,
                          verseSize: _verseSize,
                        ),

                      /// --- RIPPLE & TAP LAYER
                      if (onTap != null)
                        DreamBoxTapLayer(
                            width: width,
                            height: height,
                            splashColor: splashColor,
                            onTap: onTap,
                            onTapUp: onTapUp,
                            onTapDown: onTapDown,
                            onTapCancel: onTapCancel,
                            inActiveMode: inActiveMode
                        ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
