import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NotificationFlyers extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotificationFlyers({
    @required this.bodyWidth,
    @required this.flyers,
    @required this.noteID,
    this.onFlyerTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bodyWidth;
  final List<FlyerModel> flyers;
  final ValueChanged<FlyerModel> onFlyerTap;
  final String noteID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: bodyWidth,
      height: 20 + 200.0,
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: FlyerDim.flyerCorners(
          context, FlyerDim.flyerWidthByFactor(context, FlyerDim.flyerFactorByFlyerHeight(context, 220)),
        ),
      ),
      child:
      Mapper.checkCanLoopList(flyers) == false ?
      const SizedBox()
          :
      flyers.length == 1 ?
      FlyerInNoteCard(
        noteID: noteID,
        flyerModel: flyers[0],
        onFlyerTap: onFlyerTap,
      )
          :
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: flyers.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemBuilder: (BuildContext ctx, int index) {

            final FlyerModel _flyer = flyers[index];

            return FlyerInNoteCard(
              noteID: noteID,
              flyerModel: _flyer,
              onFlyerTap: onFlyerTap,
            );

          }

      ),

    );

  }
/// --------------------------------------------------------------------------
}

class FlyerInNoteCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerInNoteCard({
    @required this.flyerModel,
    @required this.onFlyerTap,
    @required this.noteID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final ValueChanged<FlyerModel> onFlyerTap;
  final String noteID;
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
  // --------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onFlyerTap == null ?
      null
          :
          () => onFlyerTap(flyerModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: AbsorbPointer(
          absorbing: _absorbFlyerTap(),
          child: Flyer(
            flyerBoxWidth: FlyerDim.flyerWidthByFlyerHeight(context, 200),
            flyerModel: flyerModel,
            screenName: noteID,
          ),
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
