import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;

class ObeliskPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskPyramids({
    @required this.isExpanded,
    @required this.isFlashing,
    @required this.isYellow,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final ValueNotifier<bool> isFlashing;
  final bool isYellow;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskPyramids'),
      valueListenable: isExpanded,
      builder: (_, bool expanded, Widget child){

        return Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(right: 17 * 0.7),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 500),
              curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
              scale: expanded == true ? 0.95 : 1,
              alignment: Alignment.bottomRight,
              child: child,
            ),
          ),
        );

        },

      child: GestureDetector(
        onTap: (){

          if (isExpanded.value == null || isExpanded.value == false){
            isExpanded.value = true;
          }
          else {
            isExpanded.value = false;
          }

          },
        child: Stack(
          children: <Widget>[

            /// FLASHING PYRAMIDS BLACK FOOTPRINT
            const SuperImage(
              width: 256 * 0.7,
              height: 80 * 0.7,
              iconColor: Colorz.black255,
              pic: Iconz.pyramidsWhiteClean,
              boxFit: BoxFit.fitWidth,
            ),

            /// PYRAMIDS GRAPHIC
            ValueListenableBuilder(
              valueListenable: isFlashing,
              builder: (_, bool isFlashing, Widget child){

                return WidgetFader(
                  fadeType: isFlashing ? FadeType.repeatAndReverse : FadeType.stillAtMax,
                  duration: const Duration(milliseconds: 1000),
                  child: child,
                );

                },
              child: SuperImage(
                width: 256 * 0.7,
                height: 80 * 0.7,
                pic: isYellow ? Iconz.pyramidsYellowClean : Iconz.pyramidsWhiteClean,
                boxFit: BoxFit.fitWidth,
              ),
            ),

          ],
        ),
      ),

    );

  }
}
