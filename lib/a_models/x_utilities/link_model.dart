import 'package:flutter/foundation.dart';

@immutable
class LinkModel{
  /// --------------------------------------------------------------------------
  const LinkModel({
    @required this.url,
    @required this.description,
  });
  /// --------------------------------------------------------------------------
  final String url;
  final String description;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  Map<String, Object> toMap(){
    return <String, Object>{
      'url' : url,
      'description' : description,
    };
  }
  // -----------------------------------------------------------------------------
}
