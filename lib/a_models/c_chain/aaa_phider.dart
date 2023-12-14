// ignore_for_file: constant_identifier_names
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/strings/pathing.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';

/// => TAMAM
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
  static const String headlineCut = 'headline';
  // -----------------------------------------------------------------------------

  /// INDEXING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _formatPhidIndex(int? index){
    String? _output;

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
  static String? addIndexToPhid({
    required String? phid,
    required int? index,
    bool overrideExisting = true,
  }){
    String? _output = phid;

    if (phid != null && index != null){

      final bool _hasIndex = checkPhidHasIndex(phid);

      /// PHID HAS NO INDEX => ADD NEW INDEX
      if (_hasIndex == false){

        _output = _mergeIndexWithPhid(index, phid);

      }

      /// PHID ALREADY HAS INDEX
      else {

        /// IF OVERRIDE EXISTING INDEX
        if (overrideExisting == true){

          final String? _withoutIndex = removeIndexFromPhid(
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
  static String? _mergeIndexWithPhid(int? index, String? phid){
    String? _output;

    if (phid != null){
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
  static String? removeIndexFromPhid({
    required String? phid,
  }){
    String? _output;

    if (phid != null){

      final bool _hasIndex = checkPhidHasIndex(phid);

      /// IF HAS INDEX => REMOVE IT
      if (_hasIndex == true){
        _output = TextMod.removeTextBeforeFirstSpecialCharacter(
            text: phid,
            specialCharacter: '_',
        );
        // blog('removeIndexFromPhid : $_output');
      }

      /// IF HAS NO INDEX => KEEP PHID AS IS
      ///
      else {
        _output = phid;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> removePhidsIndexes(List<String>? phids){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(phids) == true){
      for (final String phid in phids!){
        final String? _list = removeIndexFromPhid(phid: phid);
        if (_list != null){
          _output.add(_list);
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? removePathIndexes(String? path){
    String? _output;
    if (TextCheck.isEmpty(path) == false){

      final List<String> _nodes = Pathing.splitPathNodes(path);

      final List<String> _nodesWithoutIndexes = <String>[];
      for (final String node in _nodes){
        final String? _nodeWithoutIndex = removeIndexFromPhid(phid: node);
        if (_nodeWithoutIndex != null){
          _nodesWithoutIndexes.add(_nodeWithoutIndex);
        }
      }

      _output = Pathing.combinePathNodes(_nodesWithoutIndexes);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> removePathsIndexes(List<String> paths){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(paths) == true){

      for (final String path in paths){

        final String? _pathWithoutIndex = removePathIndexes(path);
        if (_pathWithoutIndex != null){
          _output.add(_pathWithoutIndex);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPhidHasIndex(String? phid){
    bool _hasIndex = false;

    if (phid != null){

      final String? _firstFourChars = TextMod.removeTextAfterFirstSpecialCharacter(
          text: phid,
          specialCharacter: '_',
      );

      final int? _int = Numeric.transformStringToInt(_firstFourChars);

      if (_int != null){
        _hasIndex = true;
      }

    }

    return _hasIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? getIndexFromPhid(String? phid){
    int? _index;

    if (phid != null){

      if (checkPhidHasIndex(phid) == true){
        final String? _indexString = TextMod.removeTextAfterFirstSpecialCharacter(
            text: phid,
            specialCharacter: '_',
        );
        _index = Numeric.transformStringToInt(_indexString);
      }

    }

    return _index;
  }
  // -----------------------------------------------------------------------------

  /// INDEX SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? sortChainSonsByIndex(Chain? chain){
    Chain? _output;

    if (chain != null){

      final bool _isPhids = Phider.checkIsPhids(chain.sons);
      final bool _isChains = Chain.checkIsChains(chain.sons);

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
  static List<Chain> sortChainsByIndexes(List<Chain>? input){
    final List<Chain> _output = <Chain>[];

    if (Mapper.checkCanLoopList(input) == true){

      final List<Chain> _sortedChainsIDs = <Chain>[...input!];

      /// SORT CHAINS BY IDs
      _sortedChainsIDs.sort((a, b){
        final int _indexA = getIndexFromPhid(a.id) ?? 0;
        final int _indexB = getIndexFromPhid(b.id) ?? 0;
        return _indexA.compareTo(_indexB);
      });

      /// SORT EACH CHAIN SONS
      for (final Chain chain in _sortedChainsIDs){
        final Chain? _sortedSon = sortChainSonsByIndex(chain);
        if (_sortedSon != null){
          _output.add(_sortedSon);
        }
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
  static Chain? createChainIndexes({
    required Chain? chain,
    required int chainIndex,
  }){
    Chain? _output = chain;

    if (chain != null){

      final bool _isPhids = Phider.checkIsPhids(chain.sons);
      final bool _isChains = Chain.checkIsChains(chain.sons);
      final bool _isDataCreator = DataCreation.checkIsDataCreator(chain.sons);

      final String? _chainID = addIndexToPhid(
        phid: chain.id,
        index: chainIndex,
        // overrideExisting: true,
      );

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
  static List<Chain> createChainsIndexes(List<Chain>? chains){
    final List<Chain> _output = <Chain>[];

    // Chain.blogChains(chains);

    if (Mapper.checkCanLoopList(chains) == true){

      for (int i = 0; i< chains!.length; i++){

        final Chain _original = chains[i];

        final Chain? _modified = createChainIndexes(
          chain: _original,
          chainIndex: i,
        );

        if (_modified != null){
          _output.add(_modified);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> createPhidsIndexes(List<String> phids){
    final List<String> _output = <String>[];

    /// NOTE : OVERRIDES EXISTING INDEX

    if (Mapper.checkCanLoopList(phids) == true){

      for (int i = 0; i< phids.length; i++){

        final String? _modified = addIndexToPhid(
            phid: removeIndexFromPhid(phid: phids[i]),
            index: i
        );

        if (_modified != null){
          _output.add(_modified);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String generatePhidPathUniqueKey({
    required String path,
  }){

    /// NOTE : WORKS ONLY WITH CHAIN S paths
    // map pair looks like this
    /// style_phid_s_arch_style_arabian : chainS/phid_s_style/phid_s_arch_style_arabian/
    // => '{secondNode_xxx} + {yyy}
    // => key = 'xxx_yyy'

    final String? _phidWithIndex = Pathing.getLastPathNode(path);
    final String? _phid = Phider.removeIndexFromPhid(phid: _phidWithIndex);
    final List<String> _split = Pathing.splitPathNodes(path);

    final String _groupLine = _split[_split.length - 2];
    final String? group = TextMod.removeTextBeforeLastSpecialCharacter(
        text: _groupLine,
        specialCharacter: '_',
    );
    final String _key = '${group}_$_phid';

    return _key;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhids(dynamic sons){

    bool _arePhids = false;

    if (sons != null){

      if (sons is List<String>){

        final List<String> _sons = sons;

        if (Mapper.checkCanLoopList(_sons) == true){
          _arePhids = Phider.checkIsPhid(_sons.first);
        }

      }

      else if (ObjectCheck.objectIsMinified(sons) == true){
        if (sons is List && sons.isNotEmpty == true){
          final List<dynamic> dynamics = sons;
          final List<String> _strings = Stringer.getStringsFromDynamics(dynamics);
          if (Mapper.checkCanLoopList(_strings) == true){
            _arePhids = Phider.checkIsPhid(_strings.first);
          }
        }
      }

    }

    return _arePhids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhid(dynamic object){
    bool _isPhid = false;

    if (object != null){

      if (object is String){

        _isPhid = TextCheck.stringStartsExactlyWith(
            text: removeIndexFromPhid(phid: object),
            startsWith: phidCut,
        );

      }

    }

    return _isPhid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsPhid(String? text){

    final String? _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
      text: removeIndexFromPhid(phid: text),
      numberOfChars: phidCut.length, // 'phid'
    )?.toLowerCase();

    return _phid == phidCut;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsCurrency(dynamic text){
    bool _isCurrency = false;

    if (text != null && text is String){

      final String? _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: removeIndexFromPhid(phid: text),
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
  static bool checkVerseIsHeadline(String? text){
    bool _isHeadline = false;

    if (text != null){

      final String? _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
        text: removeIndexFromPhid(phid: text),
        numberOfChars: headlineCut.length,
      )?.toLowerCase();


      _isHeadline = _phid == headlineCut;
    }

    return _isHeadline;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsTemp(String? text){
    final String? _temp = TextMod.removeAllCharactersAfterNumberOfCharacters(
      text: text,
      numberOfChars: 2, //'( # # )'
    );
    return _temp == '##';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhidK(String? text){
    bool _isPhidK= false;

    if (text != null){

      _isPhidK = TextCheck.stringStartsExactlyWith(
        text: removeIndexFromPhid(phid: text),
        startsWith: phid_kCut,
      );

      /// SOLUTION 2 : TESTED : WORKS PERFECT
      // final String _phidK = TextMod.removeAllCharactersAfterNumberOfCharacters(
      //   input: Phider.removeIndexFromPhid(phid: text),
      //   numberOfChars: 7, //'ph id _k_'
      // );
      // return _phidK == 'phid_k_';


    }

    return _isPhidK;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhidS(String? text){
    bool _isPhidK= false;

    if (text != null){

      _isPhidK = TextCheck.stringStartsExactlyWith(
        text: removeIndexFromPhid(phid: text),
        startsWith: phid_sCut,
      );

      /// SOLUTION 2 : TESTED : WORKS PERFECT
      // final String _phids = TextMod.removeAllCharactersAfterNumberOfCharacters(
      //   input: Phider.removeIndexFromPhid(phid: text),
      //   numberOfChars: 7, //'phid_s_'
      // );
      // return _phids == 'phid_s_';


    }

    return _isPhidK;
  }
  // -----------------------------------------------------------------------------

  /// SORTING ALPHABETICALLY

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> sortPhidsAlphabetically({
    required List<String> phids,
  }){
    List<String> _output = [];

    if (Mapper.checkCanLoopList(phids) == true){

      List<Phrase> _phrases = [];
      for (final String phid in phids){
        final String? _translation = Localizer.translate(phid);
        final Phrase _phrase = Phrase(id: phid, value: _translation);
        _phrases.add(_phrase);
      }

      _phrases = Phrase.sortNamesAlphabetically(_phrases);

      _output = Phrase.getPhrasesIDs(_phrases);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTER

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPossibleID(dynamic son){

    String? _id;

    if (son != null){

      final bool _isChain = son is Chain;
      final bool _isChains = Chain.checkIsChains(son);
      final bool _isPhid = Phider.checkIsPhid(son);
      final bool _isPhids = Phider.checkIsPhids(son);
      final bool _isDataCreator = DataCreation.checkIsDataCreator(son);

      /// BLOGGING
      if (_isChains){

      }
      else if (_isChain){
        final Chain chain = son;
        _id = removeIndexFromPhid(phid: chain.id);
      }
      else if (_isPhids){

      }
      else if (_isPhid){
        _id = removeIndexFromPhid(phid: son);
      }
      else if (_isDataCreator){
        _id = DataCreation.cipherDataCreator(son);
      }

    }

    return _id;
  }
  // --------------------
    // -----------------------------------------------------------------------------

  /// KEYWORDS AND SPECS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getKeywordsIDsFromPhrases({
    required List<Phrase> allPhrases,
    bool includeChainsIDs = true,
  }){

    final List<Phrase> _keywordsPhrases = <Phrase>[];

    for (final Phrase phrase in allPhrases){

      final bool _isKeyword = Phider.checkIsPhidK(phrase.id);

      if (_isKeyword == true){
        _keywordsPhrases.add(phrase);
      }

    }

    final List<String> _keywordsPhrasesIDs = Phrase.getPhrasesIDs(_keywordsPhrases);

    return _keywordsPhrasesIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getSpecsIDsFromPhrases({
    required List<Phrase> allPhrases,
  }){

    final List<Phrase> _specsIDs = <Phrase>[];

    for (final Phrase phrase in allPhrases){

      final bool _isSpec = Phider.checkIsPhidS(phrase.id);

      if (_isSpec == true){
        _specsIDs.add(phrase);
      }

    }

    final List<String> _specsPhraseIDs = Phrase.getPhrasesIDs(_specsIDs);

    return _specsPhraseIDs;
  }
  // -----------------------------------------------------------------------------
}
