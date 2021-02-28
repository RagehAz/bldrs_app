// TextDirection superTextDirectionSwitcher(TextEditingController controller){
//   TextDirection _textDirection;
//
//   bool controllerIsEmpty = textControllerHasNoValue(controller);
//
//   if (!controllerIsEmpty){
//
//     String _string = controller.text;
//     String _firstCharacter = firstCharacterAfterRemovingSpacesFromAString(_string);
//
//     if(textStartsInEnglish(_firstCharacter)){
//       _textDirection = TextDirection.ltr;
//     } else if (textStartsInArabic(_firstCharacter)){
//       _textDirection = TextDirection.rtl;
//     } else {
//       _textDirection = null;
//     }
//
//   } else {_textDirection = null;}
//
//   return _textDirection;
// }
// // === === === === === === === === === === === === === === === === === === ===
// String firstCharacterAfterRemovingSpacesFromAString(String string){
//   String _output;
//
//   String _stringTrimmed = string.trim();
//
//   String _stringWithoutSpaces = removeSpacesFromAString(_stringTrimmed);
//
//   String _firstCharacter = firstCharacterOfAString(_stringWithoutSpaces);
//
//   _output =
//   _stringTrimmed == null || _stringTrimmed == '' ? null :
//   _firstCharacter;
//   return
//     _output;
// }
// // === === === === === === === === === === === === === === === === === === ===
