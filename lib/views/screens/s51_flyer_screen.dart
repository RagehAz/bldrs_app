import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/flyer.dart';
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
  static const routeName = Routez.FlyerScreen;

  @override
  Widget build(BuildContext context) {

    final String _flyerID = ModalRoute.of(context).settings.arguments as String;
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: false);
    final FlyerModel _flyer = _pro.getFlyerByFlyerID(_flyerID);
    final BzModel _bz = _pro.getBzByBzID(_flyer.tinyBz.bzID);

    return MainLayout(
      // appBarIsOn: false,
      // pyramids: false,
      // ragehIsOn: true,
      // tappingRageh: (){print()},
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: Center(
        child:

        ChangeNotifierProvider.value(
          value: _flyer,
          child: ChangeNotifierProvider.value(
            value: _bz,
            child: Flyer(
              flyerSizeFactor: 1,// golden factor 0.97,
              initialSlide: 0,
              slidingIsOn: true,
              tappingFlyerZone: (){},

            ),
          ),
        ),

      ),
    );
  }
}
