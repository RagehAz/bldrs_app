import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/timerz.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// === === === === === === === === === === === === === === === === === === ===
double verseLabelHeight (int verseSize, double screenHeight){
      return
    (verseSize == 0) ? screenHeight * Ratioz.fontSize0 * 1.42 // -- 8 -- A77A
        :
    (verseSize == 1) ? screenHeight * Ratioz.fontSize1 * 1.42 // -- 10 -- Nano
        :
    (verseSize == 2) ? screenHeight * Ratioz.fontSize2 * 1.42 // -- 12 -- Micro
        :
    (verseSize == 3) ? screenHeight * Ratioz.fontSize3 * 1.42 // -- 14 -- Mini
        :
    (verseSize == 4) ? screenHeight * Ratioz.fontSize4 * 1.42 // -- 16 -- Medium
        :
    (verseSize == 5) ? screenHeight * Ratioz.fontSize5 * 1.42 // -- 20 -- Macro
        :
    (verseSize == 6) ? screenHeight * Ratioz.fontSize6 * 1.42 // -- 24 -- Big
        :
    (verseSize == 7) ? screenHeight * Ratioz.fontSize7 * 1.42 // -- 28 -- Massive
        :
    (verseSize == 8) ? screenHeight * Ratioz.fontSize8 * 1.42 // -- 28 -- Gigantic
        :
    screenHeight * Ratioz.fontSize1 * 1.42
    ;
    }
// === === === === === === === === === === === === === === === === === === ===
String sectionStringer (BuildContext context, BldrsSection section){
  return
        section == BldrsSection.RealEstate ? Wordz.realEstate(context) :
        section == BldrsSection.Construction ? Wordz.construction(context) :
        section == BldrsSection.Supplies ? Wordz.supplies(context) :
            Wordz.bldrsShortName(context);
    }
// === === === === === === === === === === === === === === === === === === ===
List<String> sectionsListStrings (BuildContext context){
  List<BldrsSection> sections = bldrsSectionsList;
  List<String> sectionsStrings = new List();
  for(BldrsSection bs in sections){
    sectionsStrings.add(sectionStringer(context, bs));
  }
  return sectionsStrings;
}
// === === === === === === === === === === === === === === === === === === ===
List<String> bzTypesStrings (BuildContext context){
  List<String> bzTypesStrings = new List();

  for(BzType bt in bzTypesList){
    bzTypesStrings.add(bzTypeSingleStringer(context, bt));
  }
  return bzTypesStrings;
}
// === === === === === === === === === === === === === === === === === === ===
String bzTypeSingleStringer (BuildContext context, BzType bzType){
  return
        bzType == BzType.Developer ? Wordz.realEstateDeveloper(context) :
        bzType == BzType.Broker ? Wordz.realEstateBroker(context) :
        bzType == BzType.Designer ? Wordz.designer(context) :
        bzType == BzType.Contractor ? Wordz.contractor(context) :
        bzType == BzType.Artisan ? Wordz.craftsman(context) :
        bzType == BzType.Manufacturer ? Wordz.manufacturer(context) :
        bzType == BzType.Supplier ? Wordz.supplier(context) :
            'Builder';
    }
// === === === === === === === === === === === === === === === === === === ===
String bzTypePluralStringer (BuildContext context, BzType bzType){
  return
    bzType == BzType.Developer ? Wordz.realEstateDevelopers(context) :
    bzType == BzType.Broker ? Wordz.brokers(context) :
    bzType == BzType.Designer ? Wordz.designers(context) :
    bzType == BzType.Contractor ? Wordz.contractors(context) :
    bzType == BzType.Artisan ? Wordz.craftsmen(context) :
    bzType == BzType.Manufacturer ? Wordz.manufacturers(context) :
    bzType == BzType.Supplier ? Wordz.suppliers(context) :
    'Builders';
}
// === === === === === === === === === === === === === === === === === === ===
String flyerTypeSingleStringer (BuildContext context, FlyerType flyerType){

  return
    flyerType == FlyerType.Property   ? Wordz.property(context)  :
    flyerType == FlyerType.Design     ? Wordz.design(context)  :
    flyerType == FlyerType.Product    ? Wordz.product(context)  :
    flyerType == FlyerType.Project    ? Wordz.project(context)  :
    flyerType == FlyerType.Equipment  ? Wordz.equipment(context)  :
    flyerType == FlyerType.Craft      ? Wordz.craft(context)  :
    flyerType == FlyerType.General    ? Wordz.general(context)  :
    Wordz.general(context);
}
// === === === === === === === === === === === === === === === === === === ===
String flyerTypePluralStringer (BuildContext context, FlyerType flyerType){
  return
    flyerType == FlyerType.Property   ? Wordz.properties(context)  :
    flyerType == FlyerType.Design     ? Wordz.designs(context)  :
    flyerType == FlyerType.Product    ? Wordz.products(context)  :
    flyerType == FlyerType.Project    ? Wordz.projects(context)  :
    flyerType == FlyerType.Equipment  ? Wordz.equipments(context)  :
    flyerType == FlyerType.Craft      ? Wordz.crafts(context)  :
    flyerType == FlyerType.General    ? Wordz.general(context)  :
    Wordz.general(context);
}
// === === === === === === === === === === === === === === === === === === ===
String bzFormStringer (BuildContext context, BzForm bzForm){
return
  bzForm == BzForm.Company ? Wordz.company(context) :
  bzForm == BzForm.Individual ? Wordz.individual(context) :
  Wordz.company(context);

}
// === === === === === === === === === === === === === === === === === === ===
List<String> bzFormStrings (BuildContext context){
  List<String> bzFormStrings = new List();

  for(BzForm bt in bzFormsList){
    bzFormStrings.add(bzFormStringer(context, bt));
  }
  return bzFormStrings;
}
// === === === === === === === === === === === === === === === === === === ===
/// should be renamed to Zone Stringer
String localeStringer ({BuildContext context, String countryISO3, String provinceID, String areaID}){
  CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
  String _countryName = translate(context, countryISO3);
  String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, provinceID);
  String _areaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, areaID);

  String verse =
    countryISO3 == null || provinceID == null ? '...' :
    '${Wordz.inn(context)} $_areaName , $_provinceName , $_countryName . ';
return verse;
}
// === === === === === === === === === === === === === === === === === === ===
String functionStringer(Function function) {
  String functionNameAsAString = function.toString();
  int s = functionNameAsAString.indexOf('\'');
  int e = functionNameAsAString.lastIndexOf('\'');
  // print('functionNameAsAString : ${functionNameAsAString.substring(s + 1, e)}');
  return functionNameAsAString.substring(s+1, e);  // return functionNameAsAString;
}
// === === === === === === === === === === === === === === === === === === ===
String removeFirstCharacterFromAString(String string){
  String stringWithoutFirstCharacter = string.length >0 ? string?.substring(1) : null;
  return stringWithoutFirstCharacter;
}
// === === === === === === === === === === === === === === === === === === ===
String removeSpacesFromAString(String string){
  /// solution 1,, won't work, not tested
  // string.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
  /// solution 2
  // string.replaceAll(new RegExp(r"\s+"), "");
  /// solution 3
  // string.replaceAll(' ', '');
  /// solution 4
  // string.split(" ").join("");
  /// solution 5
  String _output = string.toLowerCase().replaceAll(' ', '');
  /// solution 6
  /// String replaceWhitespacesUsingRegex(String s, String replace) {
  ///   if (s == null) {
  ///     return null;
  ///   }
  ///
  ///   // This pattern means "at least one space, or more"
  ///   // \\s : space
  ///   // +   : one or more
  ///   final pattern = RegExp('\\s+');
  ///   return s.replaceAll(pattern, replace);
  ///
  /// ---> I'm just going to shortcut the above method here below
  // string?.replaceAll(new RegExp('\\s+'),'');
  String _output2 = _output?.replaceAll('‎', '');
  String _output3 = _output2?.replaceAll('‏', '');
  String _output4 = _output3?.replaceAll('‎ ', '');
  String _output5 = _output4?.replaceAll(' ‏', '');
  return
    _output5;
}
// === === === === === === === === === === === === === === === === === === ===
String firstCharacterOfAString(String string){
    String _output = string == null || string.length == 0 || string == '' || string == ' '? null :
    string?.substring(0,1);


  return
  _output == null || _output == '' || _output == "" ? null : _output;

  }
// === === === === === === === === === === === === === === === === === === ===
String askHinter (BuildContext context, BzType bzType){
  String askHint =
  bzType == BzType.Developer ? 'I\'m Looking for a property directly from the developer ...' :
  bzType == BzType.Broker ? 'I\'m Looking for a property from brokers and re-sellers ...' :
  bzType == BzType.Manufacturer ? 'I want to Manufacture or get big quantities ...' :
  bzType == BzType.Supplier ? 'I\'m searching for a product ...' :
  bzType == BzType.Designer ? 'I need consultation from a designer ...' :
  bzType == BzType.Contractor ? 'I\'m Looking for a contractor to build a project ...' :
  bzType == BzType.Artisan ? 'I want a craftsman to fix or build something ...' :
  Wordz.askHint(context);
  return askHint;
}
// === === === === === === === === === === === === === === === === === === ===
String bldrsTypePageTitle(BuildContext context, BzType bzType) {
  return
    bzType == BzType.Developer ? Wordz.realEstateDeveloper(context) :
    bzType == BzType.Broker ? Wordz.realEstateBroker(context) :
    bzType == BzType.Manufacturer ? Wordz.manufacturers(context) :
    bzType == BzType.Supplier ? Wordz.suppliers(context) : // and distributors
    bzType == BzType.Designer ? Wordz.constructionTagLine(context) :
    bzType == BzType.Contractor ? Wordz.contractors(context) :
    bzType == BzType.Artisan ? Wordz.craftsmen(context) :
    Wordz.bldrsShortName(context);
}
// === === === === === === === === === === === === === === === === === === ===
String monthYearStringer(BuildContext context, DateTime time){
  return
    '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${getMonthNameByInt(context, (time).month)} , ${(time).year} . ';
}
// === === === === === === === === === === === === === === === === === === ===
String dayMonthYearStringer(BuildContext context, DateTime time){
  return
    '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${(time).day} ${getMonthNameByInt(context, (time).month)} ${(time).year} . ';
}
// === === === === === === === === === === === === === === === === === === ===
List<String> sortAlphabetically(List<String> inputList){
  List<String> _outputList = new List();
  inputList.sort();
  _outputList = inputList;
  return _outputList;
}
// === === === === === === === === === === === === === === === === === === ===
