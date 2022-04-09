import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;

// -----------------------------------------------------------------------------
Future<void> onKeywordTap({
  @required BuildContext context,
  @required String phid,
  @required bool inActiveMode,
  @required FlyerType flyerType,
}) async {

  /// A - if section is not active * if user is author or not
  if (inActiveMode == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    final String _flyerTypeString = translateFlyerType(
        context: context,
        flyerType: flyerType
    );

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Section "$_flyerTypeString" is\nTemporarily closed in $_currentCityID',
      body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: 'Inform a friend',
            width: 133,
            onTap: () async {
              await Launcher.shareLink(context, LinkModel.bldrsWebSiteLink);
            },
          ),

          DialogButton(
            verse: 'Go back',
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(context),
          ),

        ],
      ),
    );
  }

  /// A - if section is active
  else {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);

    await _keywordsProvider.changeSection(
      context: context,
      section: flyerType,
      keywordID: phid,
    );

    /// B - close dialog
    Nav.goBack(context);
  }
}
// -----------------------------------------------------------------------------
String getSectionIcon({
  @required FlyerType section,
  @required bool inActiveMode
}){

  String _icon;

  if (inActiveMode == true) {
    _icon = Iconizer.flyerTypeIconOff(section);
  } else {
    _icon = Iconizer.flyerTypeIconOn(section);
  }

  return _icon;
}
// -----------------------------------------------------------------------------
