import 'dart:async';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/picker_group/a_pickers_group.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/c_spec_pickers_editor/spec_pickers_editor_controller.dart';
import 'package:flutter/material.dart';

class SpecPickerEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerEditorScreen({
    @required this.specPickers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<SpecPicker> specPickers;
  /// --------------------------------------------------------------------------
  @override
  _SpecPickerEditorScreenState createState() => _SpecPickerEditorScreenState();
/// --------------------------------------------------------------------------
}

class _SpecPickerEditorScreenState extends State<SpecPickerEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<List<SpecPicker>> _initialSpecPickers = ValueNotifier(<SpecPicker>[]);
  final ValueNotifier<List<SpecPicker>> _tempPickers = ValueNotifier(<SpecPicker>[]);
  final ValueNotifier<List<SpecPicker>> _refinedPickers = ValueNotifier(<SpecPicker>[]);

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
        final List<SpecPicker> _theRefinedPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
          sourceSpecsPickers: widget.specPickers,
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
      onBack: () => Dialogz.goBackDialog(
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
            builder: (_, List<SpecPicker> _initial, Widget child){

              return ValueListenableBuilder(
                valueListenable: _tempPickers,
                builder: (_, List<SpecPicker> _temp, Widget child){

                  final bool _areIdentical = SpecPicker.checkSpecPickersListsAreIdentical(
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
                      initialSpecPickers: _initialSpecPickers,
                      tempSpecPickers :_tempPickers,
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
          builder: (_, List<SpecPicker> tempPickers, Widget child){

            return ValueListenableBuilder(
                valueListenable: _refinedPickers,
                builder: (_, List<SpecPicker> refinedPickers, Widget childB){

                  final List<String> _theGroupsIDs = SpecPicker.getGroupsIDs(
                    specsPickers: refinedPickers,
                  );

                  Stringer.blogStrings(strings: _theGroupsIDs);

                  return ListView.builder(
                      itemCount: _theGroupsIDs.length,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: Stratosphere.bigAppBarStratosphere,
                        bottom: Ratioz.horizon,
                      ),
                      itemBuilder: (BuildContext ctx, int index) {

                        final String _groupID = _theGroupsIDs[index];

                        final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
                          specsPickers: refinedPickers,
                          groupID: _groupID,
                        );

                        blog('groupID : $_groupID');

                        return SpecsPickersGroup(
                          headline: _groupID.toUpperCase(),
                          selectedSpecs: ValueNotifier([]),
                          groupPickers: _pickersOfThisGroup,
                          onPickerTap: (SpecPicker picker){
                            picker.blogSpecPicker();
                          },
                          onDeleteSpec: (List<SpecModel> specs){
                            SpecModel.blogSpecs(specs);
                          },
                        );

                      }
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
