import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
// -----------------------------------------------------------------------------

/// ALL BZZ PAGINATION

// --------------------
///
FireQueryModel allBzzPaginationQuery(){

  return FireQueryModel(
    collRef: Fire.getCollectionRef(FireColl.bzz),
    limit: 10,
    orderBy: const QueryOrderBy(fieldName: 'createdAt', descending: true),
  );

}
// -----------------------------------------------------------------------------
