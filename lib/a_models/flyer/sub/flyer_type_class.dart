import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/kw/section_class.dart' as SectionClass;

enum FlyerType {
  property,
  design,
  project,
  craft,
  product,
  equipment,
  non,
}
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
FlyerType getFlyerTypeBySection({SectionClass.Section section}) {
  final FlyerType _flyersTypes = section == SectionClass.Section.properties
      ? FlyerType.property
      : section == SectionClass.Section.designs
          ? FlyerType.design
          : section == SectionClass.Section.projects
              ? FlyerType.project
              : section == SectionClass.Section.crafts
                  ? FlyerType.craft
                  : section == SectionClass.Section.products
                      ? FlyerType.product
                      : section == SectionClass.Section.equipment
                          ? FlyerType.equipment
                          : null;

  return _flyersTypes;
}

// -----------------------------------------------------------------------------
List<FlyerType> flyerTypesList = <FlyerType>[
  FlyerType.property,
  FlyerType.design,
  FlyerType.product,
  FlyerType.project,
  FlyerType.craft,
  FlyerType.equipment,
  // FlyerType.General,
];
// -----------------------------------------------------------------------------
String fixFlyerTypeFromIntToString(int x) {
  switch (x) {
    case 1:
      return 'rentalProperty';
      break; // 1
    case 2:
      return 'design';
      break; // 2
    case 3:
      return 'product';
      break; // 3
    case 4:
      return 'project';
      break; // 4
    case 5:
      return 'craft';
      break; // 5
    case 6:
      return 'equipment';
      break; // 6
    case 7:
      return 'newProperty';
      break; // 7
    case 8:
      return 'resaleProperty';
      break; // 8

    default:
      return null;
  }
}

// -----------------------------------------------------------------------------
FlyerType decipherFlyerType(String x) {
  switch (x) {
    case 'property':
      return FlyerType.property;
      break; // 1
    case 'design':
      return FlyerType.design;
      break; // 2
    case 'product':
      return FlyerType.product;
      break; // 3
    case 'project':
      return FlyerType.project;
      break; // 4
    case 'craft':
      return FlyerType.craft;
      break; // 5
    case 'equipment':
      return FlyerType.equipment;
      break; // 6

    default:
      return null;
  }
}

// -----------------------------------------------------------------------------
String cipherFlyerType(FlyerType x) {
  switch (x) {
    case FlyerType.property:
      return 'property';
      break;
    case FlyerType.design:
      return 'design';
      break;
    case FlyerType.product:
      return 'product';
      break;
    case FlyerType.project:
      return 'project';
      break;
    case FlyerType.craft:
      return 'craft';
      break;
    case FlyerType.equipment:
      return 'equipment';
      break;

    default:
      return null;
  }
}

// -----------------------------------------------------------------------------
FlyerType concludeFlyerType(BzType bzType) {
  switch (bzType) {
    case BzType.developer:
      return FlyerType.property;
      break;
    case BzType.broker:
      return FlyerType.property;
      break;
    case BzType.designer:
      return FlyerType.design;
      break;
    case BzType.contractor:
      return FlyerType.project;
      break;
    case BzType.artisan:
      return FlyerType.craft;
      break;
    case BzType.manufacturer:
      return FlyerType.product;
      break; // product or equipment for author to choose while creating flyer
    case BzType.supplier:
      return FlyerType.product;
      break; // product or equipment for author to choose while creating flyer
    default:
      return null;
  }
}

// -----------------------------------------------------------------------------
List<FlyerType> concludePossibleFlyerTypesForBz({BzType bzType}) {
  switch (bzType) {
    case BzType.developer:
      return <FlyerType>[FlyerType.property];
      break;
    case BzType.broker:
      return <FlyerType>[FlyerType.property];
      break;
    case BzType.designer:
      return <FlyerType>[FlyerType.design];
      break;
    case BzType.contractor:
      return <FlyerType>[FlyerType.project];
      break;
    case BzType.artisan:
      return <FlyerType>[FlyerType.craft];
      break;
    case BzType.manufacturer:
      return <FlyerType>[FlyerType.product, FlyerType.equipment];
      break; // product or equipment for author to choose while creating flyer
    case BzType.supplier:
      return <FlyerType>[FlyerType.product, FlyerType.equipment];
      break; // product or equipment for author to choose while creating flyer
    default:
      return null;
  }
}
// -----------------------------------------------------------------------------
