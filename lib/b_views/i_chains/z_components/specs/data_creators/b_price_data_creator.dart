import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/xxx_data_creators_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_data_creator_field_row.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/lib/bubbles.dart';
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
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneModel zone;
  final PickerModel picker;
  final SpecModel initialValue;
  final String initialCurrencyID;
  final ValueChanged<String> onKeyboardSubmitted;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final DataCreator dataCreatorType;
  final bool onlyUseCityChains;
  final AppBarType appBarType;
  final double width;
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
      initialCurrencyID: widget.initialCurrencyID,
      priceValue: _priceValue,
      dataCreatorType: widget.dataCreatorType,
      mounted: mounted,
    );


  }
  // --------------------
  @override
  void dispose() {
    _textController.dispose();
    _selectedCurrencyID.dispose();
    _priceValue.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String _validator(String text){
    return Formers.currencyFieldValidator(
      context: context,
      selectedCurrencyID: _selectedCurrencyID,
      text: _textController.text,
      picker: widget.picker,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      key: const ValueKey('PriceDataCreator'),
      bubbleColor: Formers.validatorBubbleColor(
        validator: () => _validator(_textController.text),
      ),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        headlineVerse: const Verse(
          id: 'phid_add_with_dots',
          translate: true,
        ),
      ),
      width: widget.width ?? BldrsAppBar.width(context),
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          width: widget.width,
          appBarType: widget.appBarType,
          hasUnit: true,
          hintVerse: const Verse(
            id: 'phid_add_price',
            translate: true,
          ),
          validator: (String text) => _validator(_textController.text),
          textController: _textController,
          formKey: _formKey,
          selectedUnitID: _selectedCurrencyID,
          onUnitSelectorButtonTap: () => onCurrencySelectorButtonTap(
            specValue: _priceValue,
            onExportSpecs: widget.onExportSpecs,
            picker: widget.picker,
            text: _textController.text,
            context: context,
            zone: widget.zone,
            formKey: _formKey,
            selectedCurrencyID: _selectedCurrencyID,
            mounted: mounted,
          ),
          onKeyboardChanged: (String text) => onDataCreatorKeyboardChanged(
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
          onKeyboardSubmitted: (String text) => onDataCreatorKeyboardSubmittedAnd(
            context: context,
            onKeyboardSubmitted: widget.onKeyboardSubmitted,
            formKey: _formKey,
            specValue: _priceValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedCurrencyID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
