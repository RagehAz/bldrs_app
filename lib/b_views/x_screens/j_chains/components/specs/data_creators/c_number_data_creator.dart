import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/xx_data_creator_field_row.dart';
import 'package:bldrs/b_views/x_screens/j_chains/controllers/xxx_data_creators_controllers.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final dynamic initialValue;
  final String initialUnit;
  final PickerModel picker;
  final Function onKeyboardSubmitted;
  final DataCreator dataCreatorType;
  final ZoneModel zone;
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
// -----------------------------------------------------------------------------
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

    final double _bubbleWidth = BldrsAppBar.width(context);
    final String _hintText = widget.picker.chainID;

    return Bubble(
      title: '##Add ...',
      width: _bubbleWidth,
      columnChildren: <Widget>[

        // /// BULLET POINTS
        // BubbleBulletPoints(
        //     bulletPoints: bulletPoints,
        // ),

        /// DATA CREATOR ROW
        NumberDataCreatorFieldRow(
          picker: widget.picker,
          validator: numberFieldValidator,
          textController: _textController,
          formKey: _formKey,
          hintText: _hintText,
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
  }

}
