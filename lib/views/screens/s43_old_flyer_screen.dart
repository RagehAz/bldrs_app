import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/grids/flyers_grid.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OldFlyerScreen extends StatefulWidget {
  final BzModel bz;

  OldFlyerScreen({
    @required this.bz,
});

  @override
  _OldFlyerScreenState createState() => _OldFlyerScreenState();
}

class _OldFlyerScreenState extends State<OldFlyerScreen> {
  bool _isInit = true;
  List<TinyFlyer> _tinyFlyers;
// ---------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// ---------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading();

      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      // _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
      _prof.fetchAndSetOldBzFlyers(context, widget.bz)
          .then((_) async {

        List<FlyerModel> _oldFlyers = _prof.getBzOldFlyers;

        List<TinyFlyer> _bzTinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_oldFlyers);

        setState(() {
          _tinyFlyers = _bzTinyFlyers;
          _isInit = false;
        });

        _triggerLoading();
      });
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    // List<TinyFlyer> _tinyFlyers = _prof.getSavedTinyFlyers;
    List<String> _ids = TinyFlyer.getListOfFlyerIDsFromTinyFlyers(_tinyFlyers);
    print(_ids);

    return MainLayout(
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      pageTitle: 'Old Flyers',
      loading: _loading,
      layoutWidget:

      _tinyFlyers == null ?
      Loading(loading: _loading,)
          :
      FlyersGrid(
        gridZoneWidth: superScreenWidth(context),
        numberOfColumns: 3,
        tinyFlyers: _tinyFlyers,
        scrollable: true,
        stratosphere: true,
      ),

    );
  }
}
