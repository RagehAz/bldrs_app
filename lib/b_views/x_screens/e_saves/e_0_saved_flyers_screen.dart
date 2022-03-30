import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/y_views/e_saves/saved_flyers_view.dart';
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

class _SavedFlyersScreenState extends State<SavedFlyersScreen> {
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
// -----------------------------------------------------------------------------
  void _passSelectedFlyersBack(){

    /// shall pass selected flyers through flyers provider
    Nav.goBack(context, argument:
    // _selectedFlyers
    [],
    );

  }
// -----------------------------------------------------------------------------
  final ValueNotifier<FlyerType> _currentFlyerType = ValueNotifier(FlyerType.all);
  void onChangeCurrentFlyerType(FlyerType flyerType){
    _currentFlyerType.value = flyerType;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
