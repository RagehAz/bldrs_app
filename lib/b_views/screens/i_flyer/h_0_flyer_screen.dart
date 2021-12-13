import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/router/route_names.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

// === === === === === === === === === === === === === === === === === === === === === === === === === === === ===
// Flyer in Full screen mode
// side slidings : changes flyer pages, until end of flyer then gets next flyer of same Business
// story taps : same as slide slidings
// up & down slidings : gets next flyer in the collection
// if in gallery : collection flyer index = gallery flyer index,, vertical sliding exits the flyer either up or down
// pinch in : always exist flyer
// pinch out : zooms in flyer slide, while preserving header & footer
// === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

class FlyerScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerScreen({
    this.flyerModel,
    this.initialSlideIndex,
    this.flyerID,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final int initialSlideIndex;
  final String flyerID;

  /// --------------------------------------------------------------------------
  static const String routeName = Routez.flyerScreen;

  @override
  Widget build(BuildContext context) {
    String _flyerID = ModalRoute.of(context).settings.arguments as String;

    /// so assign flyerModel.id if passed argument is null
    _flyerID ??= flyerID ?? flyerModel?.id;

    blog('_flyerID is $_flyerID');
    // final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    // final TinyFlyer _tinyFlyer = tinyFlyer == null ? _pro.getTinyFlyerByFlyerID(_flyerID) : tinyFlyer;
    // final BzModel _bz = _pro.getBzByBzID(_flyer?.tinyBz?.bzID);

    return MainLayout(
      appBarType: AppBarType.non,
      pyramids: Iconz.dvBlankSVG,
      layoutWidget: Center(
        child:

            // ChangeNotifierProvider.value(
            //   value: _flyer,
            //   child: ChangeNotifierProvider.value(
            //     value: _bz,
            //     child: Flyer(
            //       flyerSizeFactor: 1,// golden factor 0.97,
            //       initialSlide: 0,
            //       slidingIsOn: true,
            //       tappingFlyerZone: (){},
            //
            //     ),
            //   ),
            // ),

            ///

            // flyerModelBuilder(
            //   context: context,
            //   tinyFlyer : _tinyFlyer,
            //   flyerSizeFactor: 1,
            //   builder: (ctx, flyerModel){
            //     return
            //         NormalFlyerWidget(
            //             flyer: flyerModel,
            //             flyerSizeFactor: 1,
            //         );
            //   }
            //
            // ),

            ///

            FinalFlyer(
          flyerBoxWidth: FlyerBox.width(context, 1),
          flyerModel: flyerModel,
          flyerID: flyerID,
          initialSlideIndex: initialSlideIndex ?? 0,
          flyerKey: PageStorageKey<String>(_flyerID),
          onSwipeFlyer: (Sliders.SwipeDirection direction) {
            // blog('Direction is $direction');
          },
        ),
      ),
    );
  }
}
