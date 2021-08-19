import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef FlyerModelWidgetBuilder = Widget Function(
    BuildContext context,
    FlyerModel flyerModel,
    );
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
//             return Container(); // superDialog(context, snapshot.error, 'error');
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
// -----------------------------------------------------------------------------

/// get flyer doc stream
Stream<FlyerModel> getFlyerStream(String flyerID) {
  Stream<DocumentSnapshot> _flyerSnapshot = Fire.streamDoc(FireCollection.flyers, flyerID);
  Stream<FlyerModel> _flyerStream = _flyerSnapshot.map(FlyerModel.getFlyerModelFromSnapshot);
  return _flyerStream;
}
