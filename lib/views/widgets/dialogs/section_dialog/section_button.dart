import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/records/share_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/zones/zone_provider.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionDialogButton extends StatelessWidget {
  final double dialogHeight;
  final Section section;
  final bool inActiveMode;

  SectionDialogButton({
    @required this.dialogHeight,
    @required this.section,
    @required this.inActiveMode,
});
// -----------------------------------------------------------------------------
  String _sectionIcon({Section section, bool inActiveMode}){
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
  Future<void> _onSectionTap({BuildContext context, FlyersProvider pro, Section section, bool inActiveMode}) async {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);
    String _currentProvince = _countryPro.currentZone.cityID;

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      await superDialog(
        context: context,
        title: 'Section "${TextGenerator.sectionStringer(context, section)}" is\nTemporarily closed in $_currentProvince',
        body: 'The Bldrs in $_currentProvince are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              DialogButton(
                verse: 'Inform a friend',
                width: 133,
                onTap: () => shareLink(context, LinkModel.bldrsWebSiteLink),
              ),

              DialogButton(
                verse: 'Go back',
                color: Colorz.Yellow255,
                verseColor: Colorz.Black230,
                onTap: () => Nav.goBack(context),
              ),

            ],
          ),
        ),
      );
    }

    /// A - if section is active
    else {
      await pro.changeSection(context, section);

      /// B - close dialog
      Nav.goBack(context);

    }


  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    FlyersProvider _pro =  Provider.of<FlyersProvider>(context, listen: true);

    return DreamBox(
      height: dialogHeight * 0.06,
      // width: _buttonWidth,
      icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
      verse: TextGenerator.sectionStringer(context, section),
      verseScaleFactor: 0.55,
      secondLine: TextGenerator.sectionDescriptionStringer(context, section),
      secondLineColor: Colorz.White200,
      margins: Ratioz.appBarPadding,
      inActiveMode: inActiveMode,
      onTap: () =>
          _onSectionTap(
              context: context,
              section: section,
              pro: _pro,
              inActiveMode: inActiveMode
          ),
    );
  }
}
