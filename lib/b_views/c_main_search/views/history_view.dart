import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bubbles/model/bubble_header_vm.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/b_views/c_main_search/z_components/building_blocks/history_line.dart';
import 'package:bldrs/b_views/c_main_search/z_components/filters_tiles/zone_filter_tile.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class SearchHistoryView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchHistoryView({
    required this.onDeleteHistoryModel,
    required this.onHistoryModelTap,
    required this.searchHistoryModels,
    super.key
  });
  // --------------------
  final Function(SearchModel) onDeleteHistoryModel;
  final Function(SearchModel) onHistoryModelTap;
  final List<SearchModel> searchHistoryModels;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(searchHistoryModels) == false) {
      return SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        // child: const NoResultFound(),
      );
    }

    else {
      return WidgetFader(
        fadeType: FadeType.fadeIn,
        child: FloatingList(
          padding: Stratosphere.getStratosphereSandwich(
            context: context,
            appBarType: AppBarType.search,
          ),
          columnChildren: <Widget>[

            ...List.generate(searchHistoryModels.length, (index) {

              final SearchModel _model = searchHistoryModels[index];

              return BldrsTileBubble(
                onTileTap: () => onHistoryModelTap(_model),
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineText: BldrsTimers.calculateSuperTimeDifferenceString(
                    from: _model.time,
                    to: DateTime.now(),
                  ),
                  moreButtonIcon: Iconz.xSmall,
                  moreButtonIconSizeFactor: 0.5,
                  hasMoreButton: true,
                  onMoreButtonTap: () => onDeleteHistoryModel(_model),
                  headlineHeight: 25,
                  leadingIcon: Iconz.clock,
                  leadingIconSizeFactor: 0.5,
                ),
                child: SizedBox(
                  width: TileBubble.childWidth(context: context),
                  child: Wrap(
                    textDirection: UiProvider.getAppTextDir(),
                    runSpacing: 5,
                    spacing: 5,
                    children: <Widget>[

                      /// SEARCH TEXT
                      HistoryLine(
                        verse: Verse.plain(_model.text),
                        boldText: true,
                        icon: null,
                      ),

                      /// ZONE
                      HistoryLine(
                        icon: ZoneFilterTile.getZoneIcon(zoneModel: _model.zone),
                        bigIcon: true,
                        verse: ZoneFilterTile.getZoneVerse(
                            zoneModel: _model.zone,
                        ),
                      ),

                      /// FLYER TYPE
                      if (_model.flyerSearchModel?.flyerType != null)
                        HistoryLine(
                          icon: FlyerTyper.flyerTypeIcon(
                            flyerType: _model.flyerSearchModel?.flyerType,
                            isOn: false,
                          ),
                          verse: Verse(
                            id: FlyerTyper.getFlyerTypePhid(
                              flyerType: _model.flyerSearchModel?.flyerType,
                              pluralTranslation: false,
                            ),
                            translate: true,
                          ),
                        ),

                      /// PHID
                      if (_model.flyerSearchModel?.phid != null)
                        HistoryLine(
                          icon: ChainsProvider.proGetPhidIcon(
                            son: _model.flyerSearchModel?.phid,
                          ),
                          bigIcon: true,
                          verse: Verse(
                            id: _model.flyerSearchModel?.phid,
                            translate: true,
                          ),
                        ),

                      /// ONLY FLYERS SHOWING AUTHORS
                      if (Mapper.boolIsTrue(_model.flyerSearchModel?.onlyShowingAuthors) == true)
                        const HistoryLine(
                          icon: Iconz.bz,
                          verse: Verse(
                            id: 'phid_only_flyers_showing_authors',
                            translate: true,
                          ),
                        ),

                      /// ONLY FLYERS SHOWING PRICES
                      if (Mapper.boolIsTrue(_model.flyerSearchModel?.onlyWithPrices) == true)
                        const HistoryLine(
                          icon: Iconz.dollar,
                          verse: Verse(
                            id: 'phid_only_flyers_with_prices',
                            translate: true,
                          ),
                        ),

                      if (Mapper.boolIsTrue(_model.flyerSearchModel?.onlyWithPDF) == true)
                        const HistoryLine(
                            icon: Iconz.pdf,
                            verse: Verse(
                              id: 'phid_only_flyers_with_pdf',
                              translate: true,
                            )),

                      /// AMAZON PRODUCTS
                      if (Mapper.boolIsTrue(_model.flyerSearchModel?.onlyAmazonProducts) == true)
                        const HistoryLine(
                            icon: Iconz.amazon,
                            verse: Verse(
                              id: 'phid_only_amazon_products',
                              translate: true,
                            )),

                      /// PUBLISH STATE
                      if (_model.flyerSearchModel?.publishState != null)
                        HistoryLine(
                          icon: Iconz.verifyFlyer,
                          verse: Verse(
                            id: PublicationModel.getPublishStatePhid(_model.flyerSearchModel?.publishState),
                            translate: true,
                          ),
                        ),

                      /// ONLY VERIFIED BZZ
                      if (Mapper.boolIsTrue(_model.bzSearchModel?.onlyVerified) == true)
                        const HistoryLine(
                          icon: Iconz.bzBadgeWhite,
                          verse: Verse(
                            id: 'phid_only_verified_bzz',
                            translate: true,
                          ),
                        ),

                      /// BZ FORM
                      if (_model.bzSearchModel?.bzForm != null)
                        HistoryLine(
                          icon: Iconz.bz,
                          verse: Verse(
                            id: BzTyper.getBzFormPhid(_model.bzSearchModel?.bzForm),
                            translate: true,
                          ),
                        ),

                      /// BZ TYPE
                      if (_model.bzSearchModel?.bzType != null)
                        HistoryLine(
                          icon: Iconz.bz,
                          verse: Verse(
                            translate: true,
                            id: BzTyper.getBzTypePhid(
                              bzType: _model.bzSearchModel?.bzType,
                              pluralTranslation: false,
                            ),
                          ),
                        ),

                      /// SCOPE PHID
                      if (_model.bzSearchModel?.scopePhid != null)
                        HistoryLine(
                          icon: ChainsProvider.proGetPhidIcon(
                            son: _model.bzSearchModel?.scopePhid,
                          ),
                          bigIcon: true,
                          verse: Verse(
                            translate: true,
                            id: _model.bzSearchModel?.scopePhid,
                          ),
                        ),

                      /// ONLY BZZ SHOWING TEAMS
                      if (_model.bzSearchModel?.scopePhid != null)
                        const HistoryLine(
                          icon: Iconz.users,
                          verse: Verse(
                            id: 'phid_only_bzz_showing_team',
                            translate: true,
                          ),
                        ),

                      /// BZ ACCOUNT TYPE
                      if (_model.bzSearchModel?.bzAccountType != null)
                        HistoryLine(
                          icon: Iconz.star,
                          verse: Verse(
                            id: BzTyper.getBzAccountTypePhid(
                              type: _model.bzSearchModel?.bzAccountType,
                            ),
                            translate: true,
                          ),
                        ),

                    ],
                  ),
                ),
              );

            }),

          ],
        ),
      );
    }

  }
  // -----------------------------------------------------------------------------
}
