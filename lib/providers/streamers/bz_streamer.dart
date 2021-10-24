import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
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

          print('xx bzModel in  stream is : $bzModel');

          bzModel.printBzModel();


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
        collName: FireColl.bzz,
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
            final BzModel bzModel = BzModel.decipherBzMap(
              map: _map,
              fromJSON: false,
            );

            return builder(context, bzModel);
          }
        }
      }
  );
}
// -----------------------------------------------------------------------------
/// get bz doc stream
Stream<BzModel> getBzStream(String bzID) {
  final Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireColl.bzz, bzID);
  final Stream<BzModel> _bzStream = _bzSnapshot.map(BzModel.getBzModelFromSnapshot);

  return _bzStream;
}
// -----------------------------------------------------------------------------
