import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class AllFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AllFlyersScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _AllFlyersScreenState createState() => _AllFlyersScreenState();
  /// --------------------------------------------------------------------------
}

class _AllFlyersScreenState extends State<AllFlyersScreen> {
  // -----------------------------------------------------------------------------
  List<FlyerModel> _flyers;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }
  // -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {

        blog('starting things');

        final List<dynamic> _maps = await Fire.readCollectionDocs(
          collName: FireColl.flyers,
          orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
          limit: 20,
        );

        blog('we got ${_maps.length} maps');
        final List<FlyerModel> _flyersFromMaps = FlyerModel.decipherFlyers(
          maps: _maps,
          fromJSON: false,
        );
        blog('we got ${_flyersFromMaps.length} flyers');

        setState(() {
          _flyers = _flyersFromMaps;
        });

        unawaited(_triggerLoading(setTo: false));

      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
//   Future<void> _onTapFlyer(FlyerModel flyer) async {
//
//     await BottomDialog.showButtonsBottomDialog(
//         context: context,
//         draggable: true,
//         buttonHeight: 80,
//         buttons: <Widget>[
//
//           DreamBox(
//             height: 80,
//             width: BottomDialog.clearWidth(context),
//             verse:  'Flyer by ${flyer.bzID}',
//             bubble: false,
//             verseWeight: VerseWeight.thin,
//             verseItalic: true,
//           ),
//
//           BottomDialog.wideButton(
//               context: context,
//               verse:  'Open flyer',
//               icon: Iconz.viewsIcon,
//               onTap: () async {
//
//                 await goToNewScreen(context,
//                     FlyerScreen(
//                       flyerModel: flyer,
//                       flyerID: flyer.id,
//                       initialSlideIndex: 0,
//                     )
//                 );
//               }
//           ),
//
//           BottomDialog.wideButton(
//             context: context,
//             verse:  'Promote Flyer',
//             icon: Iconz.star,
//             onTap: () async {
//               await goToNewScreen(context, FlyerPromotionScreen(
//                 flyer: flyer,
//               ));
//             }
//           ),
//
//         ],
//     );
//
//   }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitleVerse: Verse.plain('All Flyers'),
      appBarRowWidgets: const <Widget>[],
      // loading: _loading,
      layoutWidget: _flyers == null ?
      Container()
          :
      FlyersGrid(
        gridWidth: Scale.superScreenWidth(context),
        gridHeight: Scale.superScreenHeight(context),
        // numberOfColumns: 2,
        flyers: _flyers,
        scrollController: ScrollController(),
        heroPath: 'allFlyersScreenGrid',
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
