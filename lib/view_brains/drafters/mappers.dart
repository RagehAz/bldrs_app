// -----------------------------------------------------------------
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/view_brains/localization/language_class.dart';
/// [
/// {'key' : 'ID'         , 'key' : 'Value'       },
/// {'key' : 'firstValue' , 'key' : 'secondValue' },
/// ]
List<String> geebListOfFirstValuesFromMaps(List<Map<String, Object>> listOfMaps){
  List<String> listOfFirstValues = new List();

  for (int x = 0; x<listOfMaps.length; x++){
  String firstValue = (listOfMaps[x].values.toList())[0];
    listOfFirstValues.add(firstValue);
  }

  return listOfFirstValues;
}
// -----------------------------------------------------------------
/// [
/// {'key' : 'ID'         , 'key' : 'Value'       },
/// {'key' : 'firstValue' , 'key' : 'secondValue' },
/// ]
List<String> geebListOfSecondValuesFromMaps(List<Map<String, Object>> listOfMaps){
  List<String> listOfValues = new List();

  for (int x = 0; x<listOfMaps.length; x++){
    String secondValue = (listOfMaps[x].values.toList())[1];
    listOfValues.add(secondValue);
  }

  return listOfValues;
}
// -----------------------------------------------------------------
List<Map<String,String>> geebMapsOfLanguagesFromLanguageClassList(List<LanguageClass> languages){
  List<Map<String,String>> languagesMaps = new List();
  languages.forEach((lang) {
    languagesMaps.add(
      {'id' : lang.langCode, 'value' : lang.langName},
    );
  });
  return languagesMaps;
}
// -----------------------------------------------------------------
