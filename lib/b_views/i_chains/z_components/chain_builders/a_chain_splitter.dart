import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/b_chains_builder.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/c_chain_builder.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/i_chains/z_components/pickers/data_creator_splitter.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum ChainSecondLinesType {
  non,
  id,
  indexAndID,
}

/// SPLITS CHAIN OR CHAINS OR SON OR SONS INTO DESIGNATED WIDGET
class ChainSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSplitter({
    @required this.chainOrChainsOrSonOrSons,
    @required this.initiallyExpanded,
    @required this.secondLinesType,
    @required this.onPhidTap,
    @required this.onPhidLongTap,
    @required this.onPhidDoubleTap,
    @required this.selectedPhids,
    @required this.searchText,
    @required this.onExportSpecs,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    this.onDataCreatorKeyboardSubmitted,
    this.previousPath = '',
    this.level = 0,
    this.width,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic chainOrChainsOrSonOrSons;
  final int level;
  final String previousPath;
  final double width;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<dynamic> searchText;
  final ChainSecondLinesType secondLinesType;
  final Function(String path, String phid) onPhidTap;
  final Function(String path, String phid) onPhidDoubleTap;
  final Function(String path, String phid) onPhidLongTap;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final ZoneModel zone;
  final ValueChanged<String> onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Verse createSecondLineVerse(ChainSecondLinesType type, String phid, {int index}){
    String _output;

    if (type == ChainSecondLinesType.id){
      _output = phid;
    }
    else if (type == ChainSecondLinesType.indexAndID){
      final int _index = Phider.getIndexFromPhid(phid);
      final String _phid = Phider.removeIndexFromPhid(phid: phid);

      final String _outsideIndex = Numeric.formatNumberWithinDigits(num: index, digits: 4);
      final String _indexFromPhid = Numeric.formatNumberWithinDigits(num: _index, digits: 4);
      _output = index == null ? '$_indexFromPhid : $_phid' : '$_outsideIndex : $_indexFromPhid : $_phid';
    }

    if (_output == null){
      return null;
    }
    else {
      return Verse(text: _output, translate: false);
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = width ?? BldrsAppBar.width(context);
    // --------------------
    /// IF SON IS A PHID
    if (Phider.checkIsPhid(chainOrChainsOrSonOrSons) == true) {

      final String _phid = chainOrChainsOrSonOrSons;
      final String _path = ChainPathConverter.fixPathFormatting('$previousPath/$_phid/');

      final bool _isSelected = Stringer.checkStringsContainString(
        strings: selectedPhids,
        string: _phid,
      );

      return PhidButton(
        phid: _phid,
        secondLine: createSecondLineVerse(secondLinesType, _phid),
        width: _width,
        level: level,
        searchText: searchText,
        color: _isSelected == true ? Colorz.blue125 : Colorz.white20,
        onPhidTap: () => onPhidTap(_path, _phid),
        onPhidDoubleTap: () => onPhidDoubleTap(_path, _phid),
        onPhidLongTap: () => onPhidLongTap(_path, _phid),
        // inverseAlignment: ,
        // margins: ,
        // isDisabled: ,
        // xIsOn: ,
      );

    }
    // --------------------
    /// IF SONS IS PHIDS
    else if (Phider.checkIsPhids(chainOrChainsOrSonOrSons) == true){
      return ChainsBuilder(
        width: _width,
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath,
        level: level,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        secondLinesType: secondLinesType,
        onPhidTap: onPhidTap,
        onPhidDoubleTap: onPhidDoubleTap,
        onPhidLongTap: onPhidLongTap,
        onExportSpecs: onExportSpecs,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
        zone: zone,
        onlyUseCityChains: onlyUseCityChains,
        isMultipleSelectionMode: isMultipleSelectionMode,
      );
    }
    // --------------------
    /// IF SON IS CHAIN
    else if (chainOrChainsOrSonOrSons is Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      final Chain _chain = chainOrChainsOrSonOrSons;

      return ChainBuilder(
        key: PageStorageKey<String>(_chain.id),
        previousPath: previousPath,
        chain: _chain,
        boxWidth: _width,
        icon: _chainsProvider.getPhidIcon(son: chainOrChainsOrSonOrSons, context: context),
        firstHeadline: Verse(
          text: Phider.removeIndexFromPhid(phid: _chain.id),
          translate: true,
        ),
        secondHeadline: createSecondLineVerse(secondLinesType, _chain.id),
        initiallyExpanded: initiallyExpanded,
        level: level,
        selectedPhids: selectedPhids,
        searchText: searchText,
        secondLinesType: secondLinesType,

        onPhidTap: onPhidTap,
        onPhidDoubleTap: onPhidDoubleTap,
        onPhidLongTap: onPhidLongTap,

        onTileTap: (String path, String phid){blog('ChainSplitter : onTileTap : $path : $phid');},
        onTileDoubleTap: (String path, String phid){blog('ChainSplitter : onTileDoubleTap : $path : $phid');},
        onTileLongTap: (String path, String phid){blog('ChainSplitter : onTileLongTap : $path : $phid');},

        onExportSpecs: onExportSpecs,
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseCityChains: onlyUseCityChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,

        // deactivated: ,
        // expansionColor: ,
        // initialColor: ,
        // inverseAlignment: ,

      );

    }
    // --------------------
    /// DATA CREATOR
    else if (DataCreation.checkIsDataCreator(chainOrChainsOrSonOrSons) == true){

      // final DataCreator _dataCreator = DataCreation.decipherDataCreator(chainOrChainsOrSonOrSons);
      final String _chainID = ChainPathConverter.getLastPathNode(previousPath);
      final PickerModel _picker = PickerModel.getPickerByChainID(
          pickers: ChainsProvider.proGetAllPickers(context: context, listen: false),
          chainID: Phider.removeIndexFromPhid(phid: _chainID),
      );
      final List<SpecModel> _specs = SpecModel.generateSpecsByPhids(
          context: context,
          phids: selectedPhids,
      );

      // blog('previousPath : $previousPath : _chainID : $_chainID : _dataCreator : $_dataCreator');

      return DataCreatorSplitter(
        height: 100,
        width: Bubble.clearWidth(context) - 40,
        picker: _picker,
        appBarType: AppBarType.non,
        searchText: searchText,
        selectedSpecs: _specs,
        onPhidTap: onPhidTap,
        onExportSpecs: onExportSpecs,
        onlyUseCityChains: onlyUseCityChains,
        zone: zone,
        onKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
        isMultipleSelectionMode: isMultipleSelectionMode,
      );
    }
    // --------------------
    /// IF SONS IS List<Chain>
    else if (Chain.checkIsChains(chainOrChainsOrSonOrSons) == true){

      return ChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width,
        level: level,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        secondLinesType: secondLinesType,
        onPhidTap: onPhidTap,
        onPhidDoubleTap: onPhidDoubleTap,
        onPhidLongTap: onPhidLongTap,
        onExportSpecs: onExportSpecs,
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseCityChains: onlyUseCityChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
      );

    }
    /*
    else if (editMode == true && DataCreation.checkIsDataCreator(chainOrChainsOrSonOrSons) == true){

      final DataCreator _phid = chainOrChainsOrSonOrSons;
      final String _path = ChainPathConverter.fixPathFormatting('$previousPath/$_phid/');

      return PhidButton(
        phid: DataCreation.cipherDataCreator(_phid),
        secondLine: createSecondLineVerse(secondLinesType, _phid.toString()),
        width: _width,
        level: level,
        searchText: searchText,
        color: Colorz.green50,
        onPhidDoubleTap: () => onPhidDoubleTap(_path, _phid.toString()),
        // isDisabled: false,
        onPhidTap: (){

          onPhidDoubleTap(_path, _phid.toString());

        }, // good
      );
    }
     */
    // --------------------
    /// OTHERWISE
    else {
      return const NoResultFound(
        color: Colorz.white50,
        verse: Verse(text: '.....', translate: false),
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
