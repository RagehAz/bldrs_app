import 'package:flutter/foundation.dart';

class LinkModel{
  final String url;
  final String description;

  const LinkModel({
    @required this.url,
    @required this.description,
  });

  Map<String, Object> toMap(){
    return {
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
