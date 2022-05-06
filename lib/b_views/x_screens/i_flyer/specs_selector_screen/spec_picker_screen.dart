import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/double_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/integer_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/price_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/specs_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreen({
    @required this.specPicker,
    @required this.allSelectedSpecs,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final List<SpecModel> allSelectedSpecs;
  /// --------------------------------------------------------------------------
  static const double instructionBoxHeight = 50;
  /// --------------------------------------------------------------------------
  @override
  State<SpecPickerScreen> createState() => _SpecPickerScreenState();
  /// --------------------------------------------------------------------------
}

class _SpecPickerScreenState extends State<SpecPickerScreen> {

  // List<Spec> _selectedSpecs = [];
  final ValueNotifier<List<SpecModel>> _selectedSpecs = ValueNotifier<List<SpecModel>>(<SpecModel>[]); /// dispose
  // -----------------------------------------------------------------------------
  Chain _specChain;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    _selectedSpecs.value = widget.allSelectedSpecs;
    // Spec.getSpecsByListID(specsList: widget.allSelectedSpecs, specsListID: widget.specList.id)
    _specChain = superGetChain(context, widget.specPicker.chainID);

    super.initState();
  }
  // -----------------------------------------------------------------------------
  @override
  void dispose(){
    super.dispose();
    _selectedSpecs.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecTap(BuildContext context, String keywordID) async {
    blog('received kw id : $keywordID');

    // spec.printSpec();
    final SpecModel _spec = SpecModel(
      pickerChainID: widget.specPicker.chainID,
      value: keywordID,
    );

    final bool _alreadySelected = SpecModel.specsContainThisSpec(specs: _selectedSpecs.value, spec: _spec);
    final int _specIndex = _selectedSpecs.value.indexWhere((SpecModel sp) => sp.value == _spec.value);

    // ----------------------------------------------------------
    /// A - ALREADY SELECTED SPEC
    if (_alreadySelected == true) {
      /// A1 - CAN PICK MANY
      if (widget.specPicker.canPickMany == true) {
        final List<SpecModel> _specs = [..._selectedSpecs.value];
        _specs.removeAt(_specIndex);
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value.removeAt(_specIndex);
      }

      /// A2 - CAN NOT PICK MANY
      else {
        final List<SpecModel> _specs = [..._selectedSpecs.value];
        _specs.removeAt(_specIndex);
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value.removeAt(_specIndex);

      }
    }
    // ----------------------------------------------------------
    /// B - NEW SELECTED SPEC
    else {
      /// B1 - WHEN CAN PICK MANY
      if (widget.specPicker.canPickMany == true) {
        final List<SpecModel> _specs = [..._selectedSpecs.value, _spec];
        _selectedSpecs.value = _specs;

        // _selectedSpecs.value .add(_spec);

      }

      /// B2 - WHEN CAN NOT PICK MANY
      else {
        final int _specIndex = _selectedSpecs.value
            .indexWhere((SpecModel spec) => spec.pickerChainID == widget.specPicker.chainID);

        /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
        if (_specIndex == -1) {
          final List<SpecModel> _specs = [..._selectedSpecs.value, _spec];
          _selectedSpecs.value = _specs;

          // _selectedSpecs.value.add(_spec);

        }

        /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
        else {
          final List<SpecModel> _specs = [..._selectedSpecs.value];
          _specs.removeAt(_specIndex);
          _specs.add(_spec);
          _selectedSpecs.value = _specs;

          // _selectedSpecs.value.removeAt(_specIndex);
          // _selectedSpecs.value.add(_spec);

        }
      }
    }
    // ----------------------------------------------------------

    // _selectedSpecs.notifyListeners();
  }
// -----------------------------------------------------------------------------
  void _onCurrencyChanged(CurrencyModel currency) {

    final SpecModel _currencySpec = SpecModel(
        pickerChainID: 'currency',
        value: currency.code,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_currencySpec],
      canPickMany: false,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onPriceChanged(String price) {
    final double _priceDouble = Numeric.stringToDouble(price);
    final SpecModel _priceSpec = SpecModel(pickerChainID: widget.specPicker.chainID, value: _priceDouble);
    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_priceSpec],
      canPickMany: widget.specPicker.canPickMany,
    );
    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onAddInteger(int integer) {

    blog('received integer : $integer');
    final SpecModel _integerSpec = SpecModel(
        pickerChainID: widget.specPicker.chainID,
        value: integer,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_integerSpec],
      canPickMany: widget.specPicker.canPickMany,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onAddDouble(double num) {

    blog('received double : $num');
    final SpecModel _doubleSpec = SpecModel(
        pickerChainID: widget.specPicker.chainID,
        value: num,
    );

    final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: <SpecModel>[_doubleSpec],
      canPickMany: widget.specPicker.canPickMany,
    );

    _selectedSpecs.value = _updatedList;
  }
// -----------------------------------------------------------------------------
  void _onBack() {
    Nav.goBack(context, argument: _selectedSpecs.value);
    // await null;
  }
// -----------------------------------------------------------------------------
  String _getInstructions() {
    String _instructions;

    if (_specChain.sons.runtimeType == DataCreator) {
      _instructions = 'Specify this';
    }

    else {
      _instructions = widget.specPicker.canPickMany == true
          ? 'You may pick multiple specifications from this list'
          : 'You can pick only one specification from this list';
    }

    return _instructions;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final double _listZoneHeight =
              _screenHeight
            - Ratioz.stratosphere
            - SpecPickerScreen.instructionBoxHeight;

    final String _instructions = _getInstructions();

    final String _pageTitle = superPhrase(context, widget.specPicker.chainID);

    return MainLayout(
      appBarType: AppBarType.basic,
      // appBarBackButton: true,
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: _pageTitle,
      pyramidsAreOn: true,
      onBack: _onBack,
      layoutWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          const Stratosphere(),

          /// INSTRUCTIONS BOX HEIGHT
          Container(
            width: _screenWidth,
            height: SpecPickerScreen.instructionBoxHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
            child: SuperVerse(
              verse: _instructions,
              maxLines: 3,
              weight: VerseWeight.thin,
              italic: true,
              color: Colorz.white125,
            ),
            // color: Colorz.white10,
          ),

          /// SPECS PICKER SELECTOR
          if (_specChain.sons.runtimeType != DataCreator)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {

                  return SpecSelectorBubble(
                    bubbleHeight: _listZoneHeight,
                    specList: widget.specPicker,
                    selectedSpecs: SpecModel.getSpecsByPickerChainID(
                        specs: value,
                        pickerChainID: widget.specPicker.chainID,
                    ),
                    onSpecTap: (String keywordID) => _onSpecTap(context, keywordID),
                  );
                }
                ),

          /// PRICE SPECS CREATOR
          if (_specChain.sons == DataCreator.price)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  final List<SpecModel> _priceSpec = SpecModel.getSpecsByPickerChainID(
                      specs: value, pickerChainID: widget.specPicker.chainID);

                  final double _initialPriceValue = Mapper.canLoopList(_priceSpec) ?
                  _priceSpec[0].value
                      :
                  null;

                  return PriceDataCreator(
                    onCurrencyChanged: (CurrencyModel currency) => _onCurrencyChanged(currency),
                    onValueChanged: (String value) => _onPriceChanged(value),
                    initialPriceValue: _initialPriceValue,
                    onSubmitted: _onBack,
                  );
                }),

          /// INTEGER INCREMENTER SPECS CREATOR
          if (_specChain.sons == DataCreator.integerIncrementer)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  return IntegerDataCreator(
                    onIntegerChanged: (int integer) => _onAddInteger(integer),
                    initialValue: null,
                    onSubmitted: _onBack,
                    specList: widget.specPicker,
                  );
                }),

          /// DOUBLE DATA CREATOR
          if (_specChain.sons == DataCreator.doubleCreator)
            ValueListenableBuilder<List<SpecModel>>(
                valueListenable: _selectedSpecs,
                builder: (BuildContext ctx, List<SpecModel> value, Widget child) {
                  return DoubleDataCreator(
                    onDoubleChanged: (double num) => _onAddDouble(num),
                    initialValue: null,
                    onSubmitted: _onBack,
                    specList: widget.specPicker,
                  );
                }),

        ],
      ),
    );
  }
}

/*



 */