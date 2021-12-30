import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnonymousHomeScreen extends StatefulWidget {
  const AnonymousHomeScreen({Key key}) : super(key: key);

  @override
  _AnonymousHomeScreenState createState() => _AnonymousHomeScreenState();
}

class _AnonymousHomeScreenState extends State<AnonymousHomeScreen> {

// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
      _uiProvider.startController(
              () async {

                await _readFlyers();

          }
      );
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _readFlyers() async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      collName: FireColl.flyers,
      orderBy: 'id',
      limit: 6,
      addDocSnapshotToEachMap: true,
    );

    final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
        maps: _maps,
        fromJSON: false
    );

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.setWallFlyers(_flyers);

  }
// -----------------------------------------------------------------------------
  Future<void> _onFlyerTap(FlyerModel flyer) async {

    await Nav.goToNewScreen(context,
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

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final List<FlyerModel> _wallFlyers = _flyersProvider.wallFlyers;

    return FlyersGrid(
      gridZoneWidth: FlyerBox.width(context, 1),
      stratosphere: true,
      numberOfColumns: 2,
      scrollable: true,
      flyers: _wallFlyers,
      onFlyerTap: (FlyerModel flyer) => _onFlyerTap(flyer),
    );

  }
}
