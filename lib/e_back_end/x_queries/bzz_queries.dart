import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/fire.dart';
// -----------------------------------------------------------------------------

/// ALL BZZ PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel allBzzPaginationQuery(){

  return FireQueryModel(
    collRef: Fire.getCollectionRef(FireColl.bzz),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'createdAt', descending: true),
  );

}
// -----------------------------------------------------------------------------
