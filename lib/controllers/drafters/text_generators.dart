import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'timerz.dart';

class TextGenerator{
// -----------------------------------------------------------------------------
  static String sectionStringer (BuildContext context, Section section){
    return
      section == Section.RealEstate ? Wordz.realEstate(context) :
      section == Section.Construction ? Wordz.construction(context) :
      section == Section.Supplies ? Wordz.supplies(context) :
      Wordz.bldrsShortName(context);
  }
// -----------------------------------------------------------------------------
  static String sectionDescriptionStringer(BuildContext context, Section section){
    String _description =
    section == Section.RealEstate ? Wordz.realEstateTagLine(context) :
    section == Section.Construction ? Wordz.constructionTagLine(context) :
    section == Section.Supplies ? Wordz.suppliesTagLine(context) :
    Wordz.bldrsShortName(context);

    return _description;
  }
// -----------------------------------------------------------------------------
  static List<String> sectionsListStrings (BuildContext context){
    List<Section> sections = SectionClass.SectionsList;
    List<String> sectionsStrings = new List();
    for(Section bs in sections){
      sectionsStrings.add(sectionStringer(context, bs));
    }
    return sectionsStrings;
  }
// -----------------------------------------------------------------------------
  static List<String> bzTypesStrings (BuildContext context){
    List<String> bzTypesStrings = new List();

    for(BzType bt in BzModel.bzTypesList){
      bzTypesStrings.add(bzTypeSingleStringer(context, bt));
    }
    return bzTypesStrings;
  }
// -----------------------------------------------------------------------------
  static String bzTypeSingleStringer (BuildContext context, BzType bzType){
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
// -----------------------------------------------------------------------------
  static String bzTypePluralStringer (BuildContext context, BzType bzType){
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
// -----------------------------------------------------------------------------
  static String flyerTypeSingleStringer (BuildContext context, FlyerType flyerType){

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
// -----------------------------------------------------------------------------
  static String flyerTypePluralStringer (BuildContext context, FlyerType flyerType){
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
// -----------------------------------------------------------------------------
  static String bzFormStringer (BuildContext context, BzForm bzForm){
    return
      bzForm == BzForm.Company ? Wordz.company(context) :
      bzForm == BzForm.Individual ? Wordz.individual(context) :
      Wordz.company(context);

  }
// -----------------------------------------------------------------------------
  static List<String> bzFormStrings (BuildContext context){
    List<String> bzFormStrings = new List();

    for(BzForm bt in BzModel.bzFormsList){
      bzFormStrings.add(bzFormStringer(context, bt));
    }
    return bzFormStrings;
  }
// -----------------------------------------------------------------------------
  static String zoneStringer ({BuildContext context, Zone zone,}){
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    String _countryID = zone.countryID;
    String _provinceID = zone.provinceID;
    String _areaID = zone.areaID;

    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, _countryID);
    String _provinceName = _countryPro.getProvinceNameWithCurrentLanguageIfPossible(context, _provinceID);
    String _areaName = _countryPro.getAreaNameWithCurrentLanguageIfPossible(context, _areaID);

    String verse =
    _countryID == null || _provinceID == null ? '...' :
    '${Wordz.inn(context)} $_areaName , $_provinceName , $_countryName . ';
    return verse;
  }
// -----------------------------------------------------------------------------
  static String functionStringer(Function function) {
    String functionNameAsAString = function.toString();
    int s = functionNameAsAString.indexOf('\'');
    int e = functionNameAsAString.lastIndexOf('\'');
    // print('functionNameAsAString : ${functionNameAsAString.substring(s + 1, e)}');
    return functionNameAsAString.substring(s+1, e);  // return functionNameAsAString;
  }
// -----------------------------------------------------------------------------
  static String askHinter (BuildContext context, BzType bzType){
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
// -----------------------------------------------------------------------------
  static String bldrsTypePageTitle(BuildContext context, BzType bzType) {
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
// -----------------------------------------------------------------------------
  static String monthYearStringer(BuildContext context, DateTime time){
    return
      '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${getMonthNameByInt(context, (time).month)} ${(time).year}';
  }
// -----------------------------------------------------------------------------
  static String dayMonthYearStringer(BuildContext context, DateTime time){
    return
      '${Wordz.inn(context)} ${Wordz.bldrsShortName(context)} since : ${(time).day} ${getMonthNameByInt(context, (time).month)} ${(time).year}';
  }
// -----------------------------------------------------------------------------
static String hourMinuteSecondStringer(DateTime time){
    return
        '${time.hour}:${time.minute}:${time.second}';
}
// -----------------------------------------------------------------------------
static String hourMinuteSecondListOfStrings(List<DateTime> times){
    String _output = '';

    for (int i = 0; i<times.length; i++){
      _output = '${_output+hourMinuteSecondStringer(times[i])}\n';
    }
    return _output;
}
// -----------------------------------------------------------------------------
  static String hourMinuteSecondListOfStringsWithIndexes(List<DateTime> times, List<int> indexes){
    String _output = '';

    for (int i = 0; i<times.length; i++){

      String _indexString = '${indexes[i]} : ';
      String _timeStampString =  '${hourMinuteSecondStringer(times[i])}';

      _output = '${_output+_indexString+_timeStampString}\n';
    }
    return _output;
  }
// -----------------------------------------------------------------------------
}
