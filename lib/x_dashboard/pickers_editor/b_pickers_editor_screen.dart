import 'dart:async';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/picker_headline_tile.dart';
import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:scale/scale.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/pickers_editor/x_pickers_editor_controller.dart';
import 'package:bldrs/x_dashboard/pickers_editor/z_components/picker_editor.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
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
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
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

      _triggerLoading(setTo: true).then((_) async {

        setNotifier(
            notifier: _initialSpecPickers,
            mounted: mounted,
            value: widget.specPickers,
        );

        setNotifier(
            notifier: _tempPickers,
            mounted: mounted,
            value: widget.specPickers,
        );

        final List<PickerModel> _theRefinedPickers = PickerModel.applyBlockersAndSort(
          sourcePickers: widget.specPickers,
          sort: true,
          selectedSpecs: const [],
        );
        // blog('_theRefinedPickers  : $_theRefinedPickers');
        // SpecPicker.blogSpecsPickers(_theRefinedPickers);

        setNotifier(
            notifier: _refinedPickers,
            mounted: mounted,
            value: _theRefinedPickers,
        );


        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
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

    final String _flyerTypeString = FlyerTyper.cipherFlyerType(widget.flyerType);

    return MainLayout(
      title: Verse.plain('$_flyerTypeString Pickers Editor'),
      appBarType: AppBarType.search,
      loading: _loading,
      onBack: () async {

        final bool _areIdentical = PickerModel.checkPickersListsAreIdentical(
          pickers1: _initialSpecPickers.value,
          pickers2: _tempPickers.value,
        );

        if (_areIdentical == true){
          await Nav.goBack(context: context, invoker: 'PickerEditorScreen');
        }

        else {

          await Dialogs.goBackDialog(
            context: context,
            goBackOnConfirm: true,
          );

        }

      },
      // searchController: _searchController,
      // onSearchCancelled: (){
      //   _searchController.text = '';
      //   _isSearching.value  = false;
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
                      mounted: mounted,
                    ),
                  );

                },
              );

            }),

      ],
      child: Container(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        alignment: Alignment.topCenter,
        child: ValueListenableBuilder(
          valueListenable: _tempPickers,
          builder: (_, List<PickerModel> tempPickers, Widget child){

            final List<PickerModel> refinedPickers = PickerModel.applyBlockersAndSort(
              sourcePickers: tempPickers,
              selectedSpecs: const [],
              sort: true,
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

                  int _newIndex = newIndex;
                  if (newIndex > oldIndex) {
                    _newIndex = newIndex - 1;
                  }

                  onReorderPickers(
                    oldIndex: oldIndex,
                    newIndex: _newIndex,
                    tempPickers: _tempPickers,
                    refinedPickers: refinedPickers,
                    mounted: mounted,
                  );

                },

                itemBuilder: (BuildContext ctx, int index) {

                  final bool _isAddButton = index == refinedPickers.length;

                  /// ADD BUTTON
                  if (_isAddButton == true){
                    return WideButton(
                      key: const ValueKey<String>('add_button'),
                      verse: const Verse(
                        id: 'Add',
                        translate: false,
                      ),
                      onTap: () => onAddNewPickers(
                        context: context,
                        tempPickers: _tempPickers,
                        mounted: mounted,
                      ),
                    );
                  }

                  /// HEADLINE - PICKERS
                  else {

                    final PickerModel _picker = refinedPickers[index];

                    /// GROUP HEADLINE
                    if (_picker.isHeadline == true){

                      return PickerHeadlineTile(
                        key: ValueKey<String>(_picker.chainID),
                        picker: _picker,
                        secondLine: Verse(
                          id: '$index : ${_picker.chainID}',
                          translate: false,
                        ),
                        onTap: () => onHeadlineTap(
                          context: context,
                          tempPickers: _tempPickers,
                          picker: _picker,
                          mounted: mounted,
                        ),
                      );

                    }

                    /// PICKER EDITING TILE
                    else {
                      return PickerEditingTile(
                        key: ValueKey<String>(_picker.chainID),
                        picker: _picker,
                        tempPickers: _tempPickers,
                        flyerZone: ZoneProvider.proGetCurrentZone(context: context, listen: true),
                        mounted: mounted,
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
