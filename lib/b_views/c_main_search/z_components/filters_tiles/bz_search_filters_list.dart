import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/b_views/c_main_search/super_search_screen.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filter_bool_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filter_multi_button_tile.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/filters_box.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/zone_filter_tile.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:super_box/super_box.dart';

class BzSearchFiltersList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BzSearchFiltersList({
    @required this.searchModel,
    @required this.onZoneSwitchTap,
    @required this.onZoneTap,
    @required this.onBzIsVerifiedSwitchTap,
    @required this.onBzFormSwitchTap,
    @required this.onBzFormTap,
    @required this.onBzTypeSwitchTap,
    @required this.onBzTypeTap,
    @required this.onScopeSwitchTap,
    @required this.onScopeTap,
    @required this.onBzzShowingTeamOnlySwitchTap,
    @required this.onAccountTypeSwitchTap,
    @required this.onAccountTypeTap,
    Key key
  }) : super(key: key);
  // --------------------
  final SearchModel searchModel;
  final Function(bool value) onZoneSwitchTap;
  final Function onZoneTap;
  final Function(bool value) onBzIsVerifiedSwitchTap;
  final Function(bool value) onBzFormSwitchTap;
  final Function(BzForm bzForm) onBzFormTap;
  final Function(bool value) onBzTypeSwitchTap;
  final Function(BzType bzType) onBzTypeTap;
  final Function(bool value) onScopeSwitchTap;
  final Function(FlyerType flyerType) onScopeTap;
  final Function(bool value) onBzzShowingTeamOnlySwitchTap;
  final Function(bool value) onAccountTypeSwitchTap;
  final Function(BzAccountType bzAccountType) onAccountTypeTap;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _tileWidth = SuperSearchScreen.getFilterTileWidth(context);

    // final List<ContactModel> contacts;
    // final BzState bzState;

    return SearchFilterBox(
      children: <Widget>[

        /// ZONE
        ZoneFilterTile(
          searchModel: searchModel,
          onSwitchTap: onZoneSwitchTap,
          onTileTap: onZoneTap,
        ),

        /// BZ IS VERIFIED
        FilterBoolTile(
          icon: Iconz.bzBadgeWhite,
          verse: const Verse(
            id: 'phid_only_verified_bzz',
            translate: true,
          ),
          switchValue: searchModel?.bzSearchModel?.onlyVerified,
          iconIsBig: false,
          onSwitchTap: onBzIsVerifiedSwitchTap,
        ),

        /// BZ FORM
        FilterMultiButtonTile(
          icon: Iconz.bz,
          verse: const Verse(id: 'phid_businessForm', translate: true,),
          switchValue: searchModel?.bzSearchModel?.bzForm != null,
          onSwitchTap: onBzFormSwitchTap,
          items: BzTyper.bzFormsList,
          selectedItem: searchModel?.bzSearchModel?.bzForm,
          itemVerse: (dynamic form) => Verse(id: BzTyper.getBzFormPhid(form), translate: true),
          onItemTap: (dynamic form) {
            final BzForm _bzForm = form;
            onBzFormTap(_bzForm);
          },
        ),

        /// BZ TYPE
        FilterMultiButtonTile(
          icon: Iconz.bz,
          verse: const Verse(
            id: 'phid_bz_entity_type',
            translate: true,
          ),
          switchValue: searchModel?.bzSearchModel?.bzType != null,
          onSwitchTap: onBzTypeSwitchTap,
          items: BzTyper.bzTypesList,
          selectedItem: searchModel?.bzSearchModel?.bzType,
          itemVerse: (dynamic type) => Verse(
            id: BzTyper.getBzTypePhid(
              bzType: type,
              pluralTranslation: false,
            ),
            translate: true,
          ),
          itemIcon: (dynamic type) => BzTyper.getBzTypeIconOff(type),
          onItemTap: (dynamic type) {
            final BzType _bzType = type;
            onBzTypeTap(_bzType);
          },
        ),

        /// SCOPE
        Disabler(
          isDisabled: searchModel?.bzSearchModel?.bzType == null,
          child: ScopeSelectorBubble(
            bubbleWidth: _tileWidth,
            headlineVerse: const Verse(
              id: 'phid_scopeOfServices',
              translate: true,
            ),
            flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzType(
              bzType: searchModel?.bzSearchModel?.bzType,
            ),
            selectedSpecs: SpecModel.generateSpecsByPhids(
              phids: searchModel?.bzSearchModel?.scopePhid == null ?
              [] : [searchModel?.bzSearchModel?.scopePhid],
            ),
            onFlyerTypeBubbleTap: onScopeTap,
            onPhidTap: (FlyerType flyerType, String phid) => onScopeTap(flyerType),
            switchValue: searchModel?.bzSearchModel?.scopePhid != null &&
                searchModel?.bzSearchModel?.bzType != null,
            onSwitchTap: onScopeSwitchTap,
          ),
        ),

        /// BZZ SHOWING TEAMS
        FilterBoolTile(
          icon: Iconz.users,
          verse: const Verse(
            id: 'phid_only_bzz_showing_team',
            translate: true,
          ),
          iconIsBig: false,
          switchValue: searchModel?.bzSearchModel?.onlyShowingTeams,
          onSwitchTap: onBzzShowingTeamOnlySwitchTap,
        ),

        /// SEPARATOR
        if (UsersProvider.userIsAdmin() == true) const DotSeparator(),

        /// ACCOUNT TYPE
        if (UsersProvider.userIsAdmin() == true)
          FilterMultiButtonTile(
            bubbleColor: Colorz.yellow50,
            icon: Iconz.star,
            verse: const Verse(
              id: 'phid_subscription_type',
              translate: true,
            ),
            switchValue: searchModel?.bzSearchModel?.bzAccountType != null,
            onSwitchTap: onAccountTypeSwitchTap,
            items: BzTyper.bzAccountTypesList,
            selectedItem: searchModel?.bzSearchModel?.bzAccountType,
            itemVerse: (dynamic type) => Verse(
              id: type.toString(),
              translate: false,
            ),
            onItemTap: (dynamic type) {
              final BzAccountType _type = type;
              onAccountTypeTap(_type);
            },
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
