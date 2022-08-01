import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/saved_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/e_saves_controllers/saves_screen_controllers.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  ScrollController _scrollController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _scrollController.dispose();
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
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);

    blog('SavedFlyersScreen : ${_userModel.savedFlyersIDs}');

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pageTitle: superPhrase(context, 'phid_savedFlyers'),
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      layoutWidget:

      // SavedFlyersScreenView(
      //   selectionMode: widget.selectionMode,
      //   currentFlyerType : _currentFlyerType,
      //   onChangeCurrentFlyerType: onChangeCurrentFlyerType,
      //   flyersGridScrollController: _flyersGridScrollController,
      //   sliverNestedScrollController: _sliverNestedScrollController,
      // ),

      widget.selectionMode == true ?

      Consumer<FlyersProvider>(
        builder: (_, FlyersProvider flyersProvider, Widget child){

          final List<FlyerModel> _selectedFlyers = flyersProvider.selectedFlyers;

          return SavedFlyersGrid(
              scrollController: _scrollController,
              selectionMode: true,
              onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
                context: context,
                flyer: flyer,
              ),
              selectedFlyers: _selectedFlyers,
              flyersIDs: _userModel.savedFlyersIDs,
            );

        },
      )

      :

      SavedFlyersGrid(
        scrollController: _scrollController,
        selectionMode: false,
        flyersIDs: _userModel.savedFlyersIDs,
      ),

    );

  }
}
