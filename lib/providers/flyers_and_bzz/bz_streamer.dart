
// -----------------------------------------------------------------------------
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

typedef bzModelWidgetBuilder = Widget Function(
    BuildContext context,
    BzModel bzModel,
    );
// -----------------------------------------------------------------------------
Widget bzModelStreamBuilder({
  String bzID,
  BuildContext context,
  bzModelWidgetBuilder builder,
}){

  return

    StreamBuilder<BzModel>(
      stream: getBzStream(bzID),
      builder: (context, snapshot){
        if(StreamChecker.connectionIsLoading(snapshot) == true){
          return Loading(loading: true,);
        } else {
          final BzModel bzModel = snapshot.data;
          return
            builder(context, bzModel);
        }
      },
    );

}
// -----------------------------------------------------------------------------
Widget bzModelBuilder({
  String bzID,
  BuildContext context,
  bzModelWidgetBuilder builder,
}){

  return FutureBuilder(
      future: Fire.readDoc(
        context: context,
        collName: FireCollection.bzz,
        docName: bzID,
      ),
      builder: (ctx, snapshot){


        if (snapshot.connectionState == ConnectionState.waiting){
          return Container();
        } else {
          if (snapshot.error != null){
            return Container(); // superDialog(context, snapshot.error, 'error');
          } else {

            final Map<String, dynamic> _map = snapshot.data;
            final BzModel bzModel = BzModel.decipherBzMap(_map);

            return builder(context, bzModel);
          }
        }
      }
  );
}
// -----------------------------------------------------------------------------
typedef tinyBzModelWidgetBuilder = Widget Function(
    BuildContext context,
    TinyBz tinyBz,
    );
// ----------------------
/// IMPLEMENTATION
/// bzModelBuilder(
///         bzID: bzID,
///         context: context,
///         builder: (context, BzModel bzModel){
///           return WidgetThatUsesTheAboveBzModel;
///         }
///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
Widget tinyBzModelStreamBuilder({
  String bzID,
  BuildContext context,
  tinyBzModelWidgetBuilder builder,
  bool listen,
}){

  // bool _listen = listen == null ? true : listen;

  return

    StreamBuilder<TinyBz>(
      stream: getTinyBzStream(bzID),
      builder: (context, snapshot){
        if(StreamChecker.connectionIsLoading(snapshot) == true){
          return Loading(loading: true,);
        } else {
          final TinyBz tinyBz = snapshot.data;
          return
            builder(context, tinyBz);
        }
      },
    );

}
// -----------------------------------------------------------------------------
Widget tinyBzModelBuilder({
  String bzID,
  BuildContext context,
  tinyBzModelWidgetBuilder builder,
}){

  return FutureBuilder(
      future: Fire.readDoc(
        context: context,
        collName: FireCollection.tinyBzz,
        docName: bzID,
      ),
      builder: (ctx, snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return Loading(loading: true,);
        } else {
          if (snapshot.error != null){
            return Container(); // superDialog(context, snapshot.error, 'error');
          } else {

            final Map<String, dynamic> _map = snapshot.data;
            final TinyBz tinyBz = TinyBz.decipherTinyBzMap(_map);

            return builder(context, tinyBz);
          }
        }
      }
  );
}
// -----------------------------------------------------------------------------
/// get bz doc stream
Stream<BzModel> getBzStream(String bzID) {
  final Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireCollection.bzz, bzID);
  final Stream<BzModel> _bzStream = _bzSnapshot.map(BzModel.getBzModelFromSnapshot);
  return _bzStream;
}
// -----------------------------------------------------------------------------
/// get bz doc stream
Stream<TinyBz> getTinyBzStream(String bzID) {
  final Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireCollection.tinyBzz, bzID);
  final Stream<TinyBz> _tinyBzStream = _bzSnapshot.map(TinyBz.getTinyBzModelFromSnapshot);
  return _tinyBzStream;
}
// -----------------------------------------------------------------------------
