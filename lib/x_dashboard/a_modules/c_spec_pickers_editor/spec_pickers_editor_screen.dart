import 'dart:async';

import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/b_pickers_group_headline.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/spec_pickers_editor_controller.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/widgets/picker_editor.dart';
import 'package:flutter/material.dart';

class SpecPickerEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerEditorScreen({
    @required this.specPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<PickerModel> specPickers;
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
        final List<PickerModel> _theRefinedPickers = PickerModel.applyBlockers(
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
      pageTitle: 'Phrases Editor',
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
                    verse: 'Sync',
                    isDeactivated: _areIdentical,
                    buttonColor: Colorz.yellow255,
                    verseColor: Colorz.black255,
                    onTap: () => onSyncSpecPickers(
                      context: context,
                      initialPickers: _initialSpecPickers,
                      tempPickers :_tempPickers,
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

            final List<PickerModel> refinedPickers = PickerModel.applyBlockers(
              sourcePickers: tempPickers,
              selectedSpecs: const [],
            );

            final List<String> _theGroupsIDs = PickerModel.getGroupsIDs(
              specsPickers: refinedPickers,
            );

            return ListView.builder(
                itemCount: _theGroupsIDs.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Stratosphere.bigAppBarStratosphere,
                  bottom: Ratioz.horizon,
                ),
                itemBuilder: (BuildContext ctx, int index) {

                  final String _groupID = _theGroupsIDs[index];

                  final List<PickerModel> _pickersOfThisGroup = PickerModel.getPickersByGroupID(
                    pickers: refinedPickers,
                    groupID: _groupID,
                  );

                  blog('groupID : $_groupID');

                  return Padding(
                    key: const ValueKey<String>('SpecsPickersGroup'),
                    padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
                    child: Column(
                      children: <Widget>[

                        /// GROUP HEADLINE
                        PickersGroupHeadline(
                          headline:  _groupID.toUpperCase(),
                        ),

                        /// GROUP SPECS PICKERS
                        ...List<Widget>.generate(_pickersOfThisGroup.length,
                                (int index) {

                              final PickerModel _picker = _pickersOfThisGroup[index];

                              return PickerEditor(
                                picker: _picker,
                                tempPickers: _tempPickers,
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
