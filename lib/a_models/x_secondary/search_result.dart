import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:flutter/foundation.dart';

enum SearchSource {
  bzz,
  authors,
  flyerTitles,
  keywords,
}

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
