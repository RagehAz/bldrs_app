import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
/// IMPLEMENTATION
/// userStreamBuilder(
///         context: context,
///         listen: false,
///         builder: (context, UserModel userModel){
///           return WidgetThatUsesTheAboveUserModel;
///         }
///      ) xxxxxxxxxxxxx ; or , xxxxxxxxxxxxx
// -----------------------------------------------------------------------------
typedef UserModelWidgetBuilder = Widget Function(
    BuildContext context,
    UserModel userModel,
    );
// -----------------------------------------------------------------------------
/*
// Widget userStreamBuilder({
//   BuildContext context,
//   UserModelWidgetBuilder builder,
//   bool listen,
// }) {
//   final UsersProvider _usersProvider =
//       Provider.of<UsersProvider>(context, listen: listen);
//
//   return StreamBuilder<UserModel>(
//     stream: _usersProvider.myUserModelStream,
//     builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
//       if (StreamChecker.connectionIsLoading(snapshot) == true) {
//         return const Loading(
//           loading: true,
//         );
//       } else {
//         final UserModel userModel = snapshot.data;
//         return builder(context, userModel);
//       }
//     },
//   );
// }
 */
// -----------------------------------------------------------------------------
Widget userModelBuilder({
  String userID,
  BuildContext context,
  UserModelWidgetBuilder builder,
}) {
  return FutureBuilder<Map<String, dynamic>>(
      future: OfficialFire.readDoc(
        collName: FireColl.users,
        docName: userID,
      ),
      builder: (BuildContext ctx, AsyncSnapshot<Object> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading(
            loading: true,
          );
        }

        else if (snapshot.error != null) {
          return const SizedBox(); // superDialog(context, snapshot.error, 'error');
        }

        else {
          final Map<String, dynamic> _map = snapshot.data;
          final UserModel userModel = UserModel.decipherUser(
            map: _map,
            fromJSON: false,
          );

          return builder(context, userModel);
        }

      });
}
// -----------------------------------------------------------------------------
