import 'package:bldrs/controllers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/controllers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/controllers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionDialogButton extends StatelessWidget {
  final double dialogHeight;
  final SectionClass.Section section;
  final bool inActiveMode;

  const SectionDialogButton({
    @required this.dialogHeight,
    @required this.section,
    @required this.inActiveMode,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  String _sectionIcon({SectionClass.Section section, bool inActiveMode}){
    String _icon;

    if (inActiveMode == true){
      _icon = Iconizer.sectionIconOff(section);
    }
    else {
      _icon = Iconizer.sectionIconOn(section);
    }

    return _icon;
  }
// -----------------------------------------------------------------------------
  Future<void> _onSectionTap({BuildContext context, SectionClass.Section section, bool inActiveMode}) async {

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Section "${TextGen.sectionStringer(context, section)}" is\nTemporarily closed in $_currentCityID',
        body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
        ),
      );
    }

    /// A - if section is active
    else {
      await _generalProvider.changeSection(context, section);

      /// B - close dialog
      Nav.goBack(context);

    }


  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: dialogHeight * 0.06,
      // width: _buttonWidth,
      icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
      verse: TextGen.sectionStringer(context, section),
      verseScaleFactor: 0.55,
      secondLine: TextGen.sectionDescriptionStringer(context, section),
      secondLineColor: Colorz.white200,
      margins: Ratioz.appBarPadding,
      inActiveMode: inActiveMode,
      onTap: () =>
          _onSectionTap(
              context: context,
              section: section,
              inActiveMode: inActiveMode
          ),
    );
  }
}
