import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
// -----------------------------------------------------------------------------
class ShareModel{
  final List<dynamic> slideIndexes;
  final List<DateTime> timeStamps;
  // final String sharedTo;

  ShareModel({
  this.slideIndexes,
  this.timeStamps,
  // this.sharedTo,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return {
      'slideIndexes' : slideIndexes,
      'timeStamps' : Timers.cipherListOfDateTimes(timeStamps),
    };
  }
// -----------------------------------------------------------------------------
  static ShareModel decipherShareMap(Map<String, dynamic> map){
    return ShareModel(
      slideIndexes: map['slideIndexes'],
      timeStamps: Timers.decipherListOfDateTimesStrings(map['timeStamps']),
    );
}
// -----------------------------------------------------------------------------
  static ShareModel addToShareModel(ShareModel existingShareModel, int slideIndex){
    /// --- IF FLYER WAS NEVER SHARED
  if (existingShareModel == null){

    return ShareModel(
      slideIndexes: [slideIndex],
      timeStamps: [DateTime.now()],
    );

  } else {
  /// --- IF FLYER WAS SHARED BEFORE
    return
        ShareModel(
          slideIndexes: <int>[...existingShareModel.slideIndexes, slideIndex],
          timeStamps: <DateTime>[...existingShareModel.timeStamps, DateTime.now()]
        );
  }
}
// -----------------------------------------------------------------------------
  static Future<void> shareFlyer (BuildContext context, LinkModel flyerLink) async {
    final RenderBox box = context.findRenderObject();
    final String text = '${flyerLink.url} & ${flyerLink.description}';

    await Share.share(
      text,
      subject: flyerLink.description,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );


  }
// ----------------------------------------------------------------------------

}
// -----------------------------------------------------------------------------
class LinkModel{
  final String url;
  final String description;

  LinkModel({
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
  static LinkModel bldrsWebSiteLink = LinkModel(
    url: 'www.bldrs.net',
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static LinkModel bldrsAppStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------
  static LinkModel bldrsPlayStoreLink = LinkModel(
    url: 'www.google.com', // temp
    description: 'Download Bldrs.net App',
  );
// -----------------------------------------------------------------------------


}
