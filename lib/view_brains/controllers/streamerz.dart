import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ----------------------------------------------------------------------------
/// this page has all functions that are related to streams & device connectivity
// ----------------------------------------------------------------------------
bool connectionIsWaiting(AsyncSnapshot<dynamic> snapshot){
  return
    snapshot.connectionState == ConnectionState.waiting? true : false;
}
// ----------------------------------------------------------------------------
bool connectionHasNoData(AsyncSnapshot<dynamic> snapshot){
  return
      snapshot.hasData == false ? true : false;
}
// ----------------------------------------------------------------------------
bool userModelIsLoading(UserModel userModel){
  return
      userModel == null ? true : false;
}
// ----------------------------------------------------------------------------
typedef userModelWidgetBuilder = Widget Function(
    BuildContext context,
    UserModel userModel,
    );
// ----------------------------------------------------------------------------
/// IMPLEMENTATION
/// userStreamBuilder(
///         context: context,
///         listen: false,
///         builder: (context, UserModel userModel){
///           return WidgetThatUsesTheAboveUserModel;
///         }
///      ),
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
          return Loading();
        } else {
          UserModel userModel = snapshot.data;
          return
            builder(context, userModel);
        }
      },
    );

}
// ----------------------------------------------------------------------------
