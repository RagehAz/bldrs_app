import 'package:bldrs/controllers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/section_class.dart';
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/chain_expander/chain_expander.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTile extends StatelessWidget {
  final double bubbleWidth;
  final Section section;
  final bool inActiveMode;
  final Chain chain;

  const SectionTile({
    @required this.bubbleWidth,
    @required this.section,
    @required this.inActiveMode,
    @required this.chain,
    Key key,
  }) : super(key: key);
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
  Future<void> _onSectionTap(BuildContext context, bool isExpanded) async {

    print('_onSectionTap : isExpanded : $isExpanded');

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Section "${TextGen.sectionStringer(context, section)}" is\nTemporarily closed in $_currentCityID',
        body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        height: 400,
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
    // final double _itemWidth = _tileWidth - (Ratioz.appBarMargin * 2);

    // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
    // final Section _currentSection = _generalProvider.currentSection;

    // final List<Sequence> _sequences = Sequence.getActiveSequencesBySection(context: context,section: section);

    return
      ChainExpander(
        chain: chain,
        width: _tileWidth,
        onTap: (bool isExpanded) => _onSectionTap(context, isExpanded),
        icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
        firstHeadline: TextGen.sectionStringer(context, section),
        secondHeadline: TextGen.sectionDescriptionStringer(context, section),
        inActiveMode: inActiveMode,
        key: PageStorageKey<String>('${section.toString()}'),
      );

  }
}
