import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_mod.dart';

enum DataCreator{

  doubleKeyboard,
  doubleSlider,
  doubleRangeSlider,

  integerKeyboard,
  integerSlider,
  integerRangeSlider,

  boolSwitch,
  country,

}

class DataCreation {
  // -----------------------------------------------------------------------------

  const DataCreation();

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherDataCreator(dynamic sons){
    switch (sons){

      case DataCreator.doubleKeyboard:      return 'DataCreator_doubleKeyboard';
      case DataCreator.doubleSlider:        return 'DataCreator_doubleSlider';
      case DataCreator.doubleRangeSlider:   return 'DataCreator_doubleRangeSlider';

      case DataCreator.integerKeyboard:     return 'DataCreator_integerKeyboard';
      case DataCreator.integerSlider:       return 'DataCreator_integerSlider';
      case DataCreator.integerRangeSlider:  return 'DataCreator_integerRangeSlider';

      case DataCreator.boolSwitch:          return 'DataCreator_boolSwitch';
      case DataCreator.country:             return 'DataCreator_country';
      default: return null;

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DataCreator? decipherDataCreator(dynamic sons){

    /// IS DATA CREATOR
    if (sons is DataCreator){
      return sons;
    }
    else {

      /// IS String
      if (sons is String){

        /// DataCreator_doubleKeyboard
        if (sons == 'DataCreator_doubleKeyboard'){
          return DataCreator.doubleKeyboard;
        }

        /// DataCreator_doubleSlider
        else if (sons == 'DataCreator_doubleSlider'){
          return DataCreator.doubleSlider;
        }

        /// DataCreator_doubleSlider
        else if (sons == 'DataCreator_doubleRangeSlider'){
          return DataCreator.doubleRangeSlider;
        }

        /// DataCreator_integerKeyboard
        else if (sons == 'DataCreator_integerKeyboard'){
          return DataCreator.integerKeyboard;
        }

        /// DataCreator_integerSlider
        else if (sons == 'DataCreator_integerSlider'){
          return DataCreator.integerSlider;
        }

        /// DataCreator_integerRangeSlider
        else if (sons == 'DataCreator_integerRangeSlider'){
          return DataCreator.integerRangeSlider;
        }

        /// DataCreator_boolSwitch
        else if (sons == 'DataCreator_boolSwitch'){
          return DataCreator.boolSwitch;
        }

        /// DataCreator_country
        else if (sons == 'DataCreator_country'){
          return DataCreator.country;
        }

        /// NOTHING => is String but not DataCreator
        else {
          return null;
        }

      }

      /// IS List<String>
      else if (sons is List<String>){

        final String _sonsAsString = sons.toString();

        /// DataCreator_doubleKeyboard
        if (_sonsAsString == '[DataCreator_doubleKeyboard]'){
          return DataCreator.doubleKeyboard;
        }

        /// DataCreator_doubleSlider
        if (_sonsAsString == '[DataCreator_doubleSlider]'){
          return DataCreator.doubleSlider;
        }

        /// DataCreator_doubleSlider
        if (_sonsAsString == '[DataCreator_doubleRangeSlider]'){
          return DataCreator.doubleRangeSlider;
        }

        /// DataCreator_integerKeyboard
        if (_sonsAsString == '[DataCreator_integerKeyboard]'){
          return DataCreator.integerKeyboard;
        }

        /// DataCreator_integerSlider
        if (_sonsAsString == '[DataCreator_integerSlider]'){
          return DataCreator.integerSlider;
        }

        /// DataCreator_integerRangeSlider
        if (_sonsAsString == '[DataCreator_integerRangeSlider]'){
          return DataCreator.integerRangeSlider;
        }

        /// DataCreator_boolSwitch
        if (_sonsAsString == '[DataCreator_boolSwitch]'){
          return DataCreator.boolSwitch;
        }

        /// DataCreator_country
        if (_sonsAsString == '[DataCreator_country]'){
          return DataCreator.country;
        }

        /// NOTHING => is List<String> but not DataCreator
        else {
          return null;
        }

      }

      /// NOTHING
      else {
        return null;
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  static const List<DataCreator> dataCreatorsList = <DataCreator>[
    DataCreator.doubleKeyboard,
    DataCreator.doubleSlider,
    DataCreator.doubleRangeSlider,
    DataCreator.integerKeyboard,
    DataCreator.integerSlider,
    DataCreator.integerRangeSlider,
    DataCreator.boolSwitch,
    DataCreator.country,
  ];
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsDataCreator(dynamic sons){

    bool _isDataCreator = false;

    // blog('checkSonsAreDataCreator : ${sons.runtimeType} : $sons');

    if (sons != null){

      if (
          sons is DataCreator
          ||
          sons is DataCreator?
      ){
        _isDataCreator = true;
      }
      else if (
          sons is List<DataCreator>
          ||
          sons is List<DataCreator?>
          ||
          sons is List<DataCreator>?
          ||
          sons is List<DataCreator?>?
      ){
        _isDataCreator = true;
      }

      else if (sons.runtimeType.toString() == 'DataCreator'){
        _isDataCreator = true;
      }

      else if (
          sons is List<String>
          ||
          sons is List<String?>
          ||
          sons is List<String>?
          ||
          sons is List<String?>?
      ){

        final List<String> _sons = sons;

        if (Lister.checkCanLoop(_sons) == true){

          final String _first = _sons.first;

          final String? _dataCreator = TextMod.removeTextAfterFirstSpecialCharacter(
            text: _first,
            specialCharacter: '_',
          );

          if (_dataCreator == 'DataCreator'){
            _isDataCreator = true;
          }

        }
      }

    }

    return _isDataCreator;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsDataCreatorOfType({
    required dynamic sons,
    required DataCreator dataCreator,
  }){

    bool _indeed = false;

    if (sons == dataCreator){
      _indeed = true;
    }
    else {

      final bool _isDataCreator = checkIsDataCreator(sons);

      if (_isDataCreator == true){

        if (sons is List<String>){

          final List<String> _sons = sons;

          if (Lister.checkCanLoop(_sons) == true){

            final String _first = _sons.first;
            final String? _cipheredType = DataCreation.cipherDataCreator(dataCreator);

            // blog('_first : $_first');
            // blog('dataCreator : $dataCreator');
            // blog('dataCreator.toString() : ${dataCreator.toString()} || ${dataCreator.toString() == _first}');
            // blog('_cipheredType : $_cipheredType || ${_cipheredType == _first}');

            if (_cipheredType == _first){
              _indeed = true;
            }

          }

        }

      }

    }



    return _indeed;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsDoubleDataCreator(DataCreator? creator){

    switch (creator){
      case DataCreator.doubleKeyboard : return true;
      case DataCreator.doubleRangeSlider : return true;
      case DataCreator.doubleSlider : return true;

      default : return false;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsIntDataCreator(DataCreator? creator){

    switch (creator){
      case DataCreator.integerKeyboard : return true;
      case DataCreator.integerSlider : return true;
      case DataCreator.integerRangeSlider : return true;

      default : return false;
    }
  }
  // -----------------------------------------------------------------------------
  }
  // -----------------------------------------------------------------------------
  /// NOT USED
  /*
  bool isBoolDataCreator(DataCreator creator){

    switch (creator){
      case DataCreator.boolSwitch : return true; break;
      default : return false;
    }

  }

   */
  // --------------------
  /// NOT USED
  /*
  bool isCountryDataCreator(DataCreator creator){
    switch (creator){
      case DataCreator.country : return true; break;
      default : return false;
    }
  }
  */
  // -----------------------------------------------------------------------------
