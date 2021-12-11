import 'package:bldrs/helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/helpers/router/navigators.dart' as Nav;
import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/ratioz.dart';
import 'package:bldrs/models/kw/chain/chain.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/kw/section_class.dart' as SectionClass;
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/widgets/general/chain_expander/chain_expander.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionTile({
    @required this.bubbleWidth,
    @required this.section,
    @required this.inActiveMode,
    @required this.chain,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final SectionClass.Section section;
  final bool inActiveMode;
  final Chain chain;
  /// --------------------------------------------------------------------------
  String _sectionIcon({@required SectionClass.Section section, @required bool inActiveMode}){
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
  Future<void> _onKeywordTap(BuildContext context, KW kw) async {

    /// A - if section is not active * if user is author or not
    if(inActiveMode == true){

      final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: false);
      final String _currentCityID = _zoneProvider.currentZone.cityID;

      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Section "${TextGen.sectionStringer(context, section)}" is\nTemporarily closed in $_currentCityID',
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

      final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);

      await _generalProvider.changeSection(
        context: context,
        section: section,
        kw: kw,
      );

      /// B - close dialog
      Nav.goBack(context);

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
        key: PageStorageKey<String>(section.toString()),
        chain: chain,
        width: _tileWidth,
        // onTap: (bool isExpanded) => _onKeywordTap(context, isExpanded),
        icon: _sectionIcon(section: section, inActiveMode: inActiveMode),
        firstHeadline: TextGen.sectionStringer(context, section),
        secondHeadline: TextGen.sectionDescriptionStringer(context, section),
        inActiveMode: inActiveMode,
        onKeywordTap: (KW kw) => _onKeywordTap(context, kw),
      );

  }
}
