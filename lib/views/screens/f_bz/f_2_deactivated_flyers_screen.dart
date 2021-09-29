import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeactivatedFlyerScreen extends StatefulWidget {
  final BzModel bz;

  DeactivatedFlyerScreen({
    @required this.bz,
});

  @override
  _DeactivatedFlyerScreenState createState() => _DeactivatedFlyerScreenState();
}

class _DeactivatedFlyerScreenState extends State<DeactivatedFlyerScreen> {
  bool _isInit = true;
  List<TinyFlyer> _tinyFlyers;
  List<FlyerModel> _deactivatedFlyers;
// -----------------------------------------------------------------------------
  /// --- LOADING BLOCK
  bool _loading = false;
  void _triggerLoading(){
    setState(() {_loading = !_loading;});
    _loading == true?
    print('LOADING--------------------------------------') : print('LOADING COMPLETE--------------------------------------');
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading();

      FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);

      // _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
      _prof.fetchAndSetBzDeactivatedFlyers(context, widget.bz)
          .then((_) async {

        _deactivatedFlyers = _prof.getBzDeactivatedFlyers;

        List<TinyFlyer> _bzTinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_deactivatedFlyers);

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
  FlyerModel _searchFlyerByTinyFlyer({TinyFlyer tinyFlyer}){

    int _index = _deactivatedFlyers.indexWhere((flyer) => flyer.flyerID == tinyFlyer.flyerID, );

    FlyerModel _flyer = _deactivatedFlyers[_index];
    return _flyer;
  }

  void _slideFlyerOptions(BuildContext context, TinyFlyer tinyFlyer){

    double _buttonHeight = 50;

    BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      buttons: <Widget>[

        // --- DELETE Flyer
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.XSmall,
          iconSizeFactor: 0.5,
          iconColor: Colorz.Black230,
          verse: 'delete flyer',
          verseScaleFactor: 1.2,
          verseWeight: VerseWeight.black,
          verseColor: Colorz.Black230,
          // verseWeight: VerseWeight.thin,
          onTap: () => _deleteFlyerOnTap(tinyFlyer),
        ),

        // --- RE-PUBLISH FLYER
        DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.Red255,
            verse: 'Re-publish flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.Red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _republishFlyerOnTap(tinyFlyer)

        ),

        // --- EDIT FLYER
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.Gears,
          iconSizeFactor: 0.5,
          verse: 'Edit flyer',
          verseScaleFactor: 1.2,
          verseColor: Colorz.White255,
          onTap: () => _editFlyerOnTap(tinyFlyer),
        ),

      ],

    );

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteFlyerOnTap(TinyFlyer tinyFlyer) async {
    print ('deleting flyer : ${tinyFlyer.flyerID}');

    /// close bottom sheet
    Nav.goBack(context);

    /// delete flyer ops
    await FlyerOps().deleteFlyerOps(
      context: context,
      flyerModel: _searchFlyerByTinyFlyer(tinyFlyer: tinyFlyer),
      bzModel: widget.bz,
    );

    int _flyerIndex = _tinyFlyers.indexWhere((tFlyer) => tFlyer.flyerID == tinyFlyer.flyerID);

    setState(() {
      _tinyFlyers.removeAt(_flyerIndex);
      _deactivatedFlyers.removeAt(_flyerIndex);
    });

    /// show success dialog
    await CenterDialog.showCenterDialog(
      context: context,
      body: 'Flyer has been deleted',
      boolDialog: false,
      title: 'Great !',
    );
  }
// -----------------------------------------------------------------------------
  void _republishFlyerOnTap(TinyFlyer tinyFlyer){
    print('re-publishing flyer : ${tinyFlyer.flyerID}');
  }
// -----------------------------------------------------------------------------
  void _editFlyerOnTap(TinyFlyer tinyFlyer){
    print('Editing flyer : ${tinyFlyer.flyerID}');
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
      // appBarBackButton: true,
      pageTitle: 'Old Flyers',
      loading: _loading,
      layoutWidget:

      _tinyFlyers == null ?
      Loading(loading: _loading,)
          :
      FlyersGrid(
        gridZoneWidth: Scale.superScreenWidth(context),
        numberOfColumns: 3,
        tinyFlyers: _tinyFlyers,
        scrollable: true,
        stratosphere: true,
        tinyFlyerOnTap: (tinyFlyer){
          print('tiny flyer is : ${tinyFlyer.flyerID}');

          _slideFlyerOptions(context, tinyFlyer);

        },
      ),

    );
  }
}
