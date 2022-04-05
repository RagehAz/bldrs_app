import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
enum FlyerType {
  all,
  property,
  design,
  project,
  craft,
  product,
  equipment,
  non,
}
// -----------------------------------------------------------------------------
const List<FlyerType> flyerTypesList = <FlyerType>[
  FlyerType.property,
  FlyerType.design,
  FlyerType.product,
  FlyerType.project,
  FlyerType.craft,
  FlyerType.equipment,
];
// -----------------------------------------------------------------------------
const List<FlyerType> sectionsList = <FlyerType>[
  FlyerType.all,
  FlyerType.property,
  FlyerType.design,
  FlyerType.product,
  FlyerType.project,
  FlyerType.craft,
  FlyerType.equipment,
];
// -----------------------------------------------------------------------------
int getFlyerTypeIndexFromSectionsTabs(FlyerType flyerType){
  final int _index = sectionsList.indexWhere((type) => type == flyerType);
  return _index;
}
// -----------------------------------------------------------------------------
String fixFlyerTypeFromIntToString(int x) {
  switch (x) {
    case 1: return 'rentalProperty'; break; // 1
    case 2: return 'design'; break; // 2
    case 3: return 'product'; break; // 3
    case 4: return 'project'; break; // 4
    case 5: return 'craft'; break; // 5
    case 6: return 'equipment'; break; // 6
    case 7: return 'newProperty'; break; // 7
    case 8: return 'resaleProperty'; break; // 8

    default: return null;
  }
}
// -----------------------------------------------------------------------------
FlyerType decipherFlyerType(String x) {
  switch (x) {
    case 'all'      : return FlyerType.all; break; // 1
    case 'property' : return FlyerType.property; break; // 1
    case 'design'   : return FlyerType.design; break; // 2
    case 'product'  : return FlyerType.product; break; // 3
    case 'project'  : return FlyerType.project; break; // 4
    case 'craft'    : return FlyerType.craft; break; // 5
    case 'equipment': return FlyerType.equipment; break; // 6
    default: return null;
  }
}
// -----------------------------------------------------------------------------
String cipherFlyerType(FlyerType x) {
  switch (x) {
    case FlyerType.all        : return 'all'; break;
    case FlyerType.property   : return 'property'; break;
    case FlyerType.design     : return 'design'; break;
    case FlyerType.product    : return 'product'; break;
    case FlyerType.project    : return 'project'; break;
    case FlyerType.craft      : return 'craft'; break;
    case FlyerType.equipment  : return 'equipment'; break;
    default: return null;
  }
}
// -----------------------------------------------------------------------------
List<String> cipherFlyersTypes(List<FlyerType> flyersTypes){

  final List<String> _strings = <String>[];

  if (Mapper.canLoopList(flyersTypes) == true){

    for (final FlyerType type in flyersTypes){
      _strings.add(cipherFlyerType(type));
    }

  }
  return _strings;
}
// -----------------------------------------------------------------------------
List<FlyerType> decipherFlyersTypes(List<dynamic> strings){

  final List<FlyerType> _flyersTypes = <FlyerType>[];

  if (Mapper.canLoopList(strings) == true){
    for (final String str in strings){
      _flyersTypes.add(decipherFlyerType(str));
    }
  }

  return _flyersTypes;
}
// -----------------------------------------------------------------------------
FlyerType concludeFlyerType(BzType bzType) {
  switch (bzType) {
    case BzType.developer: return FlyerType.property; break;
    case BzType.broker: return FlyerType.property; break;
    case BzType.designer: return FlyerType.design; break;
    case BzType.contractor: return FlyerType.project; break;
    case BzType.craftsman: return FlyerType.craft; break;
    case BzType.manufacturer: return FlyerType.product; break; // product or equipment for author to choose while creating flyer
    case BzType.supplier: return FlyerType.product; break; // product or equipment for author to choose while creating flyer
    default: return null;
  }
}
// -----------------------------------------------------------------------------
List<FlyerType> concludePossibleFlyerTypesForBz({@required BzType bzType}) {
  switch (bzType) {
    case BzType.developer: return <FlyerType>[FlyerType.property]; break;
    case BzType.broker: return <FlyerType>[FlyerType.property]; break;
    case BzType.designer: return <FlyerType>[FlyerType.design]; break;
    case BzType.contractor: return <FlyerType>[FlyerType.project]; break;
    case BzType.craftsman: return <FlyerType>[FlyerType.craft]; break;
    case BzType.manufacturer: return <FlyerType>[FlyerType.product, FlyerType.equipment]; break; // product or equipment for author to choose while creating flyer
    case BzType.supplier: return <FlyerType>[FlyerType.product, FlyerType.equipment]; break; // product or equipment for author to choose while creating flyer
    default: return null;
  }
}
// -----------------------------------------------------------------------------
bool flyerTypesIncludeThisType({
  @required FlyerType flyerType,
  @required List<FlyerType> flyerTypes,
}){
  bool _includes = false;

  if (Mapper.canLoopList(flyerTypes) == true){
    if (flyerTypes.contains(flyerType) == true){
      _includes = true;
    }
  }

  return _includes;
}
// -----------------------------------------------------------------------------
String translateFlyerType({
  @required BuildContext context,
  @required FlyerType flyerType,
  bool pluralTranslation = true,
}){

  /// PLURAL
  if (pluralTranslation == true){
    return
      flyerType == FlyerType.all         ? superPhrase(context, 'phid_all_flyer_types') :
      flyerType == FlyerType.property    ? superPhrase(context, 'phid_properties')    :
      flyerType == FlyerType.design      ? superPhrase(context, 'phid_designs')    :
      flyerType == FlyerType.product     ? superPhrase(context, 'phid_products')    :
      flyerType == FlyerType.project     ? superPhrase(context, 'phid_projects')    :
      flyerType == FlyerType.equipment   ? superPhrase(context, 'phid_equipments')    :
      flyerType == FlyerType.craft       ? superPhrase(context, 'phid_products')    :
      superPhrase(context, 'phid_general');
  }

  /// SINGLE
  else {
    return
      flyerType == FlyerType.all              ? superPhrase(context, 'phid_all_flyer_types') :
      flyerType == FlyerType.property         ? superPhrase(context, 'phid_propertyFlyer')    :
      flyerType == FlyerType.design           ? superPhrase(context, 'phid_designFlyer')    :
      flyerType == FlyerType.product          ? superPhrase(context, 'phid_productFlyer')    :
      flyerType == FlyerType.project          ? superPhrase(context, 'phid_projectFlyer')    :
      flyerType == FlyerType.equipment        ? superPhrase(context, 'phid_equipmentFlyer')    :
      flyerType == FlyerType.craft            ? superPhrase(context, 'phid_craftFlyer')    :
      superPhrase(context, 'phid_general');
  }

}
// -----------------------------------------------------------------------------
List<String> translateFlyerTypes({
  @required BuildContext context,
  @required List<FlyerType> flyerTypes,
  bool pluralTranslation = true,
}){
  final List<String> _strings = <String>[];

  if (Mapper.canLoopList(flyerTypes) == true){

    for (final FlyerType type in flyerTypes){

      final String _translation = translateFlyerType(
        context: context,
        flyerType: type,
        pluralTranslation: pluralTranslation,
      );

      _strings.add(_translation);

    }

  }

  return _strings;
}
// -----------------------------------------------------------------------------
String translateFlyerTypeByBzType({
  @required BuildContext context,
  @required BzType bzType,
  bool pluralTranslation = true,
}){

  final FlyerType _concludedFlyerType = concludeFlyerType(bzType);

  final String _translation = translateFlyerType(
    context: context,
    flyerType: _concludedFlyerType,
    pluralTranslation: pluralTranslation,
  );

  return _translation;
}

/*

ZEBALA

// -----------------------------------------------------------------------------
FlyerType getFlyerTypeBySection({@required SectionClass.Section section}) {
  final FlyerType _flyersTypes =
  section == SectionClass.Section.properties ? FlyerType.property
      :
  section == SectionClass.Section.designs ? FlyerType.design
      :
  section == SectionClass.Section.projects ? FlyerType.project
      :
  section == SectionClass.Section.crafts ? FlyerType.craft
      :
  section == SectionClass.Section.products ? FlyerType.product
      :
  section == SectionClass.Section.equipment ? FlyerType.equipment
      :
  null;

  return _flyersTypes;
}
// -----------------------------------------------------------------------------


 */
