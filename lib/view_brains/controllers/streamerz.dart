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

Widget test(BuildContext context, Widget widget){

  final _user = Provider.of<UserModel>(context);

  return

    StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user.userID).userData,
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return LoadingFullScreenLayer();
        } else {
          UserModel userModel = snapshot.data; // cant use this date like this
          return
            widget;
        }
      },
    );

}
