// import 'package:flutter/foundation.dart';
//
//
// /// to define special words #VA001 in json to process in runTime
// abstract class JSONWorkAround {
//
//   /// A - need to define the string pattern we are using in the string which I assumed to look like '#VAR00'
//   /// let's call them jsonVariables
//   /// NOTE : if you would like to name them #VAR000 ,, then regExp would be r'#VAR...'
//   static RegExp regExp = RegExp(r'#VAR..');
//
//   /// B - let's make a tracker for any word that matches this regExp in any input string
//   static List<String> _searchJSONVariablesByRegExp({@required String text, @required RegExp regExp}){
//
//     List<String> _strings;
//
//     /// always check if not null before we do stuff to avoid errors and save performance
//     if (text != null){
//       _strings = regExp.allMatches(text).map((m) => m.group(0)).toList();
//
//
//
//     }
//
//     return _strings;
//   }
//
//   /// C - let's make the tracker specifically for those JSONVariables from a string received from the JSON doc "let's call it rawString"
//   static List<String> _searchJSONVariablesFromRawString({@required String rawString}){
//     final List<String> _jsonVariables = _searchJSONVariablesByRegExp(text: rawString, regExp: regExp);
//     return _jsonVariables;
//   }
//
//   /// E - let's see what to do with the search result
//   static List<SpecialWord> _processJSONVariables(List<String> jsonVariables){
//
//     List<SpecialWord> _outputSpecialWords = <SpecialWord>[];
//
//     /// so w notice we will need to process each one alone,, so we loop them out
//     if(jsonVariables != null && jsonVariables.isNotEmpty){
//
//       jsonVariables.forEach((jsonVariable) {
//
//         /// we should receive a substitute string instead of that #VAR00 special string,, so ..
//         /// actually we need to receive a string that is accompanied with its cipher special thing to be able to go back to the sentence and change it,,, like using this special #VAR00 thing as ID
//         /// and I don't like map<String, dynamic> but I would rather create a model class ,, will be written down there at the end of this class
//         final SpecialWord _substitute = _processSingleJSONVariable(jsonVariable: jsonVariable);
//
//         /// then we add them to the output List
//         if (_substitute != null){
//           _outputSpecialWords.add(_substitute);
//         }
//       });
//
//
//     }
//
//     return _outputSpecialWords;
//   }
//
//   /// D - need to receive both the substitute and its (JSONSpecialVariable / ID) to be able to search for it and process it in the original string
//   static SpecialWord _processSingleJSONVariable({@required String jsonVariable}){
//
//     final SpecialWord _substitute = SpecialWord.getSpecialWordFromAllSpecialWordsByID(jsonVariable);
//
//     return _substitute;
//   }
//
//   /// F - finally after receiving the substitutes inside a list<SpecialWord>,, we get get back the original String with the substitutes
//   static String processJSONStringThatContainsThoseSpecialVariables(String rawString){
//
//     /// this has to initialize with the initial raw string value to be processed
//     String _processedString = rawString;
//
//     final List<String> _jsonVariables = _searchJSONVariablesFromRawString(rawString: rawString);
//
//     if (_jsonVariables != null && _jsonVariables.isNotEmpty){
//
//       final List<SpecialWord> _specialWords = _processJSONVariables(_jsonVariables);
//
//       /// then we need to change each jsonVariable with its substitute
//       _specialWords.forEach((specialWord) {
//
//         _processedString = _replaceSubStringWith(
//           subStringToReplace: specialWord.id,
//           replacement: specialWord.substitute,
//           input: _processedString,
//         );
//
//       });
//     }
//
//     return _processedString;
//   }
//
//   /// G - a text replacing method to easily replace a given subString from a string with another value
//   static String _replaceSubStringWith({@required String subStringToReplace, @required String replacement, @required String input}){
//     final String _output = input.replaceAll(subStringToReplace, replacement);
//     return _output;
//   }
//
// }
//
// class SpecialWord{
//   final String id;
//   final String substitute; // you can change this to be more complex to adapt to many languages or other things
//
//   const SpecialWord({
//     @required this.id,
//     @required this.substitute,
//   });
//
//   /// lets create a list of constants that u may change in future and call from db or wherever
//   static const List<SpecialWord> _allSpecialWords = const <SpecialWord>[
//
//     SpecialWord(id: '#VAR01', substitute: 'Baby'),
//     SpecialWord(id: '#VAR02', substitute: 'Cool'),
//     SpecialWord(id: '#VAR03', substitute: 'You got the Idea'),
//
//   ];
//
//   /// I like to pamper myself with super quick methods to be clean and organized
//   static SpecialWord getSpecialWordFromAllSpecialWordsByID(String id){
//     SpecialWord _foundWord;
//
//     if (id != null){
//
//       _foundWord = _allSpecialWords.firstWhere((word) => word.id == id, orElse: () => null);
//
//     }
//
//     return _foundWord;
//   }
//
// }
