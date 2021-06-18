import 'package:bldrs/xxx_LABORATORY/flyer_browser/keyword_model.dart';
import 'package:flutter/foundation.dart';

class FilterModel {
  final String id;
  final String name;
  // final List<KeywordModel> keywords;
  final bool canPickMany;

  FilterModel({
    @required this.id,
    @required this.name,
    // @required this.keywords,
    @required this.canPickMany,
  });

// static const FilterModel propertyType =
// FilterModel(id: null, name: null, keywords: null, canPickMany: null)

}


class Keyword {
  final String id;

  final String filterID; //<filter>
  final String group;
  final String subGroup;

  /// this filterID is to be added to the list of filters when adding the keyword
  final String addsFilterID; //<filter>

  /// list of keywordsIDs from  another filter that exclusively activate this
  /// keyword in the lists of a filter's keywords
  ///
  /// like 'Furniture / Chairs / Dining Chairs' is only included with ['Space/Dining room']
  /// while 'Furniture / Chairs / High Chairs' will be included in both ['Space/Dining room', 'Space/Kitchen']
  ///
  /// and may be ['Space/all'] when activated by all keywords in a group or sub-group
  /// and will be null if no keyword impacts it
  final List<String> isActiveWith;

  final int usage;

  Keyword({
    @required this.id,

    @required this.filterID,
    @required this.group,
    @required this.subGroup,

    @required this.addsFilterID,
    @required this.isActiveWith,

    @required this.usage,
  });
}