import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:flutter/foundation.dart';

/// THIS METHOD GENERATES ALL PERMUTATIONS OF A STRING
/// input ALI :-
/// AAA , AAL , AAI -- LLL , LLA , LLI -- III , IIL , IIA --- ALI , AIL ALI --- LIA , LAI , ILA , IAL
List<String> generateStringPermutations(String input){

  List<List<int>> _finalList = <List<int>>[];

  if (input != null){

    final int _inputLength = input.length;

    /// A - CREATE BASE LIST [0,0,0 ..., 0]
    List<int> _currentList = [];
    for (int a = 0; a<_inputLength; a++){
      _currentList.add(0);
    }
    /// B - ADD BASE TO FINAL LIST
    _finalList = addIndexesToFinalListIfPossible(_currentList, _finalList);


    for (int loopingDigit = 0; loopingDigit <_inputLength; loopingDigit++){

      /// ASCEND LOOPING DIGIT VALUE
      for (int b = 0; b<_inputLength; b++){
        _currentList[loopingDigit] = b;
        /// then add it to final list
        _finalList = addIndexesToFinalListIfPossible(_currentList, _finalList);

        print('the current list : $_currentList');
      }

    }


    // if (_inputLength > 0){
    //
    //   /// for every character create block
    //   for (int i = 0; i<_inputLength; i++){
    //
    //     List<int> _permutationIndexes = <int>[];
    //
    //     /// for each block create segments
    //     for (int x = 0; x <_inputLength; x++){
    //
    //       /// for each segment create points
    //       _permutationIndexes.add(x);
    //     }
    //
    //     print('_permutationIndexes : $_permutationIndexes');
    //
    //     _finalList.add(_permutationIndexes);
    //   }
    //
    // }

    print('current list : $_currentList');

  }

  final List<String> _result = getStringsFromPermutationIndexesList(
    source: input,
    indexesList: _finalList,
  );


  return _result;
}
// -----------------------------------------------------------------------------
List<List<int>> addIndexesToFinalListIfPossible(List<int> toAdd, List<List<int>> finalList){

  List<List<int>> _result;

  bool _alreadyAdded = finalListContainsIndexes(toAdd, finalList);

  if (_alreadyAdded == true){
    _result = finalList;
  }
  else {
    _result = [...finalList, toAdd];
  }

  return _result;
}
// -----------------------------------------------------------------------------
bool finalListContainsIndexes(List<int> toAdd, List<List<int>> finalList){

  bool _contains = false;

  if (finalList != null && finalList.length != 0){

    for (int i =0; i<finalList.length; i++){

      final List<int> _list = finalList[i];

      final bool _foundMatch = Mapper.listsAreTheSame(list1: _list, list2: toAdd);

      if (_foundMatch == true){
        _contains = true;
        break;
      }


    }

  }

  return _contains;
}
// -----------------------------------------------------------------------------
List<String> getStringsFromPermutationIndexesList({String source, List<List<int>> indexesList}){

  final List<String> _strings = <String>[];

  // example of indexes = [0,1,2,0]
  for (List<int> indexes in indexesList){

    print('indexes : $indexes');

    String _string = '';

    for (int i in indexes){
      _string = _string + '${source[i]}';
    }

    _strings.add(_string);
  }

  return _strings;
}
// -----------------------------------------------------------------------------
List<String> getLetters(String input){
  List<String> _letters = <String>[];

  if (input != null && input != ''){

    for (int i = 0; i < input.length; i++){
      _letters.add(input[i]);
    }

  }

  return _letters;
}


// -----------------------------------------------------------------------------
int getFactorial(int number){
  int _result = 1;

  if (number != null){

    for (int i = 1; i <= number; i++){
      _result = _result * i;
    }

  }

  return _result;
}
// -----------------------------------------------------------------------------
int getNumberOfPermutations({
  @required int number,
  int numberOfSelectedObjects,
}){

  final int _selected = numberOfSelectedObjects ?? number;


  final int _numerator = getFactorial(number);
  final int _denominator = getFactorial((number - _selected));

  final double _numberOfPermutations = _numerator/_denominator;

  return _numberOfPermutations.toInt();
}
// -----------------------------------------------------------------------------
int getNumberOfCombinations({
  @required int number,
  int numberOfSelectedObjects,
}){

  final int _selected = numberOfSelectedObjects ?? number;


  final int _numerator = getFactorial(number);
  final int _denominator = (getFactorial((number - _selected)) * getFactorial(_selected));

  final double _numberOfPermutations = _numerator/_denominator;

  return _numberOfPermutations.toInt();
}
// -----------------------------------------------------------------------------
