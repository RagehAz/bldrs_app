import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/connectivity_sensor.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class IsConnectedButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const IsConnectedButton({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ConnectivitySensor(
        builder: (bool connected, Widget child){

          return DreamBox(
              width: Ratioz.appBarButtonSize,
              height: Ratioz.appBarButtonSize,
              icon: connected ? Iconz.check : Iconz.xSmall,
              color: connected ? Colorz.green255 : Colorz.bloodTest,
              verseScaleFactor: 0.6,
              bubble: false,
              onTap: () async {
                // final bool _connected = await checkConnectivity();
                //
                // await _onConnectivityChanged(_connected);

                TopDialog.showUnawaitedTopDialog(
                  context: context,
                  firstLine: const Verse(text: 'phid_hello_there', translate: true),
                  secondLine: const Verse(
                    pseudo: "Welcome to Bldrs.net the Builders' network",
                    text: 'phid_welcome_to_bldrs_net',
                    translate: true,
                  ),
                  // color: Colorz.red50,
                );

              }
          );
        }
    );

  }
}
