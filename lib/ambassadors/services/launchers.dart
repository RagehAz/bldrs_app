import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/link_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
// ---------------------------------------------------------------------------
void launchURL(link) async {
  // should make a condition
  // if it starts with http:// or not
  // then do whats necessary, as the link should include http://
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('Can Not launch link');
  }
}
// ---------------------------------------------------------------------------
void launchCall(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  }else{
    print('cant call');
  }
}
// ---------------------------------------------------------------------------
void shareLink (BuildContext context, LinkModel link) {
  final RenderBox box = context.findRenderObject();
  // final String url = '${flyerLink.url} & ${flyerLink.description}';

  Share.share(
    link.url,
    subject: link.description,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}

