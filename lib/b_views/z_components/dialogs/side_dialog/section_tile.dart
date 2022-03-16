import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/b_views/z_components/chain_expander/chain_expander.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionTile extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SectionTile({
    @required this.bubbleWidth,
    @required this.flyerType,
    @required this.inActiveMode,
    @required this.chain,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double bubbleWidth;
  final FlyerType flyerType;
  final bool inActiveMode;
  final Chain chain;
  /// --------------------------------------------------------------------------
  String _sectionIcon({
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
  Future<void> _onKeywordTap(BuildContext context, KW kw) async {

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

      final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

      await _keywordsProvider.changeSection(
        context: context,
        section: flyerType,
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



    return ChainExpander(
      key: PageStorageKey<String>(flyerType.toString()),
      chain: chain,
      width: _tileWidth,
      // onTap: (bool isExpanded) => _onKeywordTap(context, isExpanded),
      icon: _sectionIcon(section: flyerType, inActiveMode: inActiveMode),
      firstHeadline: translateFlyerType(
        context: context,
        flyerType: flyerType,
      ),
      secondHeadline: TextGen.flyerTypeDescriptionStringer(context, flyerType),
      inActiveMode: inActiveMode,
      onKeywordTap: (KW kw) => _onKeywordTap(context, kw),
    );

  }
}
