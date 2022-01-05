

// enum Section {
//   all,
//   properties,
//   designs,
//   projects,
//   crafts,
//   products,
//   equipment,
// }
// // -----------------------------------------------------------------------------
// const List<Section> sectionsList = <Section>[
//   Section.properties,
//   Section.designs,
//   Section.projects,
//   Section.crafts,
//   Section.products,
//   Section.equipment,
// ];
// // -----------------------------------------------------------------------------
// const List<Section> sectionsTabs = <Section>[
//   Section.all,
//   Section.properties,
//   Section.designs,
//   Section.projects,
//   Section.crafts,
//   Section.products,
//   Section.equipment,
// ];
// -----------------------------------------------------------------------------
// Section decipherSection(String section) {
//   switch (section) {
//     case 'all':         return Section.all        ;     break;
//     case 'properties':  return Section.properties ;     break;
//     case 'designs':     return Section.designs    ;     break;
//     case 'projects':    return Section.projects   ;     break;
//     case 'crafts':      return Section.crafts     ;     break;
//     case 'products':    return Section.products   ;     break;
//     case 'equipment':   return Section.equipment  ;     break;
//     default: return null;
//   }
// }
// -----------------------------------------------------------------------------
//   String cipherSection (Section section){
//     switch (section){
//       case Section.all :              return 'all'; break;
//       case Section.properties :       return 'properties'; break;
//       case Section.designs :          return 'designs'; break;
//       case Section.projects :         return 'projects'; break;
//       case Section.crafts :           return 'crafts'; break;
//       case Section.products :         return 'products'; break;
//       case Section.equipment :        return 'equipment'; break;
//       default : return null;
//     }
//   }
// // -----------------------------------------------------------------------------
// Section getSectionByBzType(BzType bzType) {
//   switch (bzType) {
//     case BzType.developer: return Section.properties; break;
//     case BzType.broker: return Section.properties; break;
//     case BzType.designer: return Section.designs; break;
//     case BzType.contractor: return Section.projects; break;
//     case BzType.artisan: return Section.crafts; break;
//     case BzType.manufacturer: return Section.products; break;
//     case BzType.supplier: return Section.products; break;
//     default: return null;
//   }
// }
// -----------------------------------------------------------------------------
