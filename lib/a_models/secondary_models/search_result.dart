
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class SearchResult {
  /// --------------------------------------------------------------------------
  const SearchResult({
    @required this.title,
    // @required this.source,
    @required this.icon,
    @required this.flyers,
  });

  /// --------------------------------------------------------------------------
  final String title;
  // final SearchSource source;
  final String icon;
  final List<FlyerModel> flyers;

/// --------------------------------------------------------------------------
}

enum SearchSource {
  bzz,
  authors,
  flyerTitles,
  keywords,
}
