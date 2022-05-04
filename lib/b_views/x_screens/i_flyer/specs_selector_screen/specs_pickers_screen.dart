import 'dart:async';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/unfinished_max_bounce_navigator.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/specs/price_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/spec_list_tile.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/spec_picker_screen.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecsPickersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecsPickersScreen({
    @required this.flyerType,
    @required this.selectedSpecs,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final FlyerTypeClass.FlyerType flyerType;
  final List<SpecModel> selectedSpecs;

  /// --------------------------------------------------------------------------
  @override
  _SpecsPickersScreenState createState() =>
      _SpecsPickersScreenState();

  /// --------------------------------------------------------------------------
}

class _SpecsPickersScreenState extends State<SpecsPickersScreen> with SingleTickerProviderStateMixin {
  List<SpecModel> _allSelectedSpecs;

  ScrollController _scrollController;
  // AnimationController _animationController;

  List<SpecPicker> _specsPickers = <SpecPicker>[];
  List<SpecPicker> _refinedSpecsPickers = <SpecPicker>[];
  List<String> _groupsIDs = <String>[];
// -----------------------------------------------------------------------------
  /// --- FUTURE LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading({bool setTo}) async {

    if (setTo != null){
      _loading.value = setTo;
    }
    else {
      _loading.value = !_loading.value;
    }

    if (_loading.value == true) {
      blog('LOADING --------------------------------------');
    } else {
      blog('LOADING COMPLETE -----------------------------');
    }

  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _scrollController = ScrollController();

    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // );

    _specsPickers = SpecPicker.getSpecsPickersByFlyerType(widget.flyerType);
    _allSelectedSpecs = widget.selectedSpecs;
    _refinedSpecsPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
        sourceSpecsPickers: _specsPickers,
        selectedSpecs: _allSelectedSpecs,
    );

    _groupsIDs = SpecPicker.getGroupsFromSpecsPickers(
        specsPickers: _specsPickers,
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecPickerTap(SpecPicker specPicker) async {

    blog('_onSpecPickerTap : chainID : ${specPicker?.chainID} : groupID : ${specPicker?.groupID}');
    final Chain _specChain = superGetChain(context, specPicker.chainID);


    if (_specChain.sons.runtimeType != DataCreator) {
      await _goToSpecPickerScreen(specPicker);
    }

    else if (_specChain.sons == DataCreator.price) {
      await _goToSpecPickerScreen(specPicker);
    }

    else if (_specChain.sons == DataCreator.currency) {
      await _runCurrencyDialog(specPicker);
    }

    else if (_specChain.sons == DataCreator.integerIncrementer) {
      blog('aho');
      await _goToSpecPickerScreen(specPicker);
    }

    else if (_specChain.sons == DataCreator.doubleCreator) {
      blog('aho');
      await _goToSpecPickerScreen(specPicker);
    }

  }
// -----------------------------------------------------------------------------
  Future<void> _goToSpecPickerScreen(SpecPicker specPicker) async {
    final List<SpecModel> _result = await Nav.goToNewScreen(
      context,
      SpecPickerScreen(
        specPicker: specPicker,
        allSelectedSpecs: _allSelectedSpecs,
      ),
      transitionType: Nav.superHorizontalTransition(context),
    );

    SpecModel.blogSpecs(_result);

    _updateSpecsPickersAndGroups(
      specPicker: specPicker,
      specPickerResult: _result,
    );
  }
// -----------------------------------------------------------------------------
  Future<void> _runCurrencyDialog(SpecPicker specPicker) async {
    await PriceDataCreator.showCurrencyDialog(
      context: context,
      onSelectCurrency: (CurrencyModel currency) async {
        final SpecModel _currencySpec = SpecModel(
          pickerChainID: specPicker.chainID,
          value: currency.code,
        );

        final List<SpecModel> _result = SpecModel.putSpecsInSpecs(
          parentSpecs: _allSelectedSpecs,
          inputSpecs: <SpecModel>[_currencySpec],
          canPickMany: specPicker.canPickMany,
        );

        _updateSpecsPickersAndGroups(
          specPicker: specPicker,
          specPickerResult: _result,
        );

        Nav.goBack(context);
        // await null;
      },
    );
  }
// -----------------------------------------------------------------------------
  void _updateSpecsPickersAndGroups({
    @required dynamic specPickerResult,
    @required SpecPicker specPicker,
  }) {

    final Chain _specChain = superGetChain(context, specPicker.chainID);

    // -------------------------------------------------------------
    if (specPickerResult != null) {
      // ------------------------------------
      /// A - SONS ARE FROM DATA CREATOR
      if (_specChain.sons.runtimeType == DataCreator) {}
      // ------------------------------------
      /// B - WHEN FROM LIST OF KWs
      if (ObjectChecker.objectIsListOfSpecs(specPickerResult)) {
        // Spec.printSpecs(_allSelectedSpecs);

        setState(() {

          _allSelectedSpecs = specPickerResult;

          _refinedSpecsPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
              sourceSpecsPickers: _specsPickers,
              selectedSpecs: _allSelectedSpecs,
          );

          _groupsIDs = SpecPicker.getGroupsFromSpecsPickers(
              specsPickers: _refinedSpecsPickers,
          );

        });
      }
      // ------------------------------------
      /// C - WHEN SOMETHING GOES WRONG
      else {
        blog('RED ALERT : result : ${specPickerResult.toString()}');
      }
      // ------------------------------------
    }
    // -------------------------------------------------------------
  }
// -----------------------------------------------------------------------------
  void _removeSpec(SpecModel spec) {
    setState(() {
      _allSelectedSpecs.remove(spec);
    });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
//     const double _specTileHeight = 70;
//     final double _specTileWidth = _screenWidth - (Ratioz.appBarMargin * 2);
    // final BorderRadius _tileBorders = Borderers.superBorderAll(context, Ratioz.appBarCorner);
    // final double _specNameBoxWidth = _specTileWidth - (2 * _specTileHeight);
// -----------------------------------------------------------------------------

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      // loading: _loading,
      pageTitle: 'Select Flyer Specifications',
      onBack: (){

        Nav.goBack(context, argument: _allSelectedSpecs);

      },
      layoutWidget: SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: Scroller(
          controller: _scrollController,
          child: ListView.builder(
              itemCount: _groupsIDs.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  top: Ratioz.stratosphere,
                  bottom: Ratioz.horizon,
              ),
              itemBuilder: (BuildContext ctx, int index) {

                final String _groupID = _groupsIDs[index];

                final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
                  specsPickers: _refinedSpecsPickers,
                  groupID: _groupID,
                );

                return SizedBox(
                  width: _screenHeight,
                  // height: 80 + (_pickersOfThisGroup.length * (SpecListTile.height() + 5)),
                  child: Column(
                    children: <Widget>[

                      /// GROUP TITLE
                      Container(
                        width: _screenHeight,
                        height: 50,
                        margin: const EdgeInsets.only(top: Ratioz.appBarMargin),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // color: Colorz.bloodTest,
                        child: SuperVerse(
                          verse: _groupID.toUpperCase(),
                          weight: VerseWeight.black,
                          centered: false,
                          margin: 10,
                          size: 3,
                          scaleFactor: 0.85,
                          italic: true,
                          color: Colorz.yellow125,
                        ),
                      ),

                      /// GROUP SPECS PICKERS
                      SizedBox(
                        width: _screenHeight,
                        // height: (_listsOfThisGroup.length * (SpecListTile.height() + 5)),

                        child: Column(
                          children: <Widget>[

                            ...List<Widget>.generate(_pickersOfThisGroup.length,
                                (int index) {

                              final SpecPicker _specPicker = _pickersOfThisGroup[index];
                              final List<SpecModel> _selectedSpecs = SpecModel.getSpecsByPickerChainID(
                                specs: _allSelectedSpecs,
                                pickerChainID: _specPicker.chainID,
                              );

                              return SpecPickerTile(
                                onTap: () => _onSpecPickerTap(_specPicker),
                                specPicker: _specPicker,
                                sourceSpecsPickers: _specsPickers,
                                selectedSpecs: _selectedSpecs,
                                onDeleteSpec: (SpecModel spec) => _removeSpec(spec),
                              );

                            }),
                          ],
                        ),
                      ),

                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
