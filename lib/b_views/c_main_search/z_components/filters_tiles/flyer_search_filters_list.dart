import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filter_bool_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filter_multi_button_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filters_box.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/zone_filter_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/components/sections_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';

class FlyersSearchFiltersList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyersSearchFiltersList({
    required this.searchModel,
    required this.onZoneSwitchTap,
    required this.onZoneTap,
    required this.onFlyerTypeSwitchTap,
    required this.onFlyerTypeTap,
    required this.onPickPhidTap,
    required this.onOnlyShowAuthorSwitchTap,
    required this.onOnlyWithPriceSwitchTap,
    required this.onOnlyWithPDFSwitchTap,
    required this.onOnlyAmazonProductsSwitchTap,
    required this.onPublishStateSwitchTap,
    required this.onPublishStateTap,
    super.key
  });
  // --------------------
  final SearchModel? searchModel;
  final Function(bool value) onZoneSwitchTap;
  final Function onZoneTap;
  final Function(bool value) onFlyerTypeSwitchTap;
  final Function(FlyerType flyerType) onFlyerTypeTap;
  final Function onPickPhidTap;
  final Function(bool value) onOnlyShowAuthorSwitchTap;
  final Function(bool value) onOnlyWithPriceSwitchTap;
  final Function(bool value) onOnlyWithPDFSwitchTap;
  final Function(bool value) onOnlyAmazonProductsSwitchTap;
  final Function(bool value) onPublishStateSwitchTap;
  final Function(PublishState state) onPublishStateTap;
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    final String? _keywordIcon = ChainsProvider.proGetPhidIcon(
      son: searchModel?.flyerSearchModel?.phid,
    );

    // List<SpecModel> specs;

    return SearchFilterBox(
      children: <Widget>[

      /// ZONE
      ZoneFilterTile(
        zone: searchModel?.zone,
        onSwitchTap: onZoneSwitchTap,
        onTileTap: onZoneTap,
      ),

      /// FLYER TYPE
      FilterMultiButtonTile(
        icon: Iconz.flyer,
        verse: const Verse(
          id: 'phid_flyer_type',
          translate: true,
        ),
        switchValue: searchModel?.flyerSearchModel?.flyerType != null,
        onSwitchTap: onFlyerTypeSwitchTap,
        items: FlyerTyper.flyerTypesList,
        selectedItem: searchModel?.flyerSearchModel?.flyerType,
        itemVerse: (dynamic flyerType) => Verse(
          id: FlyerTyper.getFlyerTypePhid(flyerType: flyerType,),
          translate: true,
        ),
        itemIcon: (dynamic flyerType) => FlyerTyper.flyerTypeIcon(flyerType: flyerType, isOn: false),
        onItemTap: (dynamic item) {
          final FlyerType _type = item;
          onFlyerTypeTap(_type);
          },
      ),

      /// KEYWORD
      Disabler(
        isDisabled: searchModel?.flyerSearchModel?.flyerType == null,
        child: TileBubble(
          bubbleWidth: _tileWidth,
          appIsLTR: UiProvider.checkAppIsLeftToRight(),
          textDirection: UiProvider.getAppTextDir(),
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            leadingIcon: searchModel?.flyerSearchModel?.phid == null ? Iconz.keyword
                :
            _keywordIcon == '' ||  _keywordIcon == null ? Iconz.dvBlankSVG
                 :
            _keywordIcon,
            headerWidth: _tileWidth,
            headlineVerse:  searchModel?.flyerSearchModel?.phid == null ?
            const Verse(id: 'phid_select_keyword', translate: true)
                :
            SectionsButton.getBody(
              context: context,
              currentKeywordID: searchModel?.flyerSearchModel?.phid,
              currentSection: searchModel?.flyerSearchModel?.flyerType,
            ),
          ),
          onTileTap: onPickPhidTap,
        ),
      ),

      /// SHOWS AUTHOR
      FilterBoolTile(
        icon: Iconz.bz,
        switchValue: searchModel?.flyerSearchModel?.onlyShowingAuthors,
        verse: const Verse(
          id: 'phid_only_flyers_showing_authors',
          translate: true,
        ),
        onSwitchTap: onOnlyShowAuthorSwitchTap,
      ),

      /// HAS PRICE
      FilterBoolTile(
        icon: Iconz.dollar,
        verse: const Verse(
          id: 'phid_only_flyers_with_prices',
          translate: true,
        ),
        switchValue: searchModel?.flyerSearchModel?.onlyWithPrices,
        onSwitchTap: onOnlyWithPriceSwitchTap,
      ),

      /// HAS PDF
      FilterBoolTile(
        icon: Iconz.pdf,
        verse: const Verse(
          id: 'phid_only_flyers_with_pdf',
          translate: true,
        ),
        switchValue: searchModel?.flyerSearchModel?.onlyWithPDF,
        onSwitchTap: onOnlyWithPDFSwitchTap,
      ),

      /// IS AMAZON PRODUCT
      FilterBoolTile(
        icon: Iconz.amazon,
        verse: const Verse(
          id: 'phid_only_amazon_products',
          translate: true,
        ),
        switchValue: searchModel?.flyerSearchModel?.onlyAmazonProducts,
        onSwitchTap: onOnlyAmazonProductsSwitchTap,
      ),

      /// SEPARATOR
      if (UsersProvider.userIsAdmin() == true)
      const DotSeparator(),

      /// PUBLISH STATE
      if (UsersProvider.userIsAdmin() == true)
        FilterMultiButtonTile(
          bubbleColor: Colorz.yellow50,
          icon: Iconz.verifyFlyer,
          verse: const Verse(
            id: 'phid_publish_state',
            translate: true,
          ),
          switchValue: searchModel?.flyerSearchModel?.publishState != null,
          onSwitchTap: onPublishStateSwitchTap,
          items: PublicationModel.publishStates,
          selectedItem: searchModel?.flyerSearchModel?.publishState,
          itemVerse: (dynamic state) => Verse(id: PublicationModel.getPublishStatePhid(state), translate: true,),
          onItemTap: (dynamic item){
            final PublishState _state = item;
            onPublishStateTap(_state);
            },
        ),

    ],
    );

  }
  // -----------------------------------------------------------------------------
}
