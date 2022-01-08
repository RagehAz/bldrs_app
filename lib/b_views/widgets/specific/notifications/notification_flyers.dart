import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NotificationFlyers extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotificationFlyers({
    @required this.bodyWidth,
    @required this.flyers,
    this.onFlyerTap,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double bodyWidth;
  final dynamic flyers;
  final Function onFlyerTap;

  /// --------------------------------------------------------------------------
  bool _absorbFlyerTap() {
    bool _absorb;

    if (onFlyerTap == null) {
      _absorb = false;
    } else {
      _absorb = true;
    }

    return _absorb;
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: bodyWidth,
      height: 20 + 200.0,
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.superFlyerCorners(
          context,
          FlyerBox.width(context, FlyerBox.sizeFactorByHeight(context, 220)),
        ),
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: flyers.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (BuildContext ctx, int index) {
            final String _flyerID =
                flyers[0].runtimeType == String ? flyers[index] : null;
            final FlyerModel _flyer =
                flyers[0].runtimeType == FlyerModel ? flyers[index] : null;

            return GestureDetector(
              onTap: onFlyerTap == null
                  ? null
                  : () => onFlyerTap(_flyerID ?? _flyer.id),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AbsorbPointer(
                  absorbing: _absorbFlyerTap(),
                  child: FinalFlyer(
                    flyerBoxWidth: FlyerBox.width(
                        context, FlyerBox.sizeFactorByHeight(context, 200)),
                    flyerModel: _flyer,
                    flyerID: _flyerID,
                    onSwipeFlyer: (Sliders.SwipeDirection direction) {
                      // print('Direction is ${direction}');
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}