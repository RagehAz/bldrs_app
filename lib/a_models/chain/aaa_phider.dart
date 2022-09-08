// ignore_for_file: constant_identifier_names
import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:flutter/material.dart';

class Phider {
  // -----------------------------------------------------------------------------

  /// PHID IS : 'phrase ID' : consists of several cuts
  ///
  /// Example :-
  /// String phid         = 'phid_k_am_clubHouse'
  /// List<String> cuts   = ['phid', 'k', 'am', 'clubHouse'];
  ///
  /// INDEXING PHID
  /// String phidWithIndex = '0000_phid_k_am_clubHouse'
  /// notice that index is always within the first 4 digits of the first phid cut
  const Phider();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String phidCut = 'phid';
  static const String phid_kCut = 'phid_k';
  static const String phid_sCut = 'phid_s';
  static const String currencyCut = 'currency';
  // -----------------------------------------------------------------------------

  /// INDEXING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _formatPhidIndex(int index){
    String _output;

    if (index != null){

      /// last allowable index would be 9999
      _output = Numeric.formatIndexDigits(
          index: index,
          listLength: 10000,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String addIndexToPhid({
    @required String phid,
    @required int index,
    bool overrideExisting = true,
  }){
    String _output = phid;

    if (phid != null && index != null && phid is String){

      final bool _hasIndex = checkPhidHasIndex(phid);

      /// PHID HAS NO INDEX => ADD NEW INDEX
      if (_hasIndex == false){

        _output = _mergeIndexWithPhid(index, phid);

      }

      /// PHID ALREADY HAS INDEX
      else {

        /// IF OVERRIDE EXISTING INDEX
        if (overrideExisting == true){

          final String _withoutIndex = removeIndexFromPhid(
              phid: phid,
          );
          _output = _mergeIndexWithPhid(index, _withoutIndex);

        }

        // /// KEEP EXISTING INDEX
        // else {
        //   _output = phid;
        // }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _mergeIndexWithPhid(int index, String phid){
    String _output;

    if (phid != null && phid is String){
      if (index != null){
        _output = '${_formatPhidIndex(index)}_$phid';
      }
      else {
        _output = phid;
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String removeIndexFromPhid({
    @required String phid,
  }){
    String _output;

    if (phid != null && phid is String){

      final bool _hasIndex = checkPhidHasIndex(phid);

      /// IF HAS INDEX => REMOVE IT
      if (_hasIndex == true){
        _output = TextMod.removeTextBeforeFirstSpecialCharacter(phid, '_');
        // blog('removeIndexFromPhid : $_output');
      }

      /// IF HAS NO INDEX => KEEP PHID AS IS
      else {
        _output = phid;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhidHasIndex(String phid){
    bool _hasIndex = false;

    if (phid != null && phid is String){

      final String _firstFourChars = TextMod.removeTextAfterFirstSpecialCharacter(phid, '_');

      final int _int = Numeric.transformStringToInt(_firstFourChars);

      if (_int != null){
        _hasIndex = true;
      }

    }

    return _hasIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getIndexFromPhid(String phid){
    int _index;

    if (phid != null && phid is String){

      if (checkPhidHasIndex(phid) == true){
        final String _indexString = TextMod.removeTextAfterFirstSpecialCharacter(phid, '_');
        _index = Numeric.transformStringToInt(_indexString);
      }

    }

    return _index;
  }
  // -----------------------------------------------------------------------------

  /// INDEX SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain sortChainSonsByIndex(Chain chain){
    Chain _output;

    if (chain != null){

      final bool _isPhids = Chain.checkSonsArePhids(chain.sons);
      final bool _isChains = Chain.checkSonsAreChains(chain.sons);

      if (_isChains == true){

        final List<Chain> sons = sortChainsByIndexes(chain.sons);

        _output = Chain(
          id: chain.id,
          sons: sons,
        );

      }

      else if (_isPhids == true){

        final List<String> sons = sortPhidsByIndexes(chain.sons);

        _output = Chain(
          id: chain.id,
          sons: sons,
        );


      }

      else {
        _output = chain;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> sortChainsByIndexes(List<Chain> input){
    final List<Chain> _output = <Chain>[];

    if (Mapper.checkCanLoopList(input) == true){

      final List<Chain> _sortedChainsIDs = <Chain>[...input];

      /// SORT CHAINS BY IDs
      _sortedChainsIDs.sort((a, b){
        final int _indexA = getIndexFromPhid(a.id) ?? 0;
        final int _indexB = getIndexFromPhid(b.id) ?? 0;
        return _indexA.compareTo(_indexB);
      });

      /// SORT EACH CHAIN SONS
      for (final Chain chain in _sortedChainsIDs){
        final Chain _sortedSon = sortChainSonsByIndex(chain);
        _output.add(_sortedSon);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> sortPhidsByIndexes(List<String> input){
    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(input) == true){

      final List<String> _phids = <String>[...input];

      _phids.sort((a, b){
        final int _indexA = getIndexFromPhid(a) ?? 0;
        final int _indexB = getIndexFromPhid(b) ?? 0;
        return _indexA.compareTo(_indexB);
      });

      _output = <String>[..._phids];

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// INDEX CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain createChainIndexes({
    @required Chain chain,
    @required int chainIndex,
  }){
    Chain _output = chain;

    if (chain != null){

      final bool _isPhids = Chain.checkSonsArePhids(chain.sons);
      final bool _isChains = Chain.checkSonsAreChains(chain.sons);
      final bool _isDataCreator = Chain.checkSonsAreDataCreator(chain.sons);

      final String _chainID = addIndexToPhid(phid: chain.id, index: chainIndex);

      if (_isChains == true){
        _output = Chain(
          id: _chainID,
          sons: createChainsIndexes(chain.sons),
        );
      }

      else if (_isPhids == true){
        _output = Chain(
          id: _chainID,
          sons: createPhidsIndexes(chain.sons),
        );
      }

      else if (_isDataCreator == true){
        _output = Chain(
          id: _chainID,
          sons: chain.sons,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> createChainsIndexes(List<Chain> chains){
    final List<Chain> _output = <Chain>[];

    // Chain.blogChains(chains);

    if (Mapper.checkCanLoopList(chains) == true){

      for (int i = 0; i< chains.length; i++){

        final Chain _original = chains[i];

        final Chain _modified = createChainIndexes(
          chain: _original,
          chainIndex: i,
        );

        _output.add(_modified);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> createPhidsIndexes(List<String> phids){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(phids) == true){

      for (int i = 0; i< phids.length; i++){

        final String _modified = addIndexToPhid(
            phid: phids[i],
            index: i
        );

        _output.add(_modified);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generatePhidPathUniqueKey({
    @required String path,
  }){

    /// NOTE : WORKS ONLY WITH CHAIN S paths
    // map pair looks like this
    /// style_phid_s_arch_style_arabian : chainS/phid_s_style/phid_s_arch_style_arabian/
    // => '{secondNode_xxx} + {yyy}
    // => key = 'xxx_yyy'

    final String _phidWithIndex = ChainPathConverter.getLastPathNode(path);
    final String _phid = Phider.removeIndexFromPhid(phid: _phidWithIndex);
    final List<String> _split = ChainPathConverter.splitPathNodes(path);

    final String _groupLine = _split[_split.length - 2];
    final String group = TextMod.removeTextBeforeLastSpecialCharacter(_groupLine, '_');
    final String _key = '${group}_$_phid';

    return _key;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhid(dynamic object){
    bool _isPhid = false;

    if (object != null){

      if (object is String){

        _isPhid = TextCheck.textStartsExactlyWith(
            text: removeIndexFromPhid(phid: object),
            startsWith: phidCut,
        );

      }

    }

    return _isPhid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsPhid(String text){

    final String _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: text,
      numberOfChars: phidCut.length, // 'phid'
    )?.toLowerCase();

    return _phid == phidCut;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsCurrency(String text){
    bool _isCurrency = false;

    if (text != null){

      final String _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: text,
        numberOfChars: currencyCut.length,
      )?.toLowerCase();

      /*
    /// SOLUTION 2
    /// CURRENCY PHID COME LIKES THIS : 'currency_xxx'
    final String _phid = TextMod.removeTextAfterFirstSpecialCharacter(phid, '_');
     */

      _isCurrency = _phid == currencyCut;
    }

    return _isCurrency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsTemp(String text){
    final String _temp = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: text,
      numberOfChars: 2, //'##'
    );
    return _temp == '##';
  }
  // --------------------
  ///  NEED TEST
  static bool checkIsPhidK(String text){
    bool _isPhidK= false;

    if (text != null){

      _isPhidK = TextCheck.textStartsExactlyWith(
        text: removeIndexFromPhid(phid: text),
        startsWith: phid_kCut,
      );

    }

    return _isPhidK;
  }
  // -----------------------------------------------------------------------------
}
