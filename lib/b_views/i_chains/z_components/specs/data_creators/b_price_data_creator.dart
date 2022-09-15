import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_data_creator_field_row.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/xxx_data_creators_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class PriceDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const PriceDataCreator({
    @required this.zone,
    @required this.picker,
    @required this.initialValue,
    @required this.initialCurrencyID,
    @required this.onKeyboardSubmitted,
    @required this.onExportSpecs,
    @required this.dataCreatorType,
    @required this.onlyUseCityChains,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zone;
  final PickerModel picker;
  final SpecModel initialValue;
  final String initialCurrencyID;
  final Function onKeyboardSubmitted;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final DataCreator dataCreatorType;
  final bool onlyUseCityChains;
  final AppBarType appBarType;
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
      initialCurrencyID: widget.initialCurrencyID,
      priceValue: _priceValue,
      dataCreatorType: widget.dataCreatorType,
    );


  }
  // --------------------
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
      headerViewModel: const BubbleHeaderVM(
        headlineVerse: Verse(
          text: 'phid_add_with_dots',
          translate: true,
          pseudo: 'Add ...',
        ),
      ),
      width: BldrsAppBar.width(context),
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          appBarType: widget.appBarType,
          hasUnit: true,
          hintVerse: const Verse(
            text: 'phid_add_price',
            translate: true,
          ),
          validator: (String text) => currencyFieldValidator(
            context: context,
            selectedCurrencyID: _selectedCurrencyID,
            textController: _textController,
          ),
          textController: _textController,
          formKey: _formKey,
          selectedUnitID: _selectedCurrencyID,
          onUnitSelectorButtonTap: () => onCurrencySelectorButtonTap(
            specValue: _priceValue,
            onExportSpecs: widget.onExportSpecs,
            picker: widget.picker,
            textController: _textController,
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
  // -----------------------------------------------------------------------------
}
