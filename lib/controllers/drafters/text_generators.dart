import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/secondary_models/name_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:flutter/material.dart';

abstract class TextGenerator{
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

      section == Section.All ? 'All flyers' : //Wordz.supplies(context) :

      Wordz.bldrsShortName(context);
  }
// -----------------------------------------------------------------------------
  static String sectionDescriptionStringer(BuildContext context, Section section){
    final String _description =
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
    const List<Section> _sections = SectionClass.SectionsList;
    final List<String> _sectionsStrings = <String>[];
    for(Section bs in _sections){
      _sectionsStrings.add(sectionStringer(context, bs));
    }
    return _sectionsStrings;
  }
// -----------------------------------------------------------------------------
  static List<String> bzTypesStrings (BuildContext context){
    final List<String> _bzTypesStrings = <String>[];

    for(BzType bt in BzModel.bzTypesList){
      _bzTypesStrings.add(bzTypeSingleStringer(context, bt));
    }
    return _bzTypesStrings;
  }
// -----------------------------------------------------------------------------
  static String bzTypeSingleStringer (BuildContext context, BzType bzType){
    return
      bzType == BzType.developer ? Wordz.realEstateDeveloper(context) :
      bzType == BzType.broker ? Wordz.realEstateBroker(context) :
      bzType == BzType.designer ? Wordz.designer(context) :
      bzType == BzType.contractor ? Wordz.contractor(context) :
      bzType == BzType.artisan ? Wordz.craftsman(context) :
      bzType == BzType.manufacturer ? Wordz.manufacturer(context) :
      bzType == BzType.supplier ? Wordz.supplier(context) :
      'Builder';
  }
// -----------------------------------------------------------------------------
  static String bzTypePluralStringer (BuildContext context, BzType bzType){
    return
      bzType == BzType.developer ? Wordz.realEstateDevelopers(context) :
      bzType == BzType.broker ? Wordz.brokers(context) :
      bzType == BzType.designer ? Wordz.designers(context) :
      bzType == BzType.contractor ? Wordz.contractors(context) :
      bzType == BzType.artisan ? Wordz.craftsmen(context) :
      bzType == BzType.manufacturer ? Wordz.manufacturers(context) :
      bzType == BzType.supplier ? Wordz.suppliers(context) :
      'Builders';
  }
// -----------------------------------------------------------------------------
  static String flyerTypeSingleStringer (BuildContext context, FlyerType flyerType){

    return
      flyerType == FlyerType.newProperty      ? 'New Property'  :
      flyerType == FlyerType.resaleProperty   ? 'Resale Property'  :
      flyerType == FlyerType.rentalProperty   ? 'Rental Property'  :
      flyerType == FlyerType.design           ? Wordz.design(context)  :
      flyerType == FlyerType.product          ? Wordz.product(context)  :
      flyerType == FlyerType.project          ? Wordz.project(context)  :
      flyerType == FlyerType.equipment        ? Wordz.equipment(context)  :
      flyerType == FlyerType.craft            ? Wordz.craft(context)  :
      Wordz.general(context);
  }
// -----------------------------------------------------------------------------
  static String flyerTypeSingleStringerByBzType(BuildContext context, BzType bzType){
    final FlyerType _defaultFlyerType = FlyerTypeClass.concludeFlyerType(bzType);
    final String _string = flyerTypeSingleStringer(context, _defaultFlyerType);
    return _string;
  }
// -----------------------------------------------------------------------------
  static String flyerTypePluralStringer (BuildContext context, FlyerType flyerType){
    return
      flyerType == FlyerType.rentalProperty   ? Wordz.properties(context)  :
      flyerType == FlyerType.design     ? Wordz.designs(context)  :
      flyerType == FlyerType.product    ? Wordz.products(context)  :
      flyerType == FlyerType.project    ? Wordz.projects(context)  :
      flyerType == FlyerType.equipment  ? Wordz.equipments(context)  :
      flyerType == FlyerType.craft      ? Wordz.crafts(context)  :
      Wordz.general(context);
  }
// -----------------------------------------------------------------------------
  static String bzFormStringer (BuildContext context, BzForm bzForm){
    return
      bzForm == BzForm.company ? Wordz.company(context) :
      bzForm == BzForm.individual ? Wordz.individual(context) :
      Wordz.company(context);

  }
// -----------------------------------------------------------------------------
  static List<String> bzFormStrings (BuildContext context){
    final List<String> _bzFormStrings = <String>[];

    for(BzForm bt in BzModel.bzFormsList){
      _bzFormStrings.add(bzFormStringer(context, bt));
    }
    return _bzFormStrings;
  }
// -----------------------------------------------------------------------------
  static String countryStringer ({@required BuildContext context, @required CountryModel country, @required CityModel city, @required Zone zone}){
    String _verse = '...';

    if (country != null && Zone.zoneHasAllIDs(zone)){

      final String _countryName = CountryModel.getTranslatedCountryNameByID(context: context, countryID: country.id);

      final String _cityName = CityModel.getTranslatedCityNameFromCity(context: context, city: city,);

      final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
        context: context,
        city: city,
        districtID: zone.districtID,
      );

      _verse =
      zone.countryID == null || zone.cityID == null ? '...' :
      '${Wordz.inn(context)} $_districtName , $_cityName , $_countryName . ';

    }


    return _verse;
  }
// -----------------------------------------------------------------------------
  static String cityCountryStringer ({@required BuildContext context, @required CountryModel country, @required CityModel city, @required Zone zone}){

    String _verse = '...';

    if (country != null && Zone.zoneHasAllIDs(zone)){

      final String _countryName = Name.getNameByCurrentLingoFromNames(context, country.names);

      final String _cityName = Name.getNameByCurrentLingoFromNames(context, city.names);

      _verse =
      zone.countryID == null || zone.cityID == null ? '...' :
      '${Wordz.inn(context)}, $_cityName , $_countryName . ';


    }

    return _verse;
  }
// -----------------------------------------------------------------------------
  static String functionStringer(Function function) {
    final String _functionNameAsAString = function.toString();
    final int _s = _functionNameAsAString.indexOf('\'');
    final int _e = _functionNameAsAString.lastIndexOf('\'');
    // print('functionNameAsAString : ${functionNameAsAString.substring(s + 1, e)}');
    return _functionNameAsAString.substring(_s+1, _e);  // return functionNameAsAString;
  }
// -----------------------------------------------------------------------------
  static String askHinter (BuildContext context, BzType bzType){
    final String _askHint =
    bzType == BzType.developer ? 'I\'m Looking for a property directly from the developer ...' :
    bzType == BzType.broker ? 'I\'m Looking for a property from brokers and re-sellers ...' :
    bzType == BzType.manufacturer ? 'I want to Manufacture or get big quantities ...' :
    bzType == BzType.supplier ? 'I\'m searching for a product ...' :
    bzType == BzType.designer ? 'I need consultation from a designer ...' :
    bzType == BzType.contractor ? 'I\'m Looking for a contractor to build a project ...' :
    bzType == BzType.artisan ? 'I want a craftsman to fix or build something ...' :
    Wordz.askHint(context);
    return _askHint;
  }
// -----------------------------------------------------------------------------
  static String bldrsTypePageTitle(BuildContext context, BzType bzType) {
    return
      bzType == BzType.developer ? Wordz.realEstateDeveloper(context) :
      bzType == BzType.broker ? Wordz.realEstateBroker(context) :
      bzType == BzType.manufacturer ? Wordz.manufacturers(context) :
      bzType == BzType.supplier ? Wordz.suppliers(context) : // and distributors
      bzType == BzType.designer ? Wordz.constructionTagLine(context) :
      bzType == BzType.contractor ? Wordz.contractors(context) :
      bzType == BzType.artisan ? Wordz.craftsmen(context) :
      Wordz.bldrsShortName(context);
  }
// -----------------------------------------------------------------------------

}
