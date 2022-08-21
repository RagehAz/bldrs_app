import 'package:flutter/foundation.dart';

@immutable
class SpecDeactivator {
// -----------------------------------------------------------------------------
  const SpecDeactivator({
    @required this.specValueThatDeactivatesSpecsLists,
    @required this.specsListsIDsToDeactivate,
  });
// -----------------------------------------------------------------------------
  final dynamic specValueThatDeactivatesSpecsLists;

  /// when this specValue is selected
  final List<String> specsListsIDsToDeactivate;

/// all lists with these listsIDs get deactivated
/// --------------------------------------------------------------------------
}
