import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_grid.dart';
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
  Future <void> _triggerLoading({Function function}) async {

    if (function == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        function();
      });
    }

    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _triggerLoading().then((_) async {

        print('starting things');

        final List<dynamic> _maps = await Fire.readCollectionDocs(
          collName: FireColl.flyers,
          orderBy: 'id',
          limit: 5,
        );

        print('we got ${_maps.length} maps');
        final List<FlyerModel> _flyersFromMaps = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
        print('we got ${_flyersFromMaps.length} flyers');

        setState(() {
          _flyers = _flyersFromMaps;
        });

        /// X - REBUILD
        _triggerLoading(
          // oldValue: _tinyFlyers,
          // newValue: _flyersFromMaps,
        );

      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.Basic,
      pyramids: Iconz.PyramidzYellow,
      pageTitle: 'All Flyers',
      appBarRowWidgets: const <Widget>[],
      loading: _loading,
      layoutWidget:

      _flyers == null ?
      Container()
          :
      FlyersGrid(
        gridZoneWidth: FlyerBox.width(context, 1),
        stratosphere: true,
        scrollDirection: Axis.vertical,
        numberOfColumns: 2,
        scrollable: true,
        tinyFlyerOnTap: (flyerID) => print('flyerID is : $flyerID'),
        flyers: _flyers,
      ),


      // FlyerStack(
      //   flyerSizeFactor: 0.8,
      //   title: 'All Flyers on Database',
      //   onScrollEnd: (){print('on Scroll end here');},
      //   flyerOnTap: (flyerID) => print('flyerID is : $flyerID'),
      //   flyersType: null,
      //   tinyFlyers: _tinyFlyers,
      //   titleIcon: null,
      // ),
    );
  }
}
