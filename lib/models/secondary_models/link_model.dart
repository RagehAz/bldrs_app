import 'package:flutter/foundation.dart';

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
  static const LinkModel bldrsWebSiteLink = const LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsAppStoreLink = const LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static const LinkModel bldrsPlayStoreLink = const LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------


}
