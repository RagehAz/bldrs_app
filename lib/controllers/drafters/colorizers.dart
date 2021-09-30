import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

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
// -----------------------------------------------------------------------------
  static Future<Color> getAverageColor(dynamic pic) async {
    File _imageFile = await Imagers.getFileFromDynamic(pic);

    img.Image bitmap =
    img.decodeImage(_imageFile.readAsBytesSync());

    int redBucket = 0;
    int greenBucket = 0;
    int blueBucket = 0;
    int pixelCount = 0;

    for (int y = 0; y < bitmap.height; y++) {
      for (int x = 0; x < bitmap.width; x++) {
        int c = bitmap.getPixel(x, y);

        pixelCount++;
        redBucket += img.getRed(c);
        greenBucket += img.getGreen(c);
        blueBucket += img.getBlue(c);
      }
    }

    Color _averageColor = Color.fromRGBO(redBucket ~/ pixelCount,
        greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);

    return _averageColor;
  }
// -----------------------------------------------------------------------------
  static Color decipherColor(String colorString){
    Color _color;

    if(colorString != null){
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      String _a = TextMod.trimTextAfterFirstSpecialCharacter(colorString, '*');
      int _alpha = Numberers.stringToInt(_a);

      /// RED
      String _rX_gX_b = TextMod.trimTextBeforeFirstSpecialCharacter(colorString, '*');
      String _r = TextMod.trimTextAfterFirstSpecialCharacter(_rX_gX_b, '*');
      int _red = Numberers.stringToInt(_r);

      /// GREEN
      String _gX_b = TextMod.trimTextBeforeFirstSpecialCharacter(_rX_gX_b, '*');
      String _g = TextMod.trimTextAfterFirstSpecialCharacter(_gX_b, '*');
      int _green = Numberers.stringToInt(_g);

      /// BLUE
      String _b = TextMod.trimTextBeforeFirstSpecialCharacter(_gX_b, '*');
      int _blue = Numberers.stringToInt(_b);

      _color = Color.fromARGB(_alpha, _red, _green, _blue);

    }

    return _color;
  }
// -----------------------------------------------------------------------------
  static String cipherColor(Color color){

      Color _color = color == null ? Colorz.Nothing : color;

      int _alpha = _color.alpha;
      int _r = _color.red;
      int _g = _color.green;
      int _b = _color.blue;

    String _string = '${_alpha}*${_r}*${_g}*${_b}';
    return _string;
  }
// -----------------------------------------------------------------------------
  static bool colorsAreTheSame(Color colorA, Color colorB){
    bool _areTheSame = false;

    if(
        colorA.alpha == colorB.alpha
        &&
        colorA.red == colorB.red
        &&
        colorA.green == colorB.green
        &&
        colorA.blue == colorB.blue
    ){
      _areTheSame = true;
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
  static Color getRandomColor(){
    List<Color> _bldrsColors = Colorz.allColorz();
    int _randomIndex = Numberers.createRandomIndex(listLength: _bldrsColors.length);
    return _bldrsColors[_randomIndex];
  }
// -----------------------------------------------------------------------------
  static bool isBlack(Color color){
    bool _isBlack = false;

    Color _black = Colorz.Black255;

    if (color !=null && color.red == _black.red && color.green == _black.green && color.blue == _black.blue){
      _isBlack = true;
    }

    return _isBlack;
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

  const BlurLayer({
    this.borders,
    this.blur = Ratioz.blur1,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color,
    this.blurIsOn = false,
  });

  @override
  Widget build(BuildContext context) {

    final bool _blurIsOn = blurIsOn == null ? false : blurIsOn;

    return Container(
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
