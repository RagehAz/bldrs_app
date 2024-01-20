part of chains;

enum ChainSecondLinesType {
  non,
  id,
  indexAndID,
}

/// SPLITS CHAIN OR CHAINS OR SON OR SONS INTO DESIGNATED WIDGET
class ChainSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainSplitter({
    required this.chainOrChainsOrSonOrSons,
    required this.initiallyExpanded,
    required this.secondLinesType,
    required this.onPhidTap,
    required this.onPhidLongTap,
    required this.onPhidDoubleTap,
    required this.selectedPhids,
    required this.searchText,
    required this.onExportSpecs,
    required this.zone,
    required this.onlyUseZoneChains,
    required this.isMultipleSelectionMode,
    required this.isCollapsable,
    this.onDataCreatorKeyboardSubmitted,
    this.previousPath = '',
    this.level = 0,
    this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic chainOrChainsOrSonOrSons;
  final int? level;
  final String? previousPath;
  final double? width;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<dynamic> searchText;
  final ChainSecondLinesType secondLinesType;
  final Function(String? path, String? phid)? onPhidTap;
  final Function(String? path, String? phid)? onPhidDoubleTap;
  final Function(String? path, String? phid)? onPhidLongTap;
  final ValueChanged<List<SpecModel>>? onExportSpecs;
  final ZoneModel? zone;
  final ValueChanged<String?>? onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final bool isCollapsable;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Verse? createSecondLineVerse(ChainSecondLinesType type, String? phid, {int? index}){
    String? _output;

    if (type == ChainSecondLinesType.id){
      _output = phid;
    }
    else if (type == ChainSecondLinesType.indexAndID){
      final int? _index = Phider.getIndexFromPhid(phid);
      final String? _phid = Phider.removeIndexFromPhid(phid: phid);

      final String? _outsideIndex = Numeric.formatIntWithinDigits(num: index, digits: 4);
      final String? _indexFromPhid = Numeric.formatIntWithinDigits(num: _index, digits: 4);
      _output = index == null ? '$_indexFromPhid : $_phid' : '$_outsideIndex : $_indexFromPhid : $_phid';
    }

    if (_output == null){
      return null;
    }
    else {
      return Verse(id: _output, translate: false);
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = width ?? BldrsAppBar.width();
    // --------------------
    /// IF SON IS A PHID
    if (Keyworder.checkIsPhid(chainOrChainsOrSonOrSons) == true) {

      final String _phid = chainOrChainsOrSonOrSons;
      final String? _path = Pathing.fixPathFormatting('$previousPath/$_phid/');

      final bool _isSelected = Stringer.checkStringsContainString(
        strings: Phider.removePhidsIndexes(selectedPhids),
        string: Phider.removeIndexFromPhid(phid: _phid),
      );

      return PhidButton(
        phid: _phid,
        secondLine: createSecondLineVerse(secondLinesType, _phid),
        width: _width - 10,
        level: level,
        searchText: searchText,
        color: _isSelected == true ? Colorz.blue125 : Colorz.white20,
        onPhidTap: () => onPhidTap?.call(_path, _phid),
        onPhidDoubleTap: () => onPhidDoubleTap?.call(_path, _phid),
        onPhidLongTap: () => onPhidLongTap?.call(_path, _phid),
        // inverseAlignment: ,
        margins: const EdgeInsets.only(bottom: 5),
        // isDisabled: ,
        // xIsOn: ,
      );

    }
    // --------------------
    /// IF SONS IS PHIDS
    else if (Keyworder.checkIsPhids(chainOrChainsOrSonOrSons) == true){

      return ChainsBuilder(
        width: _width - 10,
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
        onlyUseZoneChains: onlyUseZoneChains,
        isMultipleSelectionMode: isMultipleSelectionMode,
        isCollapsable: isCollapsable,
      );
    }
    // --------------------
    /// IF SON IS CHAIN
    else if (chainOrChainsOrSonOrSons is Chain) {

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
      final Chain _chain = chainOrChainsOrSonOrSons;

      return ChainBuilder(
        key: PageStorageKey<String>('${_chain.id}'),
        previousPath: previousPath,
        chain: _chain,
        boxWidth: _width - 10,
        icon: _chainsProvider.getPhidIcon(son: chainOrChainsOrSonOrSons),
        firstHeadline: Verse(
          id: Phider.removeIndexFromPhid(phid: _chain.id),
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

        onTileTap: null, //(String path, String phid){blog('ChainSplitter : onTileTap : $path : $phid');},
        onTileDoubleTap: null, //(String path, String phid){blog('ChainSplitter : onTileDoubleTap : $path : $phid');},
        onTileLongTap: null, //(String path, String phid){blog('ChainSplitter : onTileLongTap : $path : $phid');},

        onExportSpecs: onExportSpecs,
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseZoneChains: onlyUseZoneChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,

        isCollapsable: isCollapsable,
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
      final String? _chainID = Pathing.getLastPathNode(previousPath);
      final PickerModel? _picker = PickerModel.getPickerByChainID(
          pickers: ChainsProvider.proGetAllPickers(
            context: context,
            listen: false,
          ),
          chainID: Phider.removeIndexFromPhid(phid: _chainID),
      );
      final List<SpecModel> _specs = SpecModel.generateSpecsByPhids(
          phids: selectedPhids,
      );

      // blog('previousPath : $previousPath : _chainID : $_chainID : _dataCreator : $_dataCreator');

      return DataCreatorSplitter(
        height: 100,
        width: _width - 40,
        picker: _picker,
        appBarType: AppBarType.non,
        searchText: searchText,
        selectedSpecs: _specs,
        onPhidTap: onPhidTap,
        onExportSpecs: onExportSpecs,
        onlyUseZoneChains: onlyUseZoneChains,
        zone: zone,
        onKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
        isMultipleSelectionMode: isMultipleSelectionMode,
        isCollapsable: isCollapsable,
      );
    }
    // --------------------
    /// IF SONS IS List<Chain>
    else if (Chain.checkIsChains(chainOrChainsOrSonOrSons) == true){

      return ChainsBuilder(
        sons: chainOrChainsOrSonOrSons,
        previousPath: previousPath, // good
        width: _width - 10,
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
        onlyUseZoneChains: onlyUseZoneChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,
        isCollapsable: isCollapsable,
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
        verse: Verse(id: '.....', translate: false),
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
