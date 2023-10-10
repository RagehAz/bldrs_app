import 'package:basics/helpers/widgets/sensors/app_version_builder.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/main_providers/general_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class AppStateProtocols {
  // -----------------------------------------------------------------------------

  const AppStateProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<AppStateModel?> fetchGlobalAppState() async {

    final BuildContext context = getMainContext();

    AppStateModel? _globalAppState = GeneralProvider.proGetGlobalAppState(
      context: context,
      listen: false,
    );

    _globalAppState ??= await AppStateFireOps.readGlobalAppState();

    GeneralProvider.proSetGlobalAppState(
      state: _globalAppState,
      context: context,
    );

    // blog('FETCHING GLOBAL APP STATE AHO : $_globalAppState');

    return _globalAppState;
  }
  // -----------------------------------------------------------------------------

  /// CHECK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> shouldUpdateApp() async {

    final AppStateModel? _globalState = await AppStateProtocols.fetchGlobalAppState();

    final String _detectedAppVersion = await AppVersionBuilder.detectAppVersion();

    final bool _userNeedToUpdateTheApp = AppVersionBuilder.versionIsBigger(
      thisIsBigger: _globalState?.appVersion,
      thanThis: _detectedAppVersion,
    );

    return _userNeedToUpdateTheApp;
  }
  // -----------------------------------------------------------------------------
}
