import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/views/widgets/general/expansion_tiles/expanding_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTile extends StatelessWidget {
  final double bubbleWidth;
  final Section section;
  final bool inActiveMode;

  const SectionTile({
    @required this.bubbleWidth,
    @required this.section,
    @required this.inActiveMode,
  });
// -----------------------------------------------------------------------------
  String _sectionIcon({@required Section section, @required bool inActiveMode}){
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
  Future<void> _onSectionTap(BuildContext context) async {

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Section "${TextGenerator.sectionStringer(context, section)}" is\nTemporarily closed in $_currentCityID',
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
                  await Launch.shareLink(context, LinkModel.bldrsWebSiteLink);
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

      // /// B - close dialog
      // Nav.goBack(context);

    }


  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _tileWidth = bubbleWidth - (Ratioz.appBarMargin * 2);

    return AbsorbPointer(
      absorbing: inActiveMode == true ? true : false,
      child: Opacity(
        opacity: inActiveMode == true ? 0.6 : 1,
        child: ExpandingTile(
          // key: PageStorageKey<String>('fuck_you_bitch_mother_fucker'),
          width: _tileWidth,
          onTap: (bool isExpanded) async {
            print('on tap is tapped man : $isExpanded');

            if (isExpanded == true){

              await _onSectionTap(context);

            }
          },

          maxHeight: 150,
          icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
          iconSizeFactor: 0.4,
          initiallyExpanded: false,
          firstHeadline: TextGenerator.sectionStringer(context, section),
          secondHeadline: TextGenerator.sectionDescriptionStringer(context, section),
          scrollable: true,
          initialColor: Colorz.white20,
          // expansionColor: ExpandingTile.expandedColor,
          child: GestureDetector(
            onTap: () => _onSectionTap(context),
            child: Container(
              width: _tileWidth,
              height: 100,
              decoration: BoxDecoration(
                // color: Colorz.white10, // do no do this
                borderRadius: Borderers.superOneSideBorders(
                  context: context,
                  corner: ExpandingTile.cornersValue,
                  side: AxisDirection.down,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
