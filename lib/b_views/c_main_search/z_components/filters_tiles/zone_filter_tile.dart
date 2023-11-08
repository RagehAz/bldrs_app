import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class ZoneFilterTile extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const ZoneFilterTile({
    required this.zone,
    required this.onTileTap,
    required this.onSwitchTap,
    super.key
  });
  // --------------------
  final ZoneModel? zone;
  final Function onTileTap;
  final Function(bool) onSwitchTap;
  // -----------------------------------------------------------------------------
  static Verse? getZoneVerse({
    required ZoneModel? zoneModel,
  }) {

    final Verse _headline = zoneModel == null ?
    const Verse(id: 'phid_the_entire_world', translate: true)
        :
    ZoneModel.generateInZoneVerse(
      zoneModel: zoneModel,
    );

    return _headline;
  }
  // --------------------
  static String? getZoneIcon({
    required ZoneModel? zoneModel,
  }){

    if (zoneModel == null){
      return Iconz.planet;
    }

    else {
      return zoneModel.icon ?? Flag.getCountryIcon(zoneModel.countryID);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    final Verse? _headline = getZoneVerse(
      zoneModel: zone,
    );

    return TileBubble(
      bubbleWidth: _tileWidth,
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
          context: context,
          leadingIcon: getZoneIcon(
            zoneModel: zone,
          ),
          headerWidth: _tileWidth,
          headlineVerse: _headline,
          hasSwitch: true, //UsersProvider.userIsAdmin(context),
          switchValue: zone != null,
          onSwitchTap: onSwitchTap
      ),
      onTileTap: onTileTap,
      textDirection: UiProvider.getAppTextDir(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    );

  }
  // -----------------------------------------------------------------------------
}
