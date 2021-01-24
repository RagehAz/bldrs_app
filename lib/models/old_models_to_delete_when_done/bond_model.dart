import 'package:bldrs/models/enums/enum_bond_state.dart';
import 'package:flutter/foundation.dart';

class BondModel {
  final String bondID;
  final String fromSlideID;
  final String toSlideID;
  final DateTime requestTime;
  final DateTime responseTime;
  final BondState bondState;

  BondModel({
    @required this.bondID,
    @required this.fromSlideID,
    @required this.toSlideID,
    @required this.requestTime,
    @required this.responseTime,
    @required this.bondState,
  });
}

