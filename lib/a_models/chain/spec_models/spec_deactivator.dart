import 'package:flutter/foundation.dart';

class SpecDeactivator {
  /// --------------------------------------------------------------------------
  SpecDeactivator({
    @required this.specValue,
    @required this.specsListsIDsToDeactivate,
  });

  /// --------------------------------------------------------------------------
  final String specValue;

  /// when this specValue is selected
  final List<String> specsListsIDsToDeactivate;

/// all lists with these listsIDs get deactivated
/// --------------------------------------------------------------------------
}
