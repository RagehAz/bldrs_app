import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:flutter/material.dart';

class SingleSlideBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SingleSlideBox({
    @required this.flyerBoxWidth,
    @required this.flyerBoxHeight,
    @required this.tinyMode,
    @required this.slideMidColor,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final bool tinyMode;
  final Color slideMidColor;
  final List<Widget> children;
// -----------------------------------------------------------------------------
  bool _canTapSlide(){
    bool _canTap = false;

    if (tinyMode == false){
      _canTap = true;
    }

    return _canTap;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !_canTapSlide(),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          Container(
            width: flyerBoxWidth,
            height: flyerBoxHeight,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: FlyerBox.corners(context, flyerBoxWidth),
              color: slideMidColor,
              // image: slideModel.pic,
            ),
            child: ClipRRect(
              borderRadius: FlyerBox.corners(context, flyerBoxWidth),
              child: Stack(
                alignment: Alignment.topCenter,
                children: children,
              ),
            ),
          ),

        ],
      ),

    );
  }
}
