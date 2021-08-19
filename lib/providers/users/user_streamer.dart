import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/users/users_provider.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        if(StreamChecker.connectionIsLoading(snapshot) == true){
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
      future: Fire.readDoc(
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
