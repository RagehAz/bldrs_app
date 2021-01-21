import 'package:bldrs/models/enums/enum_bldrs_section.dart';
import 'package:bldrs/models/enums/enum_bz_form.dart';
import 'package:bldrs/models/enums/enum_bz_type.dart';
import 'package:bldrs/models/enums/enum_flyer_type.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
TextDirection superTextDirection(BuildContext context){
  if (translate(context, 'Text_Direction') == 'ltr')
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
        section == BldrsSection.RealEstate ? 'Real-Estate' :
        section == BldrsSection.Construction ? 'Construction' :
        section == BldrsSection.Supplies ? 'Supplies' :
            'Home';
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
        bzType == BzType.Developer ? 'Real-Estate Developer' :
        bzType == BzType.Broker ? 'Real-Estate Broker' :
        bzType == BzType.Designer ? 'Designer' :
        bzType == BzType.Contractor ? 'Contractor' :
        bzType == BzType.Artisan ? 'Artisan' :
        bzType == BzType.Manufacturer ? 'Manufacturer' :
        bzType == BzType.Supplier ? 'Supplier' :
            'Builder';
    }
// === === === === === === === === === === === === === === === === === === ===
String bzTypePluralStringer (BuildContext context, BzType bzType){
  return
    bzType == BzType.Developer ? 'Real-Estate Developers' :
    bzType == BzType.Broker ? 'Real-Estate Brokers' :
    bzType == BzType.Designer ? 'Designers' :
    bzType == BzType.Contractor ? 'Contractors' :
    bzType == BzType.Artisan ? 'Artisans' :
    bzType == BzType.Manufacturer ? 'Manufacturers' :
    bzType == BzType.Supplier ? 'Suppliers' :
    'Builders';
}
// === === === === === === === === === === === === === === === === === === ===
String flyerTypeSingleStringer (BuildContext context, FlyerType flyerType){

  return
    flyerType == FlyerType.Property   ? translate(context, 'Property')  :
    flyerType == FlyerType.Design     ? translate(context, 'Design')  :
    flyerType == FlyerType.Product    ? translate(context, 'Product')  :
    flyerType == FlyerType.Project    ? translate(context, 'Project')  :
    flyerType == FlyerType.Equipment  ? translate(context, 'Equipment')  :
    flyerType == FlyerType.Craft      ? translate(context, 'Craft')  :
    flyerType == FlyerType.General    ? translate(context, 'Bldrs_Short_Name')  :
    'Builder';
}
// === === === === === === === === === === === === === === === === === === ===
String flyerTypePluralStringer (BuildContext context, FlyerType flyerType){
  return
    flyerType == FlyerType.Property   ? translate(context, 'Properties')  :
    flyerType == FlyerType.Design     ? translate(context, 'Designs')  :
    flyerType == FlyerType.Product    ? translate(context, 'Products')  :
    flyerType == FlyerType.Project    ? translate(context, 'Projects')  :
    flyerType == FlyerType.Equipment  ? translate(context, 'Equipments')  :
    flyerType == FlyerType.Craft      ? translate(context, 'Crafts')  :
    flyerType == FlyerType.General    ? translate(context, 'Bldrs_Short_Name')  :
    translate(context, 'Bldrs_Short_Name');
}
// === === === === === === === === === === === === === === === === === === ===
String bzFormStringer (BuildContext context, BzForm bzForm){
return
  bzForm == BzForm.Company ? 'Company' :
  bzForm == BzForm.Individual ? 'Individual' :
  'impossible bzForm';

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
    '${translate(context, 'In')} $city, $country';
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
String askHinter (BzType bzType){
  String askHint =
  bzType == BzType.Developer ? 'I\'m Looking for a property directly from the developer ...' :
  bzType == BzType.Broker ? 'I\'m Looking for a property from brokers and re-sellers ...' :
  bzType == BzType.Manufacturer ? 'I want to Manufacture or get big quantities ...' :
  bzType == BzType.Supplier ? 'I\'m searching for a product ...' :
  bzType == BzType.Designer ? 'I need consultation from a designer ...' :
  bzType == BzType.Contractor ? 'I\'m Looking for a contractor to build a project ...' :
  bzType == BzType.Artisan ? 'I want a craftsman to fix or build something ...' :
  'Ask the Builders in your city';
  return askHint;
}
// === === === === === === === === === === === === === === === === === === ===
String bldrsTypePageTitle(BzType bzType) {
  return
    bzType == BzType.Developer ? 'Real-Estate Developers' :
    bzType == BzType.Broker ? 'Real-Estate Brokers' :
    bzType == BzType.Manufacturer ? 'Manufacturers' :
    bzType == BzType.Supplier ? 'Suppliers & Distributors' :
    bzType == BzType.Designer ? 'Architects, Engineers, Designers & Decorators' :
    bzType == BzType.Contractor ? 'General & Speciality Contractors' :
    bzType == BzType.Artisan ? 'Artisans & Craftsmen' :
    'The Builders';
}
// === === === === === === === === === === === === === === === === === === ===
