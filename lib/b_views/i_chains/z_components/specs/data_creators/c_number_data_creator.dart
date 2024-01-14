import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/xxx_data_creators_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/xx_data_creator_field_row.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class NumberDataCreator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NumberDataCreator({
    required this.onExportSpecs,
    required this.initialValue,
    required this.initialUnit,
    required this.picker,
    required this.onKeyboardSubmitted,
    required this.dataCreatorType,
    required this.zone,
    required this.onlyUseZoneChains,
    required this.appBarType,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<List<SpecModel>>? onExportSpecs;
  final SpecModel? initialValue;
  final String initialUnit;
  final PickerModel? picker;
  final ValueChanged<String?>? onKeyboardSubmitted;
  final DataCreator? dataCreatorType;
  final ZoneModel? zone;
  final bool onlyUseZoneChains;
  final AppBarType appBarType;
  final double? width;
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
  final ValueNotifier<String?> _selectedUnitID = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeNumberData(
      selectedUnitID: _selectedUnitID,
      initialUnit: widget.initialUnit,
      picker: widget.picker,
      textController: _textController,
      dataCreatorType: widget.dataCreatorType,
      specValue: _specValue,
      initialValue: widget.initialValue,
      mounted: mounted
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        initializeNumberData(
            selectedUnitID: _selectedUnitID,
            initialUnit: widget.initialUnit,
            picker: widget.picker,
            textController: _textController,
            dataCreatorType: widget.dataCreatorType,
            specValue: _specValue,
            initialValue: widget.initialValue,
            mounted: mounted
        );

      });


    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _textController.dispose();
    _specValue.dispose();
    _selectedUnitID.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String? _validator(String? text){
    return Formers.numberDataCreatorFieldValidator(
      text: text,
      picker: widget.picker,
      dataCreatorType: widget.dataCreatorType,
      selectedUnitID: _selectedUnitID.value,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _bubbleWidth = widget.width ?? Bubble.bubbleWidth(context: context);
    // --------------------
    return Bubble(
      key:  const ValueKey<String>('NumberDataCreator'),
      bubbleColor: Formers.validatorBubbleColor(
        validator: () => _validator(_textController.text),
      ),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_add_with_dots',
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
          width: _bubbleWidth,
          appBarType: widget.appBarType,
          hasUnit: widget.picker?.unitChainID != null,
          validator: (String? text) => _validator(text),
          textController: _textController,
          formKey: _formKey,
          hintVerse: Verse(
            id: widget.picker?.chainID,
            translate: true,
          ),
          selectedUnitID: _selectedUnitID,
          onUnitSelectorButtonTap: () => onUnitSelectorButtonTap(
            context: context,
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedUnitID,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
          onKeyboardChanged: (String? text) => onDataCreatorKeyboardChanged(
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedUnitID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
          onKeyboardSubmitted: (String? text) => onDataCreatorKeyboardSubmittedAnd(
            context: context,
            onKeyboardSubmitted: widget.onKeyboardSubmitted,
            formKey: _formKey,
            specValue: _specValue,
            dataCreatorType: widget.dataCreatorType,
            text: _textController.text,
            selectedUnitID: _selectedUnitID.value,
            picker: widget.picker,
            onExportSpecs: widget.onExportSpecs,
            mounted: mounted,
          ),
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
