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

class NumberDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NumberDataCreator({
    @required this.onExportSpecs,
    @required this.initialValue,
    @required this.initialUnit,
    @required this.picker,
    @required this.onKeyboardSubmitted,
    @required this.dataCreatorType,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final SpecModel initialValue;
  final String initialUnit;
  final PickerModel picker;
  final Function onKeyboardSubmitted;
  final DataCreator dataCreatorType;
  final ZoneModel zone;
  final bool onlyUseCityChains;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  State<NumberDataCreator> createState() => _NumberDataCreatorState();
  /// --------------------------------------------------------------------------
}

class _NumberDataCreatorState extends State<NumberDataCreator> {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final ValueNotifier<dynamic> _specValue = ValueNotifier(null);
  final ValueNotifier<String> _selectedUnitID = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeNumberData(
      context: context,
      selectedUnitID: _selectedUnitID,
      initialUnit: widget.initialUnit,
      picker: widget.picker,
      textController: _textController,
      dataCreatorType: widget.dataCreatorType,
      specValue: _specValue,
      initialValue: widget.initialValue,
    );

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _textController.dispose();
    _specValue.dispose();
    _selectedUnitID.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = BldrsAppBar.width(context);

    // --------------------
    return Bubble(
      headerViewModel: const BubbleHeaderVM(
        headlineVerse: Verse(
          text: 'phid_add_with_dots',
          translate: true,
        ),
      ),
      width: _bubbleWidth,
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          appBarType: widget.appBarType,
          hasUnit: true,
          validator: numberFieldValidator,
          textController: _textController,
          formKey: _formKey,
          hintVerse: Verse(
            text: widget.picker.chainID,
            translate: true,
          ),
          selectedUnitID: _selectedUnitID,
          onUnitSelectorButtonTap: () => onUnitSelectorButtonTap(
            context: context,
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            textController: _textController,
            selectedUnitID: _selectedUnitID,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
          ),
          onKeyboardChanged: (String text) => onKeyboardChanged(
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            textController: _textController,
            selectedUnitID: _selectedUnitID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
          ),
          onKeyboardSubmitted: (String text) => onKeyboardSubmitted(
            context: context,
            onKeyboardSubmitted: widget.onKeyboardSubmitted,
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            textController: _textController,
            selectedUnitID: _selectedUnitID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
          ),
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
