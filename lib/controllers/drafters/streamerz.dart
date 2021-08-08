import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
/// this page has all functions that are related to streams & device connectivity
// -----------------------------------------------------------------------------
bool connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){
  return
    snapshot.connectionState == ConnectionState.waiting? true : false;
}
// -----------------------------------------------------------------------------
bool connectionHasNoData(AsyncSnapshot<dynamic> snapshot){
  return
      snapshot.hasData == false ? true : false;
}
// -----------------------------------------------------------------------------
bool userModelIsLoading(UserModel userModel){
  return
      userModel == null ? true : false;
}
// -----------------------------------------------------------------------------
typedef userModelWidgetBuilder = Widget Function(
    BuildContext context,
    UserModel userModel,
    );
// ----------------------
/// IMPLEMENTATION
/// userStreamBuilder(
///         context: context,
///         listen: false,
///         builder: (context, UserModel userModel){
///           return WidgetThatUsesTheAboveUserModel;
///         }
///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
Widget userStreamBuilder({
  BuildContext context,
  userModelWidgetBuilder builder,
  bool listen,
}){

  final _user = Provider.of<UserModel>(context, listen: listen);

  return

    StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user?.userID)?.userData,
      builder: (context, snapshot){
        if(connectionHasNoData(snapshot) || connectionIsWaiting(snapshot)){
          return Loading(loading: true,);
        } else {
          UserModel userModel = snapshot.data;
          return
            builder(context, userModel);
        }
      },
    );

}
// ----------------------
/// IMPLEMENTATION
/// bzModelBuilder(
///         bzID: bzID,
///         context: context,
///         builder: (context, BzModel bzModel){
///           return WidgetThatUsesTheAboveBzModel;
///         }
///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
Widget userModelBuilder({
  String userID,
  BuildContext context,
  userModelWidgetBuilder builder,
}){

  return FutureBuilder(
      future: Fire().readDoc(
        context: context,
        collName: FireCollection.users,
        docName: userID,
      ),
      builder: (ctx, snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return Loading(loading: true,);
        } else if (snapshot.error != null){
            return Container(); // superDialog(context, snapshot.error, 'error');
          } else {

            Map<String, dynamic> _map = snapshot.data;
            UserModel userModel = UserModel.decipherUserMap(_map);

            return builder(context, userModel);
          }
        }

  );
}
// -----------------------------------------------------------------------------
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

  final _prof = Provider.of<FlyersProvider>(context, listen: true);

  return

    StreamBuilder<BzModel>(
      stream: _prof.getBzStream(bzID),
      builder: (context, snapshot){
        if(connectionHasNoData(snapshot) || connectionIsWaiting(snapshot)){
          return Loading(loading: true,);
        } else {
          BzModel bzModel = snapshot.data;
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
      future: Fire().readDoc(
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

            Map<String, dynamic> _map = snapshot.data;
            BzModel bzModel = BzModel.decipherBzMap(_map);

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

  bool _listen = listen == null ? true : listen;

  final _prof = Provider.of<FlyersProvider>(context, listen: _listen);

  return

    StreamBuilder<TinyBz>(
      stream: _prof.getTinyBzStream(bzID),
      builder: (context, snapshot){
        if(connectionHasNoData(snapshot) || connectionIsWaiting(snapshot)){
          return Loading(loading: true,);
        } else {
          TinyBz tinyBz = snapshot.data;
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
      future: Fire().readDoc(
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

            Map<String, dynamic> _map = snapshot.data;
            TinyBz tinyBz = TinyBz.decipherTinyBzMap(_map);

            return builder(context, tinyBz);
          }
        }
      }
  );
}
// -----------------------------------------------------------------------------
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
//       future: Fire().readDoc(
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

