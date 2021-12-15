import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/xxx_dashboard/flyers_manager/flyer_promotion_screen.dart';
import 'package:flutter/material.dart';

class AllFlyersScreen extends StatefulWidget {
  const AllFlyersScreen({Key key}) : super(key: key);

  @override
  _AllFlyersScreenState createState() => _AllFlyersScreenState();
}

class _AllFlyersScreenState extends State<AllFlyersScreen> {
  List<FlyerModel> _flyers;
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  bool _loading = false;
  Future<void> _triggerLoading({Function function}) async {
    if (function == null) {
      setState(() {
        _loading = !_loading;
      });
    } else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true
        ? blog('LOADING--------------------------------------')
        : blog('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {
        blog('starting things');

        final List<dynamic> _maps = await Fire.readCollectionDocs(
          collName: FireColl.flyers,
          orderBy: 'id',
          limit: 20,
        );

        blog('we got ${_maps.length} maps');
        final List<FlyerModel> _flyersFromMaps =
            FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
        blog('we got ${_flyersFromMaps.length} flyers');

        setState(() {
          _flyers = _flyersFromMaps;
        });

        /// X - REBUILD
        unawaited(_triggerLoading(function: () {
          // oldValue: _tinyFlyers,
          // newValue: _flyersFromMaps,
        }));
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  Future<void> _onTapFlyer(FlyerModel flyer) async {

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 80,
        buttons: <Widget>[

          DreamBox(
            height: 80,
            width: BottomDialog.dialogClearWidth(context),
            verse: 'Flyer by ${flyer.bzID}',
            bubble: false,
            verseWeight: VerseWeight.thin,
            verseItalic: true,
          ),

          BottomDialog.wideButton(
              context: context,
              verse: 'Open flyer',
              icon: Iconz.viewsIcon,
              onTap: () async {

                await goToNewScreen(context,
                    FlyerScreen(
                      flyerModel: flyer,
                      flyerID: flyer.id,
                      initialSlideIndex: 0,
                    )
                );
              }
          ),

          BottomDialog.wideButton(
            context: context,
            verse: 'Promote Flyer',
            icon: Iconz.star,
            onTap: () async {
              await goToNewScreen(context, FlyerPromotionScreen(
                flyer: flyer,
              ));
            }
          ),

        ],
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramids: Iconz.pyramidzYellow,
      pageTitle: 'All Flyers',
      appBarRowWidgets: const <Widget>[],
      loading: _loading,
      layoutWidget: _flyers == null ?
      Container()
          :
      FlyersGrid(
        gridZoneWidth: FlyerBox.width(context, 1),
        stratosphere: true,
        numberOfColumns: 2,
        scrollable: true,
        flyers: _flyers,
        onFlyerTap: (FlyerModel flyer) => _onTapFlyer(flyer),
      ),

      // FlyerStack(
      //   flyerSizeFactor: 0.8,
      //   title: 'All Flyers on Database',
      //   onScrollEnd: (){blog('on Scroll end here');},
      //   flyerOnTap: (flyerID) => blog('flyerID is : $flyerID'),
      //   flyersType: null,
      //   tinyFlyers: _tinyFlyers,
      //   titleIcon: null,
      // ),
    );
  }
}
