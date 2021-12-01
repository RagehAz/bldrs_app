import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/fire/ops/flyer_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_grid.dart';
import 'package:flutter/material.dart';

class DeactivatedFlyerScreen extends StatefulWidget {
  final BzModel bz;

  const DeactivatedFlyerScreen({
    @required this.bz,
    Key key,
  }) : super(key: key);

  @override
  _DeactivatedFlyerScreenState createState() => _DeactivatedFlyerScreenState();
}

class _DeactivatedFlyerScreenState extends State<DeactivatedFlyerScreen> {
  bool _isInit = true;
  List<FlyerModel> _allFlyers;
  List<FlyerModel> _deactivatedFlyers;
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
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading();

      // final OldFlyersProvider _prof = Provider.of<OldFlyersProvider>(context, listen: true);
      //
      // // _prof.fetchAndSetTinyBzzAndTinyFlyers(context)
      // _prof.fetchAndSetBzDeactivatedFlyers(context, widget.bz)
      //     .then((_) async {
      //
      //   _deactivatedFlyers = _prof.getBzDeactivatedFlyers;
      //
      //   final List<TinyFlyer> _bzTinyFlyers = TinyFlyer.getTinyFlyersFromFlyersModels(_deactivatedFlyers);
      //
      //   setState(() {
      //     _tinyFlyers = _bzTinyFlyers;
      //     _isInit = false;
      //   }
      //   );

        _triggerLoading();
      // });
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  FlyerModel _getFlyerFromDeactivatedFlyersByFlyerID({String flyerID}){

    final int _index = _deactivatedFlyers.indexWhere((flyer) => flyer.id == flyerID, );

    final FlyerModel _flyer = _deactivatedFlyers[_index];
    return _flyer;
  }

  void _slideFlyerOptions(BuildContext context, FlyerModel flyerModel){

    const double _buttonHeight = 50;

    BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: _buttonHeight,
      buttons: <Widget>[

        /// --- DELETE Flyer
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.XSmall,
          iconSizeFactor: 0.5,
          iconColor: Colorz.black230,
          verse: 'delete flyer',
          verseScaleFactor: 1.2,
          verseWeight: VerseWeight.black,
          verseColor: Colorz.black230,
          // verseWeight: VerseWeight.thin,
          onTap: () => _deleteFlyerOnTap(flyerModel),
        ),

        /// --- RE-PUBLISH FLYER
        DreamBox(
            height: _buttonHeight,
            width: BottomDialog.dialogClearWidth(context),
            icon: Iconz.XSmall,
            iconSizeFactor: 0.5,
            iconColor: Colorz.red255,
            verse: 'Re-publish flyer',
            verseScaleFactor: 1.2,
            verseColor: Colorz.red255,
            // verseWeight: VerseWeight.thin,
            onTap: () => _republishFlyerOnTap(flyerModel)

        ),

        /// --- EDIT FLYER
        DreamBox(
          height: _buttonHeight,
          width: BottomDialog.dialogClearWidth(context),
          icon: Iconz.Gears,
          iconSizeFactor: 0.5,
          verse: 'Edit flyer',
          verseScaleFactor: 1.2,
          verseColor: Colorz.white255,
          onTap: () => _editFlyerOnTap(flyerModel),
        ),

      ],

    );

  }
// -----------------------------------------------------------------------------
  Future<void> _deleteFlyerOnTap(FlyerModel flyerModel) async {
    print ('deleting flyer : ${flyerModel.id}');

    /// close bottom sheet
    Nav.goBack(context);

    /// delete flyer ops
    await FireFlyerOps.deleteFlyerOps(
      context: context,
      flyerModel: _getFlyerFromDeactivatedFlyersByFlyerID(flyerID: flyerModel.id),
      bzModel: widget.bz,
      deleteFlyerIDFromBzzFlyersIDs: true,
    );

    final int _flyerIndex = _allFlyers.indexWhere((tFlyer) => tFlyer.id == flyerModel.id);

    setState(() {
      _allFlyers.removeAt(_flyerIndex);
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
  void _republishFlyerOnTap(FlyerModel flyerModel){
    print('re-publishing flyer : ${flyerModel.id}');
  }
// -----------------------------------------------------------------------------
  void _editFlyerOnTap(FlyerModel flyerModel){
    print('Editing flyer : ${flyerModel.id}');
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    // FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    // List<TinyFlyer> _tinyFlyers = _prof.getSavedTinyFlyers;
    final List<String> _ids = FlyerModel.getFlyersIDsFromFlyers(_allFlyers);
    print(_ids);

    return MainLayout(
      skyType: SkyType.Black,
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      pageTitle: 'Old Flyers',
      loading: _loading,
      layoutWidget:

      _allFlyers == null ?
      Loading(loading: _loading,)
          :
      FlyersGrid(
        gridZoneWidth: Scale.superScreenWidth(context),
        numberOfColumns: 3,
        flyers: _allFlyers,
        scrollable: true,
        stratosphere: true,
        tinyFlyerOnTap: (tinyFlyer){
          print('tiny flyer is : ${tinyFlyer.id}');

          _slideFlyerOptions(context, tinyFlyer);

        },
      ),

    );
  }
}
