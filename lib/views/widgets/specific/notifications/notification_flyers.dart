import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';

class NotificationFlyers extends StatelessWidget {
  final double bodyWidth;
  final dynamic flyers;
  final Function onFlyerTap;


  const NotificationFlyers({
    @required this.bodyWidth,
    @required this.flyers,
    this.onFlyerTap,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: bodyWidth,
      height: 20 + 200.0,
      decoration: BoxDecoration(
        color: Colorz.White10,
        borderRadius: Borderers.superFlyerCorners(context, FlyerBox.width(context, FlyerBox.sizeFactorByHeight(context, 220)),
        ),
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: flyers.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (ctx, index){

            final String _flyerID = flyers[0].runtimeType == String ? flyers[index] : null;
            final FlyerModel _flyer = flyers[0].runtimeType == FlyerModel ? flyers[index] : null;

            return
              GestureDetector(
                onTap: onFlyerTap == null ? null : () => onFlyerTap(_flyerID ?? _flyer.flyerID),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: AbsorbPointer(
                    absorbing: onFlyerTap == null ? false : true,
                    child: FinalFlyer(
                      flyerBoxWidth: FlyerBox.width(context, FlyerBox.sizeFactorByHeight(context, 200)),
                      flyerModel: _flyer,
                      flyerID: _flyerID,
                    ),
                  ),
                ),
              );

          }
      ),
    );
  }
}
