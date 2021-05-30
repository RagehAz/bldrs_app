import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_model.dart';
import 'package:flutter/foundation.dart';

class FilterModel {
  final String id;
  final String name;
  final List<KeywordModel> keywords;
  final bool canPickMany;

  FilterModel({
    @required this.id,
    @required this.name,
    @required this.keywords,
    @required this.canPickMany,
  });

// static const FilterModel propertyType =
// FilterModel(id: null, name: null, keywords: null, canPickMany: null)

}