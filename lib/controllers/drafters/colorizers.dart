import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';

// -----------------------------------------------------------------------------
class Colorizer{
  static Gradient superSlideGradient(){
    Gradient slideGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.Black200, Colorz.Black0],
        stops: <double>[0,0.90]
    );
    return slideGradient;
  }
// -----------------------------------------------------------------------------
  static Gradient superHeaderStripGradient(Color color){
    Gradient headerStripGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.Nothing, color],
        stops: <double>[0.3, 1]);
    return headerStripGradient;
  }
// -----------------------------------------------------------------------------
  static Gradient superFollowBTGradient(){
    Gradient followBTGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.White50, Colorz.Nothing],
        stops: <double>[0, 0.5]
    );
    return followBTGradient;
  }
// -----------------------------------------------------------------------------
  static ui.ImageFilter superBlur(bool trigger){
    double blueValue = trigger == true ? 8 : 0;
    ui.ImageFilter blur = ui.ImageFilter.blur(sigmaX: blueValue, sigmaY: blueValue);
    return blur;
  }
// -----------------------------------------------------------------------------
  /// if i want to black and white a widget, put it as child in here
  /// child: ColorFiltered(
  ///     colorFilter: superDesaturation(blackAndWhite),
  ///     child: ,
  static ColorFilter superDesaturation(bool isItBlackAndWhite){
    Color imageSaturationColor = isItBlackAndWhite == true ? Colorz.Grey225 : Colorz.Nothing;
    return ColorFilter.mode(
        imageSaturationColor,
        BlendMode.saturation
    );
  }

}
// -----------------------------------------------------------------------------
class BlurLayer extends StatelessWidget {
  final BorderRadius borders;
  final double blur;
  final double width;
  final double height;
  final Color color;
  final bool blurIsOn;

  BlurLayer({
    this.borders,
    this.blur = Ratioz.blur1,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color,
    this.blurIsOn = false,
  });

  @override
  Widget build(BuildContext context) {

    bool _blurIsOn = blurIsOn == null ? false : blurIsOn;

    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: borders,
          child:
          _blurIsOn == true ?
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: borders,
              ),
            ),
          )
              :
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borders,
            ),
            // child: child,
          ),
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------
/// TASK : test this blur test
// class CachedFrostedBox extends StatefulWidget {
//   final Widget child;
//   final double sigmaY;
//   final double sigmaX;
//   /// This must be opaque so the backdrop filter won't access any colors beneath this background.
//   final Widget opaqueBackground;
//   /// Blur applied to the opaqueBackground. See the constructor.
//   final Widget frostBackground;
//
//   CachedFrostedBox({
//     @required this.child,
//     this.sigmaX = 8,
//     this.sigmaY = 8,
//     this.opaqueBackground
//   })
//       :this.frostBackground =
//   Stack(
//     children: <Widget>[
//       opaqueBackground,
//       ClipRect(
//           child: BackdropFilter(
//             filter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
//             child: new Container(
//                 decoration: new BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                 )
//             ),
//           )
//       ),
//     ],
//   );
//
//
//   @override
//   State<StatefulWidget> createState() {
//     return CachedFrostedBoxState();
//   }
// }
//
// class CachedFrostedBoxState extends State<CachedFrostedBox> {
//   final GlobalKey _snapshotKey = GlobalKey();
//
//   Image _backgroundSnapshot;
//   bool _snapshotLoaded = false;
//   bool _skipSnapshot = false;
//
//   void _snapshot(Duration _) async {
//     final RenderRepaintBoundary renderBackground = _snapshotKey.currentContext.findRenderObject();
//     final ui.Image image = await renderBackground.toImage(
//       pixelRatio: WidgetsBinding.instance.window.devicePixelRatio,
//     );
//     // !!! The default encoding rawRgba will throw exceptions. This bug is introducing a lot
//     // of encoding/decoding work.
//     final ByteData imageByteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     setState(() {
//       _backgroundSnapshot = Image.memory(imageByteData.buffer.asUint8List());
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget frostedBackground;
//     if (_backgroundSnapshot == null || _skipSnapshot) {
//       frostedBackground = RepaintBoundary(
//         key: _snapshotKey,
//         child: widget.frostBackground,
//       );
//       if (!_skipSnapshot) {
//         SchedulerBinding.instance.addPostFrameCallback(_snapshot);
//       }
//     } else {
//       // !!! We don't seem to have a way to know when IO thread
//       // decoded the image.
//       if (!_snapshotLoaded) {
//         frostedBackground = widget.frostBackground;
//         Future.delayed(Duration(seconds: 1), () {
//           setState(() {
//             _snapshotLoaded = true;
//           });
//         });
//       } else {
//         frostedBackground = Offstage();
//       }
//     }
//
//     return Stack(
//       children: <Widget>[
//         frostedBackground,
//         if (_backgroundSnapshot != null) _backgroundSnapshot,
//         widget.child,
//         GestureDetector(
//             onTap: () {
//               setState(() { _skipSnapshot = !_skipSnapshot; });
//             }
//             ),
//       ],
//     );
//   }
// }
///
// -----------------------------------------------------------------------------
