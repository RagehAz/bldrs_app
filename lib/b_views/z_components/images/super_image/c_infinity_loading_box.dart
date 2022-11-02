import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class InfiniteLoadingBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    @required this.width,
    @required this.height,
    this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: FadeType.repeatForwards,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 1000),
      builder: (double value, Widget child){

        return Container(
          width: width,
          height: height,
          color: Colorz.white50,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * value / 1, // the ( value / 1 ) part is the percentage
            color: color ?? Colorz.white20,
          ),
        );

      },
    );

  }
/// --------------------------------------------------------------------------
}
