import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/b_picker_screen.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/data_creator_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:basics/helpers/widgets/drawing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:flutter/material.dart';

class PickerScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickerScreenBrowseView({
    required this.picker,
    required this.selectedSpecs,
    required this.screenHeight,
    required this.showInstructions,
    required this.isMultipleSelectionMode,
    required this.onlyUseZoneChains,
    required this.zone,
    required this.onKeyboardSubmitted,
    required this.appBarType,
    required this.searchText,
    required this.onExportSpecs,
    required this.onPhidTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PickerModel? picker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final double screenHeight;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final ZoneModel? zone;
  final ValueChanged<String?>? onKeyboardSubmitted;
  final AppBarType appBarType;
  final ValueNotifier<dynamic> searchText;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final Function(String? path, String? phid)? onPhidTap;
  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  double _getListZoneHeight(BuildContext context){

    final double _instructionsBoxHeight = showInstructions == true ?
    PickerScreen.instructionBoxHeight
        :
    0;

    final double _stratosphere = Stratosphere.getStratosphereValue(
        context: context,
        appBarType: appBarType
    );

    final double _listZoneHeight = screenHeight - _stratosphere - _instructionsBoxHeight;

    return _listZoneHeight;
  }
  // -----------------------------------------------------------------------------
  /// SINGLE PICKER INSTRUCTIONS
  Verse _getInstructions(BuildContext context){
    Verse _instructions;

    final Chain? _chain = ChainsProvider.proFindChainByID(
      chainID: picker?.chainID,
      onlyUseZoneChains: onlyUseZoneChains,
    );

    final bool _sonsAreDataCreator = DataCreation.checkIsDataCreator(_chain?.sons);

    /// WHEN DATA CREATORS
    if (_sonsAreDataCreator == true) {
      _instructions = const Verse(
        id: '##Specify this',
        translate: true
      );
    }

    /// WHEN PHIDS
    else {
      _instructions = Verse(
        id: Mapper.boolIsTrue(picker?.canPickMany) == true ?
        '##You may pick multiple specifications from this list'
            :
        '##You can pick only one specification from this list',
        translate: true,
      );
    }

    return _instructions;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _listZoneHeight = _getListZoneHeight(context);
    // --------------------
    final Verse? _instructions = _getInstructions(context);
    _instructions?.blogVerse(invoker: 'PickersScreenView');
    // --------------------
    return Column(
      key: const ValueKey<String>('PickersScreenView'),
      children: <Widget>[

        Stratosphere(bigAppBar: appBarType == AppBarType.search),

        /// INSTRUCTIONS BOX
        if (showInstructions == true && _instructions != null)
          ChainInstructions(
            instructions: _instructions,
          ),

        /// DATA CREATOR SPLITTER
        ValueListenableBuilder(
          valueListenable: selectedSpecs,
          builder: (BuildContext ctx, List<SpecModel> specs, Widget? child) {

            return DataCreatorSplitter(
              appBarType: appBarType,
              height: _listZoneHeight,
              picker: picker,
              onlyUseZoneChains: onlyUseZoneChains,
              selectedSpecs: specs,
              zone: zone,
              onKeyboardSubmitted: onKeyboardSubmitted,
              isMultipleSelectionMode: isMultipleSelectionMode,
              searchText: searchText,
              onExportSpecs: onExportSpecs,
              onPhidTap: onPhidTap,
              isCollapsable: true,
            );

          },
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
