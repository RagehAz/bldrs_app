import 'dart:async';

import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/x_pickers_editor_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/z_components/picker_editor.dart';
import 'package:flutter/material.dart';

class SpecPickerEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerEditorScreen({
    @required this.specPickers,
    @required this.flyerType,
    @required this.flyerZone,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<PickerModel> specPickers;
  final FlyerType flyerType;
  final ZoneModel flyerZone;
  /// --------------------------------------------------------------------------
  @override
  _SpecPickerEditorScreenState createState() => _SpecPickerEditorScreenState();
/// --------------------------------------------------------------------------
}

class _SpecPickerEditorScreenState extends State<SpecPickerEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<PickerModel>> _initialSpecPickers = ValueNotifier(<PickerModel>[]);
  final ValueNotifier<List<PickerModel>> _tempPickers = ValueNotifier(<PickerModel>[]);
  final ValueNotifier<List<PickerModel>> _refinedPickers = ValueNotifier(<PickerModel>[]);

  final PageController _pageController = PageController();
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
  Future<void> _triggerLoading({
    bool setTo,
  }) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'TestingTemplate',);
    }
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        _initialSpecPickers.value = widget.specPickers;
        _tempPickers.value = widget.specPickers;
        final List<PickerModel> _theRefinedPickers = PickerModel.applyBlockersAndSort(
          sourcePickers: widget.specPickers,
          selectedSpecs: const [],
        );
        // blog('_theRefinedPickers  : $_theRefinedPickers');
        // SpecPicker.blogSpecsPickers(_theRefinedPickers);

        _refinedPickers.value = _theRefinedPickers;

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _initialSpecPickers.dispose();
    _tempPickers.dispose();
    _refinedPickers.dispose();

    _pageController.dispose();

    _loading.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final double _screenWidth = Scale.superScreenWidth(context);
    // final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      pageTitleVerse: '##${widget.flyerType} Picker Editor',
      sectionButtonIsOn: false,
      appBarType: AppBarType.search,
      loading: _loading,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      // searchController: _searchController,
      // onSearchCancelled: (){
      //   _searchController.text = '';
      //   _isSearching.value = false;
      // },
      // onSearchChanged: (String text) => onPhrasesSearchChanged(
      //   isSearching: _isSearching,
      //   allMixedPhrases: _tempMixedPhrases.value,
      //   mixedSearchResult: _mixedSearchedPhrases,
      //   searchController: _searchController,
      // ),
      // onSearchSubmit: (String text) => onPhrasesSearchSubmit(
      //   isSearching: _isSearching,
      //   allMixedPhrases: _tempMixedPhrases.value,
      //   mixedSearchResult: _mixedSearchedPhrases,
      //   searchController: _searchController,
      // ),
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// SYNC BUTTON
        ValueListenableBuilder(
            valueListenable: _initialSpecPickers,
            builder: (_, List<PickerModel> _initial, Widget child){

              return ValueListenableBuilder(
                valueListenable: _tempPickers,
                builder: (_, List<PickerModel> _temp, Widget child){

                  final bool _areIdentical = PickerModel.checkPickersListsAreIdentical(
                    pickers1: _initial,
                    pickers2: _temp,
                  );

                  return AppBarButton(
                    verse:  'Sync',
                    isDeactivated: _areIdentical,
                    buttonColor: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    onTap: () => onSyncSpecPickers(
                      context: context,
                      initialPickers: _initialSpecPickers,
                      tempPickers :_tempPickers,
                      flyerType: widget.flyerType,
                    ),
                  );

                },
              );

            }),

      ],
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeightWithoutSafeArea(context),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _tempPickers,
          builder: (_, List<PickerModel> tempPickers, Widget child){

            final List<PickerModel> refinedPickers = PickerModel.applyBlockersAndSort(
              sourcePickers: tempPickers,
              selectedSpecs: const [],
            );

            final List<String> _theGroupsIDs = PickerModel.getGroupsIDs(
              specsPickers: refinedPickers,
            );

            return ReorderableListView.builder(
                itemCount: _theGroupsIDs.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Stratosphere.bigAppBarStratosphere,
                  bottom: Ratioz.horizon,
                ),
                onReorderStart: (int oldIndex){
                  blog('oldIndex : $oldIndex');
                },
                onReorderEnd: (int newIndex){
                  blog('newIndex : $newIndex');
                },
                onReorder: (gIndexOLD, gIndexNew) {

                  final String _groupID = _theGroupsIDs[gIndexOLD];
                  final List<PickerModel> _groupPickers = PickerModel.getPickersByGroupID(
                      pickers: _tempPickers.value,
                      groupID: _groupID,
                  );

                  int _groupIndex = gIndexNew;
                  if (gIndexNew > gIndexOLD) {
                    _groupIndex = gIndexNew - 1;
                  }
                  final int _diff = _groupIndex - gIndexOLD;

                  blog('_groupID : $_groupID : oldIndex : $gIndexOLD : newIndex : $_groupIndex : diff : ( $_diff )');

                  // /// re-order all. pickers
                  // final List<PickerModel> _temp = <PickerModel>[..._tempPickers.value];
                  // for (int x = 0; x < _groupPickers.length; x++){
                  //
                  //   final PickerModel _pickerFromGroup = _groupPickers[x];
                  //   final int _pickerOldIndex = _pickerFromGroup.index;
                  //   final int _pickerNewIndex = _pickerOldIndex + _diff;
                  //   final PickerModel _updatedPicker = _pickerFromGroup.copyWith(
                  //     index: _pickerNewIndex,
                  //   );
                  //   _temp.removeWhere((element) => element.chainID == _pickerFromGroup.chainID);
                  //   blog('$x : removed : _pickerOldIndex : ${_pickerOldIndex} : pickerID : ${_temp[_pickerOldIndex].chainID}');
                  //   _temp.insert(_pickerNewIndex, _updatedPicker);
                  //   blog('$x : inserted : _pickerNewIndex : ${_pickerNewIndex} : pickerID : ${_updatedPicker.chainID}');
                  //
                  // }
                  //
                  // /// re-assign index for all pickers
                  // final List<PickerModel> _output = <PickerModel>[];
                  // for (int i = 0; i < _temp.length; i++){
                  //   final PickerModel _updatedPicker = _temp[i].copyWith(
                  //     index: i,
                  //   );
                  //   _output.add(_updatedPicker);
                  // }
                  //
                  // /// assign values
                  // _tempPickers.value = _output;


                  /*
                  _tempPickers.value = PickerModel.updateGroupIndex(
                    pickers: _tempPickers.value,
                    oldGroupIndex: oldIndex,
                    newGroupIndex: newIndex,
                  );
                   */

                },

                itemBuilder: (BuildContext ctx, int index) {

                  final String _groupID = _theGroupsIDs[index];

                  final List<PickerModel> _pickersOfThisGroup = PickerModel.getPickersByGroupID(
                    pickers: refinedPickers,
                    groupID: _groupID,
                  );

                  // blog('groupID : $_groupID');

                  return Container(
                    key: ValueKey<String>(_groupID),
                    margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
                    color: Colorz.bloodTest,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        /// GROUP HEADLINE
                        DreamBox(
                          height: 40,
                          verse:  '$index : ${xPhrase(context, _groupID)}',
                          translateVerse: false,
                          secondLine: _groupID,
                          translateSecondLine: false,
                          verseCasing: VerseCasing.upperCase,
                          margins: 10,
                          verseScaleFactor: 0.65,
                          verseItalic: true,
                          bubble: false,
                          color: Colorz.yellow125,
                          verseCentered: false,
                          onTap: () => onUpdateGroupID(
                            context: context,
                            tempPickers: _tempPickers,
                            oldGroupID: _groupID,
                          ),
                        ),

                        /// GROUP SPECS PICKERS
                        ...List<Widget>.generate(_pickersOfThisGroup.length,
                                (int index) {

                              final PickerModel _picker = _pickersOfThisGroup[index];

                              return PickerEditingTile(
                                picker: _picker,
                                tempPickers: _tempPickers,
                                flyerZone: ZoneProvider.proGetCurrentZone(context: context, listen: true),
                              );

                            }

                        ),

                      ],
                    ),
                  );


                }
            );

          },

        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
