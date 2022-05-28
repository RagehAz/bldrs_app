import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
          context: context,
          collName: FireColl.flyers,
          orderBy: const Fire.QueryOrderBy(fieldName: 'id', descending: true),
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
//             verse: 'Flyer by ${flyer.bzID}',
//             bubble: false,
//             verseWeight: VerseWeight.thin,
//             verseItalic: true,
//           ),
//
//           BottomDialog.wideButton(
//               context: context,
//               verse: 'Open flyer',
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
//             verse: 'Promote Flyer',
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
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      pageTitle: 'All Flyers',
      appBarRowWidgets: const <Widget>[],
      // loading: _loading,
      layoutWidget: _flyers == null ?
      Container()
          :
      FlyersGrid(
        gridWidth: superScreenWidth(context),
        gridHeight: superScreenHeight(context),
        numberOfColumns: 2,
        flyers: _flyers,
        scrollController: ScrollController(),
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
