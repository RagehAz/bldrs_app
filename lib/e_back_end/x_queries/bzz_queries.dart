import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
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
