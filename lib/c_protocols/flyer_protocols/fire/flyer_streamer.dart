import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:fire/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:filers/filers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
typedef FlyerModelWidgetBuilder = Widget Function(
    BuildContext context,
    FlyerModel flyerModel,
    );
// --------------------
/*
// Widget flyerStreamBuilder({
//   TinyFlyer tinyFlyer,
//   BuildContext context,
//   FlyerModelWidgetBuilder builder,
//   double flyerSizeFactor,
//   bool listen,
// }){
//
//   bool _listen = listen == null ? true : listen;
//
//   final _prof = Provider.of<FlyersProvider>(context, listen: _listen);
//
//   return
//
//     StreamBuilder<FlyerModel>(
//       stream: _prof.getFlyerStream(tinyFlyer.flyerID),
//       builder: (context, snapshot){
//
//         SuperFlyer _superFlyer = SuperFlyer.
//
//         if(connectionHasNoData(snapshot) || connectionIsWaiting(snapshot)){
//           return
//             //Loading(loading: true,);
//
//             TinyFlyerWidget(
//               superFlyer: _superFlyer,
//               // tinyFlyer: tinyFlyer,
//               // flyerSizeFactor: flyerSizeFactor,
//               // onTap: (){},
//             );
//
//         } else {
//           FlyerModel flyerModel = snapshot.data;
//           return
//             builder(context, flyerModel);
//         }
//       },
//     );
//
// }
 */
// --------------------
/*
// Widget flyerModelBuilder({
//   TinyFlyer tinyFlyer,
//   BuildContext context,
//   FlyerModelWidgetBuilder builder,
//   double flyerSizeFactor,
// }){
//
//   return FutureBuilder(
//       future: Fire.readDoc(
//         context: context,
//         collName: FireCollection.flyers,
//         docName: tinyFlyer.flyerID,
//       ),
//       builder: (ctx, snapshot){
//
//         if (snapshot.connectionState == ConnectionState.waiting){
//           return
//             TinyFlyerWidget(
//               tinyFlyer: tinyFlyer,
//               flyerSizeFactor: flyerSizeFactor,
//               onTap: (){},
//             );
//
//         } else {
//           if (snapshot.error != null){
//             return const SizedBox();; // superDialog(context, snapshot.error, 'error');
//           } else {
//
//             Map<String, dynamic> _map = snapshot.data;
//             FlyerModel flyerModel = FlyerModel.decipherFlyerMap(_map);
//
//             return builder(context, flyerModel);
//           }
//         }
//       }
//   );
// }
 */
// --------------------
/// get flyer doc stream
Stream<FlyerModel> getFlyerStream(String flyerID) {

  final Stream<DocumentSnapshot<Object>> _flyerSnapshot = Fire.streamDoc(
    collName: FireColl.flyers,
    docName: flyerID,
  );

  final Stream<FlyerModel> _flyerStream = _flyerSnapshot.map(
      FlyerModel.getFlyerModelFromSnapshot
  );

  return _flyerStream;
}
// --------------------
/// get flyer doc stream
Stream<List<ReviewModel>> getFlyerReviewsStream(String flyerID) {

  // final Stream<QuerySnapshot<Object>> _reviewsStream = Fire.streamSubCollection(
  //   collName: FireColl.flyers,
  //   docName: flyerID,
  //   subCollName: FireSubColl.flyers_flyer_reviews,
  //   descending: true,
  //   orderBy: 'time',
  // );
  //
  // // blog('getFlyerReviewsStream : _reviewsStream : $_reviewsStream');
  // //
  // final Stream<List<ReviewModel>> _reviews =
  //     _reviewsStream.map((QuerySnapshot<Object> qShot) => qShot.docs
  //         .map((QueryDocumentSnapshot<Object> doc) => ReviewModel(
  //               userID: doc['userID'],
  //               time: Timers.decipherTime(time: doc['time'], fromJSON: false),
  //               body: doc['body'],
  //               reviewID: doc.id,
  //             ))
  //         .toList());
  // //
  // // blog('getFlyerReviewsStream : _reviews : ${_reviews.length}');

  return null;
}
// -----------------------------------------------------------------------------
typedef ReviewModelsWidgetsBuilder = Widget Function(
    BuildContext context,
    List<ReviewModel> reviews,
    );
// --------------------
Widget reviewsStreamBuilder({
  BuildContext context,
  ReviewModelsWidgetsBuilder builder,
  String flyerID,
}) {
  return StreamBuilder<List<ReviewModel>>(
    key: const ValueKey<String>('reviews_stream_builder'),
    stream: getFlyerReviewsStream(flyerID),
    builder: (BuildContext context, AsyncSnapshot<List<ReviewModel>> snapshot) {
      blog('reviewsStreamBuilder : snapshot is : $snapshot');

      if (Streamer.connectionIsLoading(snapshot) == true) {
        return const Loading(
          loading: true,
        );
      } else {
        final List<ReviewModel> reviews = snapshot?.data;

        return builder(context, reviews);
      }
    },
  );
}
// -----------------------------------------------------------------------------
