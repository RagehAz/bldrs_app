import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/specs/data_creator.dart';
import 'package:bldrs/models/kw/specs/spec%20_list_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/zone/currency_model.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/specs/integer_data_creator.dart';
import 'package:bldrs/views/widgets/specific/specs/price_data_creator.dart';
import 'package:bldrs/views/widgets/specific/specs/specs_selector_bubble.dart';
import 'package:flutter/material.dart';

class SpecPickerScreen extends StatefulWidget {
  final SpecList specList;
  final List<Spec> allSelectedSpecs;

  const SpecPickerScreen({
    @required this.specList,
    @required this.allSelectedSpecs,
});

  static const double instructionBoxHeight = 50;

  @override
  State<SpecPickerScreen> createState() => _SpecPickerScreenState();
}

class _SpecPickerScreenState extends State<SpecPickerScreen> {

  // List<Spec> _selectedSpecs = [];
  ValueNotifier<List<Spec>> _selectedSpecs = ValueNotifier(<Spec>[]);

  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _selectedSpecs.value = widget.allSelectedSpecs;
    // Spec.getSpecsByListID(specsList: widget.allSelectedSpecs, specsListID: widget.specList.id)

    super.initState();
  }
// -----------------------------------------------------------------------------
  Future<void> _onSpecTap(BuildContext context, KW kw) async {

    // spec.printSpec();

    final Spec _spec = Spec.getSpecFromKW(
      specsListID: widget.specList.id,
      kw: kw,
    );

    final bool _alreadySelected = Spec.specsContainThisSpec(specs: _selectedSpecs.value, spec: _spec);
    final int _specIndex = _selectedSpecs.value.indexWhere((sp) => sp.value == _spec.value);

    // ----------------------------------------------------------
    /// A - ALREADY SELECTED SPEC
    if (_alreadySelected == true){

      /// A1 - CAN PICK MANY
      if (widget.specList.canPickMany == true){
        // setState(() {
          _selectedSpecs.value.removeAt(_specIndex);
        // });
      }

      /// A2 - CAN NOT PICK MANY
      else {
        // setState(() {
          _selectedSpecs.value.removeAt(_specIndex);
        // });
      }

    }
    // ----------------------------------------------------------
    /// B - NEW SELECTED SPEC
    else {

      /// B1 - WHEN CAN PICK MANY
      if (widget.specList.canPickMany == true){
        // setState(() {
          _selectedSpecs.value.add(_spec);
        // });
      }

      /// B2 - WHEN CAN NOT PICK MANY
      else {

          final int _specIndex = _selectedSpecs.value.indexWhere((spec) => spec.specsListID == widget.specList.id);

            /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
            if (_specIndex == -1){
              // setState(() {
                _selectedSpecs.value.add(_spec);
              // });
            }

            /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
            else {
              // setState(() {
                _selectedSpecs.value.removeAt(_specIndex);
                _selectedSpecs.value.add(_spec);
              // });
            }

      }

    }
    // ----------------------------------------------------------

    _selectedSpecs.notifyListeners();

  }
// -----------------------------------------------------------------------------
  void _onCurrencyChanged(CurrencyModel currency){

    final Spec _currencySpec = Spec(specsListID: 'propertyPriceCurrency', value: currency.code);

    final List<Spec> _updatedList = Spec.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: [_currencySpec],
      canPickMany: false,
    );

    // setState(() {
      _selectedSpecs.value = _updatedList;
    // });

  }
// -----------------------------------------------------------------------------
  void _onPriceChanged(String price){

    final double _priceDouble = Numeric.stringToDouble(price);
    final Spec _priceSpec = Spec(specsListID: widget.specList.id, value: _priceDouble);

    final List<Spec> _updatedList = Spec.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: [_priceSpec],
      canPickMany: widget.specList.canPickMany,
    );

      _selectedSpecs.value = _updatedList;

  }
// -----------------------------------------------------------------------------
  void _onAddInteger(int integer){

    print('received integer : ${integer}');
    final Spec _integerSpec = Spec(specsListID: widget.specList.id, value: integer);

    final List<Spec> _updatedList = Spec.putSpecsInSpecs(
      parentSpecs: _selectedSpecs.value,
      inputSpecs: [_integerSpec],
      canPickMany: widget.specList.canPickMany,
    );

    _selectedSpecs.value = _updatedList;

  }
// -----------------------------------------------------------------------------
  Future<void> _onBack() async {
    await Nav.goBack(context, argument: _selectedSpecs.value);
  }
// -----------------------------------------------------------------------------
  String _getInstructions(){
    String _instructions;

    if (widget.specList.specChain.sons.runtimeType == DataCreator){

      _instructions = 'Specify this';

    }

    else {

      _instructions = widget.specList.canPickMany == true ? 'You may pick multiple specifications from this list' : 'You can pick only one specification from this list';

    }

    return _instructions;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);

    final double _listZoneHeight = _screenHeight - Ratioz.stratosphere - SpecPickerScreen.instructionBoxHeight;

    final String _instructions = _getInstructions();

    return MainLayout(
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: Name.getNameByCurrentLingoFromNames(context, widget.specList.names),
      pyramids: Iconz.PyramidzYellow,
      onBack: _onBack,
      layoutWidget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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

          /// SPECS LIST SELECTOR
          if (widget.specList.specChain.sons.runtimeType != DataCreator)
            ValueListenableBuilder<List<Spec>>(
                valueListenable: _selectedSpecs,
                builder: (ctx, value, child){

                  return

                    SpecSelectorBubble(
                      bubbleHeight: _listZoneHeight,
                      specList: widget.specList,
                      selectedSpecs: value,
                      onSpecTap: (KW kw) => _onSpecTap(context, kw),
                    );

                }
            ),

          /// PRICE SPECS CREATOR
          if (widget.specList.specChain.sons == DataCreator.price)
            ValueListenableBuilder<List<Spec>>(
                valueListenable: _selectedSpecs,
                builder: (ctx, value, child){

                  final List<Spec> _priceSpec = Spec.getSpecsByListID(specsList: value, specsListID: widget.specList.id);

                  final double _initialPriceValue = Mapper.canLoopList(_priceSpec) ? _priceSpec[0].value : null;

                  return
                    PriceDataCreator(
                      onCurrencyChanged: (CurrencyModel currency) => _onCurrencyChanged(currency),
                      onValueChanged: (String value) => _onPriceChanged(value),
                      initialPriceValue: _initialPriceValue,
                      onSubmitted: _onBack,
                    );

                }
            ),

          /// INTEGER INCREMENTER SPECS CREATOR
          if (widget.specList.specChain.sons == DataCreator.integerIncrementer)
            ValueListenableBuilder<List<Spec>>(
                valueListenable: _selectedSpecs,
                builder: (ctx, value, child){


                  return
                    IntegerDataCreator(
                      onIntegerChanged: (int integer) => _onAddInteger(integer),
                      initialValue: null,
                      onSubmitted: _onBack,
                      specList: widget.specList,
                    );

                }
            ),

        ],

      ),
    );
  }
}

/*



 */