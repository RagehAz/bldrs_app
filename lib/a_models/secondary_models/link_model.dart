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
  /// --------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return <String, Object>{
      'url' : url,
      'description' : description,
    };
  }

// -----------------------------------------------------------------------------
  static const LinkModel bldrsWebSiteLink = LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsAppStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsPlayStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------


}
