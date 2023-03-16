import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:devicer/devicer.dart';
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
        onConnectivityChanged: (bool isConnected) => GeneralProvider.onConnectivityChanged(
          context: context,
          isConnected: isConnected,
        ),
        builder: (bool connected, Widget child){

          return DreamBox(
              width: Ratioz.appBarButtonSize,
              height: Ratioz.appBarButtonSize,
              icon: connected == true ? Iconz.check : Iconz.xSmall,
              color: connected == true ? Colorz.green255 : Colorz.bloodTest,
              verseScaleFactor: 0.6,
              bubble: false,
              onTap: () async {
                // final bool _connected = await checkConnectivity();
                //
                // await _onConnectivityChanged(_connected);

                await TopDialog.showTopDialog(
                  context: context,
                  firstVerse: const Verse(id: 'phid_hello_there', translate: true),
                  secondVerse: const Verse(
                    pseudo: "Welcome to Bldrs.net the Builders' network",
                    id: 'phid_welcome_to_bldrs_net',
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
