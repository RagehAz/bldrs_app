
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class TheBoxOfDreamBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TheBoxOfDreamBox({
    @required this.inActiveMode,
    @required this.opacity,
    @required this.boxMargins,
    @required this.width,
    @required this.height,
    @required this.boxColor,
    @required this.cornersAsBorderRadius,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool inActiveMode;
  final double opacity;
  final EdgeInsets boxMargins;
  final double width;
  final double height;
  final Color boxColor;
  final BorderRadius cornersAsBorderRadius;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IntrinsicWidth(
          child: Opacity(
            opacity: inActiveMode == true ? 0.7 : opacity,
            child: Padding(
              padding: boxMargins,
              child: ClipRRect(
                borderRadius: cornersAsBorderRadius,
                child: Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color:
                      boxColor == Colorz.nothing ? Colorz.nothing
                          :
                      inActiveMode == true ?
                      Colorz.white10
                          :
                      boxColor,

                      // borderRadius: cornersAsBorderRadius,
                      // boxShadow: const <BoxShadow>[
                        // CustomBoxShadow(
                        //     color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                        //     offset: new Offset(0, 0),
                        //     blurRadius: height * 0.15,
                        //     blurStyle: BlurStyle.outer
                        // ),
                      // ]
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }
  /// --------------------------------------------------------------------------
}
