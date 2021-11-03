import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/user_provider.dart';
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

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);

  return

    StreamBuilder<UserModel>(
      stream: _usersProvider.myUserModelStream,
      builder: (context, snapshot){
        if(StreamChecker.connectionIsLoading(snapshot) == true){
          return const Loading(loading: true,);
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
        collName: FireColl.users,
        docName: userID,
      ),
      builder: (ctx, snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Loading(loading: true,);
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
