import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/double_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/integer_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/price_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/spec_picker_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/specs_picker_controller.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreenView({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.screenHeight,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final double screenHeight;
  /// --------------------------------------------------------------------------
  String _getInstructions({
    @required Chain specChain,
    @required SpecPicker picker,
}) {
    String _instructions;

    if (specChain.sons.runtimeType == DataCreator) {
      _instructions = 'Specify this';
    }

    else {
      _instructions = picker.canPickMany == true ?
      'You may pick multiple specifications from this list'
          :
      'You can pick only one specification from this list';
    }

    return _instructions;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Chain _specChain = superGetChain(context, specPicker.chainID);


    final double _screenWidth = Scale.superScreenWidth(context);

    final double _listZoneHeight =
        screenHeight
            - Ratioz.stratosphere
            - SpecPickerScreen.instructionBoxHeight;

    final String _instructions = _getInstructions(
      picker: specPicker,
      specChain: _specChain,
    );

    blog('SpecPickerScreen : ${_specChain.id} : sons ${_specChain.sons} : sons type ${_specChain.sons.runtimeType}');

    return Column(
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

        ValueListenableBuilder(
          valueListenable: selectedSpecs,
          builder: (BuildContext ctx, List<SpecModel> specs, Widget child) {

            final bool _isDataCreator = Chain.sonsAreDataCreator(_specChain.sons);

            /// SPECS PICKER SELECTOR
            if (_isDataCreator == false){
              return SpecPickerBubble(
                bubbleHeight: _listZoneHeight,
                specPicker: specPicker,
                selectedSpecs: SpecModel.getSpecsByPickerChainID(
                  specs: specs,
                  pickerChainID: specPicker.chainID,
                ),
                onSpecTap: (String phid) => onSelectSpec(
                  context: context,
                  phid: phid,
                  picker: specPicker,
                  selectedSpecs: selectedSpecs,
                ),
              );
            }

            /// PRICE SPECS CREATOR
            else if (_specChain.sons == DataCreator.price){

              final List<SpecModel> _priceSpec = SpecModel.getSpecsByPickerChainID(
                specs: specs,
                pickerChainID: specPicker.chainID,
              );

              final double _initialPriceValue = Mapper.canLoopList(_priceSpec) ?
              _priceSpec[0].value
                  :
              null;

              return PriceDataCreator(
                initialPriceValue: _initialPriceValue,
                onCurrencyChanged: (CurrencyModel currency) => onCurrencyChanged(
                  currency: currency,
                  selectedSpecs: selectedSpecs,
                ),
                onValueChanged: (String value) => onPriceChanged(
                  price: value,
                  picker: specPicker,
                  selectedSpecs: selectedSpecs,
                ),
                onSubmitted: () => onGoBackToSpecsPickersScreen(
                  context: context,
                  selectedSpecs: selectedSpecs,
                ),
              );

            }

            /// INTEGER INCREMENTER SPECS CREATOR
            else if (_specChain.sons == DataCreator.integerIncrementer){
              return IntegerDataCreator(
                initialValue: null,
                specPicker: specPicker,
                onIntegerChanged: (int integer) => onAddInteger(
                  integer: integer,
                  picker: specPicker,
                  selectedSpecs: selectedSpecs,
                ),
                onSubmitted: () => onGoBackToSpecsPickersScreen(
                  context: context,
                  selectedSpecs: selectedSpecs,
                ),
              );
            }

            /// DOUBLE DATA CREATOR
            else if (_specChain.sons == DataCreator.doubleCreator){
              return DoubleDataCreator(
                initialValue: null,
                specPicker: specPicker,
                onDoubleChanged: (double num) => onAddDouble(
                  num: num,
                  selectedSpecs: selectedSpecs,
                  picker: specPicker,
                ),
                onSubmitted: () => onGoBackToSpecsPickersScreen(
                  context: context,
                  selectedSpecs: selectedSpecs,
                ),
              );
            }

            else {
              return const SizedBox();
            }

          },
        ),




      ],
    );

  }
}
