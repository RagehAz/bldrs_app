import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

// enum SequenceType{
//   TwoKeywords, // for intersecting data structure : keyword 1 + keyword 2
//   OneKeyword, // for straight data structure : filterID / groupID / subGroupID / keyword
// }

class SectionRoute {
  final bool sectionIsOn;
  final String keywordID;
  final FilterModel secondKeywords;

  SectionRoute({
    @required this.sectionIsOn,
    @required this.keywordID, // groupID or keywordID will see
    this.secondKeywords, // if null,
  });

  static List<SectionRoute> propertiesRoutes = <SectionRoute>[
    SectionRoute(sectionIsOn: true, keywordID: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_coop', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_football', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_tennis', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_basketball', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),

  ];

  static List<SectionRoute> designsRoutes = <SectionRoute>[
    SectionRoute(sectionIsOn: true, keywordID: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_landscape', secondKeywords: FilterModel.spaceTypeFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionRoute(sectionIsOn: true, keywordID: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
  ];

  static List<SectionRoute> craftsRoutes = <SectionRoute>[];

  static List<SectionRoute> productsRoutes = <SectionRoute>[];

}

/*

Realestate
home list : property license

Construction


Supplies


 */