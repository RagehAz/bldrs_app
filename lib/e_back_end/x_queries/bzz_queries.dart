import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/super_fire/super_fire.dart';
// -----------------------------------------------------------------------------

/// ALL BZZ PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel allBzzPaginationQuery(){

  return const FireQueryModel(
    coll: FireColl.bzz,
    limit: 10,
    orderBy: QueryOrderBy(fieldName: 'createdAt', descending: true),
  );

}
// -----------------------------------------------------------------------------
