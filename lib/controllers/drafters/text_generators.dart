import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/sub_models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'timerz.dart';

class TextGenerator{
// -----------------------------------------------------------------------------
  static String sectionStringer (BuildContext context, Section section){
    return
      section == Section.NewProperties ? 'New Properties' : //Wordz.realEstate(context) :
      section == Section.ResaleProperties ? 'Resale Properties' : //Wordz.realEstate(context) :
      section == Section.RentalProperties ? 'Rental Properties' : //Wordz.realEstate(context) :

      section == Section.Designs ? 'Designs' : //Wordz.construction(context) :
      section == Section.Projects ? 'Projects' : //Wordz.construction(context) :
      section == Section.Crafts ? 'Crafts & Trades' : //Wordz.construction(context) :

      section == Section.Products ? 'Products & Materials' : //Wordz.supplies(context) :
      section == Section.Equipment ? 'Tools & Equipment' : //Wordz.supplies(context) :

      Wordz.bldrsShortName(context);
  }
// -----------------------------------------------------------------------------
  static String sectionDescriptionStringer(BuildContext context, Section section){
    String _description =
    section == Section.NewProperties ? 'By RealEstate Developers.' : //Wordz.realEstateTagLine(context) :
    section == Section.ResaleProperties ? 'By RealEstate Brokers.' : //Wordz.realEstateTagLine(context) :
    section == Section.RentalProperties ? 'By Developers & Brokers.' : //Wordz.realEstateTagLine(context) :

    section == Section.Designs ? 'By Architects & Designers' : //Wordz.constructionTagLine(context) :
    section == Section.Projects ? 'By Contractors' : //Wordz.constructionTagLine(context) :
    section == Section.Crafts ? 'By Craftsmen, Technicians & Artists.' : //Wordz.constructionTagLine(context) :

    section == Section.Products ? 'By Manufacturers & Suppliers.' : //Wordz.suppliesTagLine(context) :
    section == Section.Equipment ? 'By Manufacturers & Suppliers.' : //Wordz.constructionTagLine(context) :

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
      Wordz.general(context);
  }
// -----------------------------------------------------------------------------
  static String flyerTypeSingleStringerByBzType(BuildContext context, BzType bzType){
    FlyerType _defaultFlyerType = FlyerTypeClass.concludeFlyerType(bzType);
    String _string = flyerTypeSingleStringer(context, _defaultFlyerType);
    return _string;
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
    String _provinceID = zone.cityID;
    String _districtID = zone.districtID;

    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, _countryID);
    String _provinceName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _provinceID);
    String _districtName = _countryPro.getDistrictNameWithCurrentLanguageIfPossible(context, _districtID);

    String verse =
    _countryID == null || _provinceID == null ? '...' :
    '${Wordz.inn(context)} $_districtName , $_provinceName , $_countryName . ';
    return verse;
  }
// -----------------------------------------------------------------------------
  static String cityCountryStringer ({BuildContext context, Zone zone,}){
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    String _countryID = zone.countryID;
    String _cityID = zone.cityID;

    String _countryName = _countryPro.getCountryNameInCurrentLanguageByIso3(context, _countryID);
    String _cityName = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, _cityID);

    String verse =
    _countryID == null || _cityID == null ? '...' :
    '${Wordz.inn(context)}, $_cityName , $_countryName . ';
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
