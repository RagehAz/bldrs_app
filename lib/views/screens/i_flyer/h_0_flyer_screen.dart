import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
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
  final FlyerModel flyerModel;
  final int initialSlideIndex;
  final String flyerID;

  FlyerScreen({
    this.flyerModel,
    this.initialSlideIndex,
    this.flyerID,
});


  static const routeName = Routez.FlyerScreen;

  @override
  Widget build(BuildContext context) {

    String _flyerID = ModalRoute.of(context).settings.arguments as String;

    if (_flyerID == null){
      _flyerID = flyerID ?? flyerModel?.id;
    }

    print('_flyerID is $_flyerID');
    // final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    // final TinyFlyer _tinyFlyer = tinyFlyer == null ? _pro.getTinyFlyerByFlyerID(_flyerID) : tinyFlyer;
    // final BzModel _bz = _pro.getBzByBzID(_flyer?.tinyBz?.bzID);

    return MainLayout(
      appBarType: AppBarType.Non,
      pyramids: Iconz.DvBlankSVG,
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
          goesToEditor: false,
          flyerKey: PageStorageKey<String>(_flyerID),
          onSwipeFlyer: (SwipeDirection direction){
            // print('Direction is $direction');
          },
        ),

      ),
    );
  }
}
