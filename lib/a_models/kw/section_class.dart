import 'package:bldrs/a_models/bz/bz_model.dart';

enum Section {
  all,
  properties,
  designs,
  projects,
  crafts,
  products,
  equipment,
}
// -----------------------------------------------------------------------------
const List<Section> sectionsList = <Section>[
  Section.properties,
  Section.designs,
  Section.projects,
  Section.crafts,
  Section.products,
  Section.equipment,
];
// -----------------------------------------------------------------------------
const List<Section> sectionsTabs = <Section>[
  Section.all,
  Section.properties,
  Section.designs,
  Section.projects,
  Section.crafts,
  Section.products,
  Section.equipment,
];
// -----------------------------------------------------------------------------
Section decipherSection(int x) {
  switch (x) {
    case 1: return Section.properties; break;
    case 4: return Section.designs; break;
    case 5: return Section.projects; break;
    case 6: return Section.crafts; break;
    case 7: return Section.products; break;
    case 8: return Section.equipment; break;
    default: return null;
  }
}

// -----------------------------------------------------------------------------
//   int cipherSection (Section x){
//     switch (x){
//       case Section.properties :       return 1; break;
//       case Section.designs :          return 4; break;
//       case Section.projects :         return 5; break;
//       case Section.crafts :           return 6; break;
//       case Section.products :         return 7; break;
//       case Section.equipment :        return 8; break;
//       default : return null;
//     }
//   }
// -----------------------------------------------------------------------------
Section getSectionByBzType(BzType bzType) {
  switch (bzType) {
    case BzType.developer: return Section.properties; break;
    case BzType.broker: return Section.properties; break;
    case BzType.designer: return Section.designs; break;
    case BzType.contractor: return Section.projects; break;
    case BzType.artisan: return Section.crafts; break;
    case BzType.manufacturer: return Section.products; break;
    case BzType.supplier: return Section.products; break;
    default: return null;
  }
}
// -----------------------------------------------------------------------------
