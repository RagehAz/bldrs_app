import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
TextDirection superTextDirection(BuildContext context){
  if (Wordz.textDirection(context) == 'ltr')
    {return TextDirection.ltr;}
  else
    {return TextDirection.rtl;}
}
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
    bzType == BzType.Developer ? 'Real-Estate Developers' :
    bzType == BzType.Broker ? 'Real-Estate Brokers' :
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
String localeStringer (BuildContext context, String city, String country){
String verse =
    city == null || country == null ? '...' :
    '${Wordz.inn(context)} $city, $country';
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
  String stringWithoutFirstCharacter = string.substring(1);
  return stringWithoutFirstCharacter;
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
