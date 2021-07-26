import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/x_normal_flyer_widget.dart';
import 'package:bldrs/views/widgets/flyer/final_flyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final TinyFlyer tinyFlyer;

  FlyerScreen({
    this.tinyFlyer,
});


  static const routeName = Routez.FlyerScreen;

  @override
  Widget build(BuildContext context) {

    final String _flyerID = ModalRoute.of(context).settings.arguments as String;
    print('_flyerID is $_flyerID');
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    final TinyFlyer _tinyFlyer = tinyFlyer == null ? _pro.getTinyFlyerByFlyerID(_flyerID) : tinyFlyer;
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
          flyerZoneWidth: Scale.superFlyerZoneWidth(context, 1),
          tinyFlyer: tinyFlyer,
          flyerID: tinyFlyer.flyerID,
        ),

      ),
    );
  }
}
