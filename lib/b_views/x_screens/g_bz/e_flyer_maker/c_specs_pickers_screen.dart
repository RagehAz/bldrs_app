import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/cc_specs_pickers_screen_view.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class SpecsPickersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecsPickersScreen({
    @required this.flyerType,
    @required this.selectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerType flyerType;
  final List<SpecModel> selectedSpecs;
  /// --------------------------------------------------------------------------
  @override
  _SpecsPickersScreenState createState() => _SpecsPickersScreenState();
  /// --------------------------------------------------------------------------
}

class _SpecsPickersScreenState extends State<SpecsPickersScreen> with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  // AnimationController _animationController;

  List<SpecPicker> _specsPickersByFlyerType = <SpecPicker>[];
  ValueNotifier<List<SpecModel>> _allSelectedSpecs; /// tamam disposed
  ValueNotifier<List<SpecPicker>> _refinedSpecsPickers; /// tamam disposed
  ValueNotifier<List<String>> _groupsIDs; /// tamam disposed
// -----------------------------------------------------------------------------
  /*
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
   */
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // ------------------------------
    /*
    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 1),
    //   vsync: this,
    // );
     */
    // ------------------------------
    _scrollController = ScrollController();
    // ------------------------------
    _specsPickersByFlyerType = SpecPicker.getPickersByFlyerType(widget.flyerType);
    // ------------------------------
    _allSelectedSpecs = ValueNotifier<List<SpecModel>>(widget.selectedSpecs);
    // ------------------------------
    final List<SpecPicker> _theRefinedPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
      sourceSpecsPickers: _specsPickersByFlyerType,
      selectedSpecs: widget.selectedSpecs,
    );
    _refinedSpecsPickers = ValueNotifier<List<SpecPicker>>(_theRefinedPickers);
    // ------------------------------
    final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
        specsPickers: _specsPickersByFlyerType,
    );
    _groupsIDs = ValueNotifier<List<String>>(_theGroupsIDs);
    // ------------------------------
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // _loading.dispose();
    _groupsIDs.dispose();
    _refinedSpecsPickers.dispose();
    _allSelectedSpecs.dispose();
    super.dispose(); /// tamam
  }
// -----------------------------------------------------------------------------
  /*
//   Future<void> _onSpecPickerTap(SpecPicker specPicker) async {
//
//     blog('_onSpecPickerTap : chainID : ${specPicker?.chainID} : groupID : ${specPicker?.groupID}');
//     final Chain _specChain = superGetChain(context, specPicker.chainID);
//
//
//     if (_specChain.sons.runtimeType != DataCreator) {
//       await _goToSpecPickerScreen(specPicker);
//     }
//
//     else if (_specChain.sons == DataCreator.price) {
//       await _goToSpecPickerScreen(specPicker);
//     }
//
//     else if (_specChain.sons == DataCreator.currency) {
//       await _runCurrencyDialog(specPicker);
//     }
//
//     else if (_specChain.sons == DataCreator.integerIncrementer) {
//       blog('aho');
//       await _goToSpecPickerScreen(specPicker);
//     }
//
//     else if (_specChain.sons == DataCreator.doubleCreator) {
//       blog('aho');
//       await _goToSpecPickerScreen(specPicker);
//     }
//
//   }
// -----------------------------------------------------------------------------
//   Future<void> _goToSpecPickerScreen(SpecPicker specPicker) async {
//     // final List<SpecModel> _result = await Nav.goToNewScreen(
//     //   context,
//     //   SpecPickerScreen(
//     //     specPicker: specPicker,
//     //     allSelectedSpecs: _allSelectedSpecs,
//     //   ),
//     //   transitionType: Nav.superHorizontalTransition(context),
//     // );
//     //
//     // SpecModel.blogSpecs(_result);
//     //
//     // _updateSpecsPickersAndGroups(
//     //   specPicker: specPicker,
//     //   specPickerResult: _result,
//     // );
//   }
// -----------------------------------------------------------------------------
//   Future<void> _runCurrencyDialog(SpecPicker specPicker) async {
//     //
//     // await PriceDataCreator.showCurrencyDialog(
//     //   context: context,
//     //   onSelectCurrency: (CurrencyModel currency) async {
//     //     final SpecModel _currencySpec = SpecModel(
//     //       pickerChainID: specPicker.chainID,
//     //       value: currency.code,
//     //     );
//     //
//     //     final List<SpecModel> _result = SpecModel.putSpecsInSpecs(
//     //       parentSpecs: _allSelectedSpecs,
//     //       inputSpecs: <SpecModel>[_currencySpec],
//     //       canPickMany: specPicker.canPickMany,
//     //     );
//     //
//     //     _updateSpecsPickersAndGroups(
//     //       specPicker: specPicker,
//     //       specPickerResult: _result,
//     //     );
//     //
//     //     Nav.goBack(context);
//     //     // await null;
//     //   },
//     // );
//   }
// // -----------------------------------------------------------------------------
//   void _updateSpecsPickersAndGroups({
//     @required dynamic specPickerResult,
//     @required SpecPicker specPicker,
//   }) {
//
//     // final Chain _specChain = superGetChain(context, specPicker.chainID);
//     //
//     // // -------------------------------------------------------------
//     // if (specPickerResult != null) {
//     //   // ------------------------------------
//     //   /// A - SONS ARE FROM DATA CREATOR
//     //   if (_specChain.sons.runtimeType == DataCreator) {}
//     //   // ------------------------------------
//     //   /// B - WHEN FROM LIST OF KWs
//     //   if (ObjectChecker.objectIsListOfSpecs(specPickerResult)) {
//     //     // Spec.printSpecs(_allSelectedSpecs);
//     //
//     //     setState(() {
//     //
//     //       _allSelectedSpecs = specPickerResult;
//     //
//     //       _refinedSpecsPickers = SpecPicker.applyDeactivatorsToSpecsPickers(
//     //           sourceSpecsPickers: _specsPickers,
//     //           selectedSpecs: _allSelectedSpecs,
//     //       );
//     //
//     //       _groupsIDs = SpecPicker.getGroupsFromSpecsPickers(
//     //           specsPickers: _refinedSpecsPickers,
//     //       );
//     //
//     //     });
//     //   }
//     //   // ------------------------------------
//     //   /// C - WHEN SOMETHING GOES WRONG
//     //   else {
//     //     blog('RED ALERT : result : ${specPickerResult.toString()}');
//     //   }
//     //   // ------------------------------------
//     // }
//     // // -------------------------------------------------------------
//   }

   */
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _flyerTypeString = FlyerTyper.translateFlyerType(
      context: context,
      flyerType: widget.flyerType,
      pluralTranslation: false,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pyramidsAreOn: true,
      // loading: _loading,
      pageTitle: '$_flyerTypeString Specifications',
      onBack: (){
        Nav.goBack(context, passedData: _allSelectedSpecs.value);
      },
      layoutWidget: SpecsSelectorScreenView(
        scrollController: _scrollController,
        allSelectedSpecs: _allSelectedSpecs,
        refinedSpecsPickers: _refinedSpecsPickers,
        specsPickersByFlyerType: _specsPickersByFlyerType,
      ),
    );
  }

}
