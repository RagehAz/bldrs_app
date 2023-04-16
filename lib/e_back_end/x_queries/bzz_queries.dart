import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
// -----------------------------------------------------------------------------

/// ALL BZZ PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel allBzzPaginationQuery(){

  return FireQueryModel(
    collRef: OfficialFire.getCollectionRef(FireColl.bzz),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'createdAt', descending: true),
  );

}
// -----------------------------------------------------------------------------
