import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/xx_data_creator_field_row.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/xxx_data_creators_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:flutter/material.dart';

class PriceDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PriceDataCreator({
    @required this.zone,
    @required this.picker,
    @required this.initialValue,
    @required this.onKeyboardSubmitted,
    @required this.onExportSpecs,
    @required this.dataCreatorType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zone;
  final PickerModel picker;
  final dynamic initialValue;
  final Function onKeyboardSubmitted;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final DataCreator dataCreatorType;
  /// --------------------------------------------------------------------------
  @override
  State<PriceDataCreator> createState() => _PriceDataCreatorState();
/// --------------------------------------------------------------------------
}

class _PriceDataCreatorState extends State<PriceDataCreator> {
// -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<String> _selectedCurrencyID = ValueNotifier(null);
  final ValueNotifier<double> _priceValue = ValueNotifier(null); // specValue
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeCurrencyData(
      context: context,
      zone: widget.zone,
      selectedCurrencyID: _selectedCurrencyID,
      textController: _textController,
      initialValue: widget.initialValue,
      priceValue: _priceValue,
      dataCreatorType: widget.dataCreatorType,
    );


  }
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _textController.dispose();
    _selectedCurrencyID.dispose();
    _priceValue.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      title: '##Add ...',
      width: BldrsAppBar.width(context),
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          hintText: '##Add price',
          picker: widget.picker,
          validator: currencyFieldValidator,
          textController: _textController,
          formKey: _formKey,
          selectedUnitID: _selectedCurrencyID,
          onUnitSelectorButtonTap: () => onCurrencySelectorButtonTap(
            context: context,
            zone: widget.zone,
            formKey: _formKey,
            selectedCurrencyID: _selectedCurrencyID,
          ),
          onKeyboardChanged: (String text) => onKeyboardChanged(
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            textController: _textController,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
          ),
          onKeyboardSubmitted: (String text) => onKeyboardSubmitted(
            context: context,
            onKeyboardSubmitted: widget.onKeyboardSubmitted,
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            textController: _textController,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
          ),
        ),

      ],
    );

  }
}
