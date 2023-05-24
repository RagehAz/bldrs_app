import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class ZoneFilterTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ZoneFilterTile({
    @required this.searchModel,
    @required this.onTileTap,
    @required this.onSwitchTap,
    Key key
  }) : super(key: key);
  // --------------------
  final SearchModel searchModel;
  final Function onTileTap;
  final Function(bool) onSwitchTap;
  // -----------------------------------------------------------------------------
  static Verse getZoneVerse({
    @required BuildContext context,
    @required ZoneModel zoneModel,
  }) {

    final Verse _headline = zoneModel == null ?
    const Verse(id: 'phid_the_entire_world', translate: true)
        :
    ZoneModel.generateInZoneVerse(
            context: context,
            zoneModel: zoneModel,
          );

    return _headline;
  }
  // --------------------
  static String getZoneIcon({
    @required ZoneModel zoneModel,
  }){

    if (zoneModel == null){
      return Iconz.contAfrica;
    }

    else {
      return zoneModel.icon ?? Flag.getCountryIcon(zoneModel?.countryID);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    final Verse _headline = getZoneVerse(
      context: context,
      zoneModel: searchModel.zone,
    );

    return TileBubble(
      bubbleWidth: _tileWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          leadingIcon: getZoneIcon(
            zoneModel: searchModel.zone,
          ),
          headerWidth: _tileWidth,
          headlineVerse: _headline,
          hasSwitch: true, //UsersProvider.userIsAdmin(context),
          switchValue: searchModel.zone != null,
          onSwitchTap: onSwitchTap
      ),
      onTileTap: onTileTap,
    );

  }
  // -----------------------------------------------------------------------------
}
