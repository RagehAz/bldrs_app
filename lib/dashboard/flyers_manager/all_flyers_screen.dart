import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class AllFlyersScreen extends StatefulWidget {

  @override
  _AllFlyersScreenState createState() => _AllFlyersScreenState();
}

class _AllFlyersScreenState extends State<AllFlyersScreen> {
  List<TinyFlyer> _tinyFlyers;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  Future <void> _triggerLoading({dynamic oldValue, dynamic newValue}) async {

    if (oldValue == null || newValue == null){
      setState(() {
        _loading = !_loading;
      });
    }

    else {
      setState(() {
        _loading = !_loading;
        oldValue = newValue;
        ;});
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

        List<dynamic> _maps = await Fire.readCollectionDocs(FireCollection.tinyFlyers);
        print('we got ${_maps.length} maps');
        List<TinyFlyer> _tinyFlyersFromMaps = TinyFlyer.decipherTinyFlyersMaps(_maps);
        print('we got ${_tinyFlyersFromMaps.length} tinyFlyers');

        setState(() {
          _tinyFlyers = _tinyFlyersFromMaps;
        });

        /// X - REBUILD
        _triggerLoading(
          // oldValue: _tinyFlyers,
          // newValue: _tinyFlyersFromMaps,
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
      appBarRowWidgets: <Widget>[],
      loading: _loading,
      layoutWidget:

      _tinyFlyers == null ?
      Container()
          :
      FlyersGrid(
        gridZoneWidth: Scale.superFlyerZoneWidth(context, 1),
        stratosphere: true,
        scrollDirection: Axis.vertical,
        numberOfColumns: 2,
        scrollable: true,
        tinyFlyerOnTap: (flyerID) => print('flyerID is : $flyerID'),
        tinyFlyers: _tinyFlyers,
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
