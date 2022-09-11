import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/c_chain_builder.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/b_chains_builder.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
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
    @required this.editMode,
    @required this.secondLinesType,
    @required this.onLongPress,
    this.previousPath = '',
    this.parentLevel = 0,
    this.width,
    this.onSelectPhid,
    this.selectedPhids,
    this.searchText,
    this.onAddToPath,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic chainOrChainsOrSonOrSons;
  final int parentLevel;
  final String previousPath;
  final double width;
  final Function(String path, String phid) onSelectPhid;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<String> searchText;
  final Function(String path) onAddToPath;
  final ChainSecondLinesType secondLinesType;
  final bool editMode;
  final ValueChanged<String> onLongPress;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  String createSecondLine(ChainSecondLinesType type, String phid, {int index}){
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

    return _output;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = width ?? BldrsAppBar.width(context);
    // --------------------
    /// IF SON IS A PHID
    if (chainOrChainsOrSonOrSons is String) {

      final String _phid = chainOrChainsOrSonOrSons;

      final bool _isSelected = Stringer.checkStringsContainString(
        strings: selectedPhids,
        string: _phid,
      );

      final Color _color = _isSelected == true ? Colorz.blue125 : Colorz.white20;
      final String _path = '$previousPath/$_phid/';
      final String _cleanedPath = ChainPathConverter.fixPathFormatting(_path);

      return PhidButton(
        phid: _phid,
        secondLine: createSecondLine(secondLinesType, _phid),
        width: _width,
        parentLevel: parentLevel,
        searchText: searchText,
        color: _color,
        onLongTap: () => onLongPress(_cleanedPath),
        onTap: () => onSelectPhid(_cleanedPath, _phid), // good

        // inverseAlignment: ,
        // margins: ,
        // isDisabled: ,
        // xIsOn: ,

      );

    }
    // --------------------
    /// IF SONS IS List<String>
    else if (chainOrChainsOrSonOrSons is List<String>){
      return ChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width,
        parentLevel: parentLevel,
        onPhidTap: onSelectPhid,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onAddToPath: onAddToPath,
        secondLinesType: secondLinesType,
        onLongPress: onLongPress,
      );
    }
    // --------------------
    /// IF SON IS CHAIN
    else if (chainOrChainsOrSonOrSons is Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      final Chain _chain = chainOrChainsOrSonOrSons;
      // blog('$parentLevel : $previousPath/${_chain.id}');

      return ChainBuilder(
        key: PageStorageKey<String>(_chain.id),
        previousPath: previousPath, //_chain.id, //'$previousPath/${}',
        chain: _chain,
        boxWidth: _width,
        icon: _chainsProvider.getPhidIcon(son: chainOrChainsOrSonOrSons, context: context),
        firstHeadline: Phider.removeIndexFromPhid(phid: _chain.id),
        secondHeadline: createSecondLine(secondLinesType, _chain.id),
        initiallyExpanded: initiallyExpanded,
        onPhidTap: onSelectPhid,
        onLongPress: onLongPress,
        parentLevel: parentLevel,
        selectedPhids: selectedPhids,
        searchText: searchText,
        onAddToPath: onAddToPath,
        editMode: editMode,
        secondLinesType: secondLinesType,

        // deactivated: ,
        // expansionColor: ,
        // initialColor: ,
        // inverseAlignment: ,

      );

    }
    // --------------------
    /// IF SONS IS List<Chain>
    else if (Chain.checkIsChains(chainOrChainsOrSonOrSons) == true){

      return ChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width,
        parentLevel: parentLevel,
        onPhidTap: onSelectPhid,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onAddToPath: onAddToPath,
        secondLinesType: secondLinesType,
        onLongPress: onLongPress,
      );

    }
    // --------------------
    /// EDIT MODE AND DATA CREATOR
    else if (editMode == true && DataCreation.checkIsDataCreator(chainOrChainsOrSonOrSons) == true){

      final DataCreator _phid = chainOrChainsOrSonOrSons;
      final String _path = '$previousPath/$_phid/';
      final String _cleanedPath = ChainPathConverter.fixPathFormatting(_path);

      return PhidButton(
        phid: DataCreation.cipherDataCreator(_phid),
        secondLine: createSecondLine(secondLinesType, _phid.toString()),
        width: _width,
        parentLevel: parentLevel,
        searchText: searchText,
        color: Colorz.green50,
        onLongTap: () => onLongPress(_cleanedPath),
        // isDisabled: false,
        onTap: (){

          onSelectPhid(_cleanedPath, _phid.toString());

        }, // good
      );
    }
    // --------------------
    /// OTHERWISE
    else {
      return const BldrsName(size: 40);
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
