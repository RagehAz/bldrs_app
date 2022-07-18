import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/x_screens/e_saves/aa_saved_flyers_screen_view.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
}

// with AutomaticKeepAliveClientMixin<SavedFlyersScreen>
class _SavedFlyersScreenState extends State<SavedFlyersScreen>  {
  // @override
  // bool get wantKeepAlive => true;
// -----------------------------------------------------------------------------
  ScrollController _flyersGridScrollController;
  ScrollController _sliverNestedScrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _flyersGridScrollController = ScrollController();
    _sliverNestedScrollController = ScrollController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {

    // final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    // _uiProvider.startController((){
    //
    // });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _currentFlyerType.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  void _passSelectedFlyersBack(){

    /// shall pass selected flyers through flyers provider
    Nav.goBack(context, passedData:
    // _selectedFlyers
    [],
    );

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<FlyerType> _currentFlyerType = ValueNotifier(FlyerType.all); /// tamam disposed
  void onChangeCurrentFlyerType(FlyerType flyerType){
    _currentFlyerType.value = flyerType;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pageTitle: superPhrase(context, 'phid_savedFlyers'),
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      layoutWidget:

      SavedFlyersScreenView(
        selectionMode: widget.selectionMode,
        currentFlyerType : _currentFlyerType,
        onChangeCurrentFlyerType: onChangeCurrentFlyerType,
        flyersGridScrollController: _flyersGridScrollController,
        sliverNestedScrollController: _sliverNestedScrollController,
      ),

    );

  }
}
