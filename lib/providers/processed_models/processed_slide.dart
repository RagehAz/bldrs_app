import 'package:bldrs/models/bond_model.dart';
import 'package:bldrs/models/origin_model.dart';
import 'package:flutter/foundation.dart';

class ProcessedSlideData {
  final String flyerID;
  final String slideID;
  final int slideIndex;
  final String picture;
  final String headline;
  final String description;
  final List<OriginModel> origins;
  int calls;
  int shares;
  int horuses;
  int saves;
  final List<BondModel> bonds;

  ProcessedSlideData({
    @required this.flyerID,
    @required this.slideID,
    @required this.slideIndex,
    @required this.picture,
    @required this.headline,
    this.description,
    this.origins,
    @required this.calls,
    @required this.shares,
    @required this.horuses,
    @required this.saves,
    this.bonds,
});

}