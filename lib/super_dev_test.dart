
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';

/// SUPER_DEV_TEST
Future<void> superDevTest() async {

  final AppStateModel? _global = await AppStateProtocols.fetchGlobalAppState();

  if (_global != null){

    await Fire.createDoc(
        coll: FireColl.admin,
        doc: FireDoc.admin_appState,
        input: _global.toMap(toUserModel: false),
    );

    await Dialogs.topNotice(verse: Verse.plain('Tamam'));

  }

  // final List<Map<String, dynamic>> _maps = await Fire.readAllColl(coll: FireColl.users);
  //
  // for (final Map<String, dynamic> map in _maps){
  //
  //   final UserModel? _user = UserModel.decipherUser(map: map, fromJSON: false);
  //
  //   if (_user != null){
  //
  //     final AppStateModel? _newState = _user.appState?.copyWith(
  //       appVersion: '0.0.0',
  //       ldbVersion: 0,
  //       // minVersion: '1.4.0',
  //       // bldrsIsOnline: true,
  //     );
  //
  //     if (_newState != null){
  //
  //       final UserModel _new = _user.copyWith(
  //         appState: _newState,
  //       );
  //
  //       await UserFireOps.updateUser(
  //           oldUser: _user,
  //           newUser: _new,
  //       );
  //
  //       blog('tamam with ${_user.id} : ${_user.name}');
  //
  //     }
  //
  //   }
  //
  // }
  //


}
