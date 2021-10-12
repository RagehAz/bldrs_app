import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/users/old_user_provider.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// IMPLEMENTATION
/// userStreamBuilder(
///         context: context,
///         listen: false,
///         builder: (context, UserModel userModel){
///           return WidgetThatUsesTheAboveUserModel;
///         }
///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
// -----------------------------------------------------------------------------
typedef userModelWidgetBuilder = Widget Function(
    BuildContext context,
    UserModel userModel,
    );
// -----------------------------------------------------------------------------
Widget userStreamBuilder({
  BuildContext context,
  userModelWidgetBuilder builder,
  bool listen,
}){

  final _user = Provider.of<UserModel>(context, listen: listen);

  return

    StreamBuilder<UserModel>(
      stream: OldUserProvider(userID: _user?.userID)?.userData,
      builder: (context, snapshot){
        if(StreamChecker.connectionIsLoading(snapshot) == true){
          return Loading(loading: true,);
        } else {
          final UserModel userModel = snapshot.data;
          return
            builder(context, userModel);
        }
      },
    );

}
// -----------------------------------------------------------------------------
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

          final Map<String, dynamic> _map = snapshot.data;
          final UserModel userModel = UserModel.decipherUserMap(
            map: _map,
            fromJSON: false,
          );

          return builder(context, userModel);
        }
      }

  );
}
// -----------------------------------------------------------------------------
typedef tinyUserModelWidgetBuilder = Widget Function(
    BuildContext context,
    TinyUser tinyUser,
    );
// -----------------------------------------------------------------------------
Widget tinyUserModelBuilder({
  String userID,
  BuildContext context,
  tinyUserModelWidgetBuilder builder,
}){

  return FutureBuilder(
      future: Fire.readDoc(
        context: context,
        collName: FireCollection.tinyUsers,
        docName: userID,
      ),
      builder: (ctx, snapshot){

        if (StreamChecker.connectionIsLoading(snapshot) == true){
          return Loading(loading: true,);
        }

        else {

          final Map<String, dynamic> _map = snapshot.data;
          final TinyUser tinyUser = TinyUser.decipherTinyUserMap(_map);

          return builder(context, tinyUser);
        }
      }

  );
}
// -----------------------------------------------------------------------------
