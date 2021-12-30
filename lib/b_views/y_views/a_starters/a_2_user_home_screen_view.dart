import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

                final List<dynamic> _maps = await Fire.readCollectionDocs(
                  collName: FireColl.flyers,
                  orderBy: 'id',
                  limit: 6,
                  addDocSnapshotToEachMap: true,
                );

                final List<FlyerModel> _flyersFromMaps = FlyerModel.decipherFlyers(
                    maps: _maps,
                    fromJSON: false
                );

              }
              );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onFlyerTap(FlyerModel flyer) async {

    await goToNewScreen(context,
        FlyerScreen(
          flyerModel: flyer,
          flyerID: flyer.id,
          initialSlideIndex: 0,
        )
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyersGrid(
      gridZoneWidth: FlyerBox.width(context, 1),
      stratosphere: true,
      numberOfColumns: 2,
      scrollable: true,
      flyers: [FlyerModel.dummyFlyer(), FlyerModel.dummyFlyer(), FlyerModel.dummyFlyer(), FlyerModel.dummyFlyer()],
      onFlyerTap: (FlyerModel flyer) => _onFlyerTap(flyer),
    );

  }
}
