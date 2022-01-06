import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/tab_layout_model.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
const List<FlyerType> sectionsTabs = sectionsList;
// -----------------------------------------------------------------------------
void createSavedFlyersTabModels({
  @required BuildContext context,
  @required TabController tabController,
  @required bool selectionMode,
  @required List<FlyerModel> allFlyers,
}){

  final List<TabModel> _models = <TabModel>[];


  for (int i = 0; i < sectionsTabs.length; i++) {

    _models.add(

        TabModel(

          tabButton: _createSectionTabButton(
              context: context,
              tabIndex: i,
              tabController: tabController
          ),
          page: _createSavedFlyersGridPage(
            context: context,
            selectionMode: selectionMode,
            allFlyers: allFlyers,
            section: sectionsTabs[i],
          ),
        )

    );
  }

  // return _models;

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.setSavedFlyersTabModels(_models);

}
// -----------------------------------------------------------------------------
Widget _createSectionTabButton({
  @required BuildContext context,
  @required int tabIndex,
  @required TabController tabController,
}){

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final int _currentTabIndex = _uiProvider.savedFlyersCurrentTabIndex;

  const List<FlyerType> _sectionsTabs = sectionsList;
  final FlyerType _section = _sectionsTabs[tabIndex];

  return
    TabButton(
      key: ValueKey<String>('saved_flyer_tab_button_$tabIndex'),
      verse: TextGen.flyerTypePluralStringer(context, _section),
      icon: Iconizer.flyerTypeIconOff(_section),
      isSelected: _sectionsTabs[_currentTabIndex] == _section,
      onTap: () {

        onSetCurrentTab(
          context: context,
          tabIndex: tabIndex,
          tabController: tabController,
        );

      },
    );
}
// -----------------------------------------------------------------------------
Widget _createSavedFlyersGridPage({
  @required BuildContext context,
  @required bool selectionMode,
  @required List<FlyerModel> allFlyers,
  @required FlyerType section,
}){

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final List<FlyerModel> _selectedFlyers = _flyersProvider.selectedFlyers;

  return
    SavedFlyersGrid(
      key: ValueKey<String>('saved_flyers_grid_page_$section'),
      selectionMode: selectionMode,
      onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
        context: context,
        flyer: flyer,
      ),
      selectedFlyers: _selectedFlyers,
      flyers: FlyerModel.filterFlyersByFlyerType(
        flyers: allFlyers,
        flyerType: section,
      ),
    );

}
// -----------------------------------------------------------------------------
void onSetCurrentTab({
  @required BuildContext context,
  @required int tabIndex,
  @required TabController tabController,
}){

  /// set saved flyers current tab index
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  _uiProvider.setSavedFlyersCurrentTabIndex(tabIndex);

  /// REBUILD TAB MODELS
  _uiProvider.setSavedFlyersCurrentTabIndex(tabIndex);
  // setState(() {
  //   _tabModels = createTabModels();
  // });


  /// ANIMATE
  tabController.animateTo(tabIndex,
      curve: Curves.easeIn,
      duration: Ratioz.duration150ms
  );

}
// -----------------------------------------------------------------------------
/// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
/// THE NEW CORRECT SEXY STUFF BABY
// -----------------------------------------------------------------------------
int getInitialTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final FlyerType _currentTab = _uiProvider.currentSavedFlyerTypeTab;
  final int _index = getFlyerTypeIndexFromSectionsTabs(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
void onChangeTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -----------------------------------------------------------------------------
void onChangeTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final FlyerType _newFlyerType = sectionsTabs[index];
  final FlyerType _previousTab = _uiProvider.currentSavedFlyerTypeTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newFlyerType != _previousTab){
    // blog('index is $index');
    _uiProvider.setCurrentFlyerTypeTab(_newFlyerType);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
// -----------------------------------------------------------------------------
void onSelectFlyerFromSavedFlyers({
  @required BuildContext context,
  @required FlyerModel flyer,
}) {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final List<FlyerModel> _selectedFlyers = _flyersProvider.selectedFlyers;


  final bool _alreadySelected = FlyerModel.flyersContainThisID(
    flyers: _selectedFlyers,
    flyerID: flyer.id,
  );

  if (_alreadySelected == true) {

    _flyersProvider.removeFlyerFromSelectedFlyers(flyer);
    // _tabModels = createTabModels();

  }

  else {
    _flyersProvider.addFlyerToSelectedFlyers(flyer);
    // _tabModels = createTabModels();
  }

}
// -----------------------------------------------------------------------------
