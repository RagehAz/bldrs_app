import 'dart:async';

import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/x_pickers_editor_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/c_pickers_editors/z_components/picker_editor.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
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
  // --------------------
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
  // --------------------
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
  // --------------------
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

    final String _flyerTypeString = FlyerTyper.cipherFlyerType(widget.flyerType);

    return MainLayout(
      pageTitleVerse: Verse.plain('$_flyerTypeString Pickers Editor'),
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
                    verse: Verse.plain('Sync'),
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

            if (tempPickers == null){
              return const SizedBox();
            }

            return ReorderableListView.builder(
                itemCount: refinedPickers.length + 1,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Stratosphere.bigAppBarStratosphere,
                  bottom: Ratioz.horizon,
                ),
                onReorderStart: (int oldIndex){},
                onReorderEnd: (int newIndex){},
                onReorder: (oldIndex, newIndex) {
                  // blog('before index correction : oldIndex : $oldIndex : newIndex : $newIndex');
                  int _newIndex = newIndex;
                  if (newIndex > oldIndex) {
                    _newIndex = newIndex - 1;
                  }
                  // blog('after index correction : oldIndex : $oldIndex : newIndex : $_newIndex');

                  final List<PickerModel> _pickers = <PickerModel>[...refinedPickers];
                  final PickerModel _picker = _pickers[oldIndex];

                  // blog('before remove');
                  // PickerModel.blogIndexes(_pickers);
                  _pickers.removeAt(oldIndex);

                  // blog('after remove');
                  // PickerModel.blogIndexes(_pickers);
                  _pickers.insert(_newIndex, _picker);

                  // blog('after insert');
                  PickerModel.blogIndexes(_pickers);

                  final List<PickerModel> _corrected = PickerModel.correctModelsIndexes(_pickers);
                  // blog('after correction');
                  // PickerModel.blogIndexes(_pickers);

                  _tempPickers.value = _corrected;

                },

                itemBuilder: (BuildContext ctx, int index) {

                  final bool _isAddButton = index == refinedPickers.length;

                  /// ADD BUTTON
                  if (_isAddButton == true){

                    blog('faak');

                    return WideButton(
                      key: const ValueKey<String>('add_button'),
                      verse: const Verse(
                        text: 'Add',
                        translate: false,
                      ),
                      onTap: () => onAddNewPickers(
                        context: context,
                        tempPickers: _tempPickers,
                      ),
                    );
                  }

                  /// HEADLINE - PICKERS
                  else {

                    final PickerModel _picker = refinedPickers[index];

                    /// GROUP HEADLINE
                    if (_picker.isHeadline == true){
                      return Align(
                        key: ValueKey<String>(_picker.chainID),
                        alignment: Alignment.centerLeft,
                        child: DreamBox(
                          height: 40,
                          verse: Verse(
                            text: '$index : ${xPhrase(context, _picker.groupID)}',
                            translate: false,
                            casing: Casing.upperCase,
                          ),
                          secondLine: Verse(
                            text: _picker.chainID,
                            translate: false,
                          ),
                          margins: 10,
                          verseScaleFactor: 0.65,
                          verseItalic: true,
                          bubble: false,
                          color: Colorz.yellow125,
                          verseCentered: false,
                          onTap: () => onHeadlineTap(
                            context: context,
                            tempPickers: _tempPickers,
                            picker: _picker,
                          ),
                        ),
                      );
                    }

                    /// PICKER TILE
                    else {
                      return PickerEditingTile(
                        key: ValueKey<String>(_picker.chainID),
                        picker: _picker,
                        tempPickers: _tempPickers,
                        flyerZone: ZoneProvider.proGetCurrentZone(context: context, listen: true),
                      );
                    }

                  }


                }
            );

          },

        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
