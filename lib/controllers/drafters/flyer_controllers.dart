import 'package:bldrs/models/sub_models/link_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
// ----------------------------------------------------------------------------
void shareFlyer (BuildContext context, LinkModel flyerLink) {
  final RenderBox box = context.findRenderObject();
  final String text = '${flyerLink.url} & ${flyerLink.description}';

  Share.share(
    text,
    subject: flyerLink.description,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
// ----------------------------------------------------------------------------
