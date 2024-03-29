import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:basics/helpers/checks/errorize.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/foundation.dart';

const bool reportingIsOn = false;
/// --------------------------------------------------------------------------
Future<void> reportThis(String text) async {

    if (kDebugMode == true && reportingIsOn == true){
      await Dialogs.centerNotice(
        verse: Verse.plain('Debug Report'),
        body: Verse.plain(text),
        color: Colorz.red255,
      );
    }

}
/// --------------------------------------------------------------------------
Future<void> throwStandardError({
  required String invoker,
  required String? error,
}) async {

    final String _errorMessage = error ?? getWord('phid_something_went_wrong_error');
    final DeviceModel _device = await DeviceModel.generateDeviceModel();
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false
    );

    await Errorize.throwMap(
        invoker: 'Standard Error ($invoker)',
        map: {
          'userID': _userModel?.id,
          'userName': _userModel?.name,
          'userEmail': UserModel.getUserEmail(_userModel),
          'userLastSignIn': Timers.cipherTime(time: Authing.getMyLastSignIn(), toJSON: false),
          'signInMethod': _userModel?.signInMethod,
          'zone': _userModel?.zone?.toMap(),
          'appState': _userModel?.appState?.toMap(toUserModel: true),
          'device': _device.toMap(),
          'deviceOS': DeviceChecker.getDeviceOS(),
          'errorInvoker': invoker,
          'errorTime': Timers.cipherTime(time: DateTime.now(), toJSON: false),
          'error': error,
          'errorMessage': _errorMessage,
        },
    );

}
/// --------------------------------------------------------------------------
