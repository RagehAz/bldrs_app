import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/chains_editor/z_components/editing_chain_builders/c_editing_chain_builder.dart';
import 'package:bldrs/x_dashboard/chains_editor/z_components/editing_chain_builders/b_editing_chains_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// SPLITS CHAIN OR CHAINS OR SON OR SONS INTO DESIGNATED WIDGET
class EditingChainSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const EditingChainSplitter({
    @required this.chainOrChainsOrSonOrSons,
    @required this.initiallyExpanded,
    @required this.secondLinesType,
    @required this.onPhidDoubleTap,
    @required this.onReorder,
    this.previousPath = '',
    this.level = 0,
    this.width,
    this.onPhidTap,
    this.selectedPhids,
    this.searchText,
    this.onAddToPath,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic chainOrChainsOrSonOrSons;
  final int level;
  final String previousPath;
  final double width;
  final Function(String path, String phid) onPhidTap;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<dynamic> searchText;
  final Function(String path) onAddToPath;
  final ChainSecondLinesType secondLinesType;
  final ValueChanged<String> onPhidDoubleTap;
  final Function({int oldIndex, int newIndex, List<dynamic> sons, String previousPath, int level}) onReorder;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Verse createSecondVerse(ChainSecondLinesType type, String phid, {int index}){
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

    return Verse.plain(_output);
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
        secondLine: createSecondVerse(secondLinesType, _phid),
        width: _width,
        level: level,
        searchText: searchText,
        color: _color,
        onPhidDoubleTap: () => onPhidDoubleTap(_cleanedPath),
        onPhidTap: () => onPhidTap(_cleanedPath, _phid), // good

        // inverseAlignment: ,
        // margins: ,
        // isDisabled: ,
        // xIsOn: ,

      );

    }
    // --------------------
    /// IF SONS IS List<String>
    else if (chainOrChainsOrSonOrSons is List<String>){

      return EditingChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width,
        level: level,
        onPhidTap: onPhidTap,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onAddToPath: onAddToPath,
        secondLinesType: secondLinesType,
        onDoubleTap: onPhidDoubleTap,
        onReorder: onReorder,
      );

    }
    // --------------------
    /// IF SON IS CHAIN
    else if (chainOrChainsOrSonOrSons is Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      final Chain _chain = chainOrChainsOrSonOrSons;

      return EditingChainBuilder(
        key: PageStorageKey<String>(_chain.id),
        previousPath: previousPath, //_chain.id, //'$previousPath/${}',
        chain: _chain,
        boxWidth: _width,
        icon: _chainsProvider.getPhidIcon(son: chainOrChainsOrSonOrSons, context: context),
        firstHeadlineVerse: Verse.trans(Phider.removeIndexFromPhid(phid: _chain.id)),
        secondHeadlineVerse: createSecondVerse(secondLinesType, _chain.id),
        initiallyExpanded: initiallyExpanded,
        onPhidTap: onPhidTap,
        onDoubleTap: onPhidDoubleTap,
        level: level,
        selectedPhids: selectedPhids,
        searchText: searchText,
        onAddToPath: onAddToPath,
        secondLinesType: secondLinesType,
        onReorder: onReorder,

        // deactivated: ,
        // expansionColor: ,
        // initialColor: ,
        // inverseAlignment: ,

      );

    }
    // --------------------
    /// IF SONS IS List<Chain>
    else if (Chain.checkIsChains(chainOrChainsOrSonOrSons) == true){

      return EditingChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width,
        level: level,
        onPhidTap: onPhidTap,
        selectedPhids: selectedPhids,
        initiallyExpanded: initiallyExpanded,
        searchText: searchText,
        onAddToPath: onAddToPath,
        secondLinesType: secondLinesType,
        onDoubleTap: onPhidDoubleTap,
        onReorder: onReorder,
      );

    }
    // --------------------
    /// EDIT MODE AND DATA CREATOR
    else if (DataCreation.checkIsDataCreator(chainOrChainsOrSonOrSons) == true){

      final DataCreator _phid = chainOrChainsOrSonOrSons;
      final String _path = '$previousPath/$_phid/';
      final String _cleanedPath = ChainPathConverter.fixPathFormatting(_path);

      return PhidButton(
        phid: DataCreation.cipherDataCreator(_phid),
        secondLine: createSecondVerse(secondLinesType, _phid.toString()),
        width: _width,
        level: level,
        searchText: searchText,
        color: Colorz.green50,
        onPhidDoubleTap: () => onPhidDoubleTap(_cleanedPath),
        // isDisabled: false,
        onPhidTap: (){

          onPhidTap(_cleanedPath, _phid.toString());

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
