import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/bz_search_model.dart';
import 'package:bldrs/a_models/m_search/flyer_search_model.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/a_models/x_secondary/bldrs_model_type.dart';
import 'package:bldrs/b_views/c_main_search/views/bzz_paginator_view.dart';
import 'package:bldrs/b_views/c_main_search/views/flyers_paginator_view.dart';
import 'package:bldrs/b_views/c_main_search/views/users_paginator_view.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/search_protocols/search_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';
import 'package:scale/scale.dart';

class SearchViewSplitter extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchViewSplitter({
    @required this.searchType,
    @required this.flyersQuery,
    @required this.flyersController,
    @required this.bzzQuery,
    @required this.bzzController,
    @required this.usersQuery,
    @required this.usersController,
    Key key
  }) : super(key: key);
  // --------------------
  final ModelType searchType;
  final FireQueryModel flyersQuery;
  final PaginationController flyersController;
  final FireQueryModel bzzQuery;
  final PaginationController bzzController;
  final FireQueryModel usersQuery;
  final PaginationController usersController;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// FLYERS PAGINATION
    if (searchType == ModelType.flyer){
      return FlyersPaginatorView(
        fireQueryModel: flyersQuery,
        paginationController: flyersController,
      );
    }

    /// BZZ PAGINATION
    else if (searchType == ModelType.bz){
      return BzzPaginatorView(
        fireQueryModel: bzzQuery,
        paginationController: bzzController,
      );
    }

    /// USERS PAGINATION
    else if (searchType == ModelType.user){
      return UsersPaginatorView(
        fireQueryModel: usersQuery,
        paginationController: usersController,
      );
    }

    else {
      return SizedBox(
        width: Scale.screenWidth(context),
        height: Scale.screenHeight(context),
        child: FutureBuilder(
          future: SearchProtocols.fetchAll(userID: Authing.getUserID()),
          builder: (_, AsyncSnapshot<Object> snap){

            final List<SearchModel> _models = snap.data;



            if (snap.connectionState == ConnectionState.waiting){
              return const Center(child: LoadingBlackHole());
            }
            else if (Mapper.checkCanLoopList(_models) == false){
              return const NoResultFound();
            }
            else {

              return FloatingList(
                padding: Stratosphere.getStratosphereSandwich(
                  context: context,
                  appBarType: AppBarType.search,
                ),
                  columnChildren: <Widget>[

                    ...List.generate(_models.length, (index){

                      SearchModel _model = _models[index];

                      _model = _model.copyWith(
                        zone: ZoneModel(
                          countryID: 'egy',
                          cityID: 'egy+cairo',
                          countryName: 'Masr',
                          cityName: 'kahera',
                          icon: Flag.getCountryIcon('egy'),
                        ),
                        time: DateTime.now(),
                        text: 'Bojou Handojou',
                        flyerSearchModel: const FlyerSearchModel(
                            flyerType: FlyerType.product,
                            onlyShowingAuthors: true,
                            onlyWithPrices: true,
                            onlyWithPDF: true,
                            onlyAmazonProducts: true,
                            phid: 'phid_k_prd_app_drink_blender',
                            publishState: PublishState.deleted,
                            auditState: AuditState.pending,
                        ),
                        bzSearchModel: const BzSearchModel(
                            bzType: BzType.contractor,
                            bzForm: BzForm.individual,
                            bzAccountType: BzAccountType.advanced,
                            scopePhid: 'phid_k_prd_app_bath_handDryer',
                            onlyShowingTeams: true,
                            onlyVerified: true,
                        ),
                      );

                      return TileBubble(
                        bubbleHeaderVM: BubbleHeaderVM(
                          headlineText: BldrsTimers.calculateSuperTimeDifferenceString(
                            context: context,
                            from: _model.time,
                            to: DateTime.now(),
                          ),
                          headlineHeight: 25,
                          leadingIcon: Iconz.clock,
                          leadingIconSizeFactor: 0.7,
                        ),
                        child: SizedBox(
                          width: TileBubble.childWidth(context: context),
                          child: Wrap(
                            textDirection: UiProvider.getAppTextDir(context),
                            children: <Widget>[

                              /// SEARCH TEXT
                              HistoryLine(
                                verse: Verse.plain(_model.text),
                                boldText: true,
                                icon: null,
                              ),

                              /// ZONE
                              HistoryLine(
                                icon: _model?.zone?.icon,
                                bigIcon: true,
                                verse: ZoneModel.generateInZoneVerse(
                                  context: context,
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
                              if (_model.flyerSearchModel?.onlyShowingAuthors == true)
                              const HistoryLine(
                                icon: Iconz.bz,
                                verse: Verse(
                                  id: 'phid_only_flyers_showing_authors',
                                  translate: true,
                                ),
                              ),

                              /// ONLY FLYERS SHOWING PRICES
                              if (_model.flyerSearchModel?.onlyWithPrices == true)
                              const HistoryLine(
                                icon: Iconz.dollar,
                                verse: Verse(
                                  id: 'phid_only_flyers_with_prices',
                                  translate: true,
                                ),
                              ),

                              if (_model.flyerSearchModel?.onlyWithPDF == true)
                              const HistoryLine(
                                icon: Iconz.pfd,
                                verse: Verse(
                                  id: 'phid_only_flyers_with_pdf',
                                  translate: true,
                                )
                              ),

                              /// AMAZON PRODUCTS
                              if (_model.flyerSearchModel?.onlyAmazonProducts == true)
                              const HistoryLine(
                                icon: Iconz.amazon,
                                  verse: Verse(
                                    id: 'phid_only_amazon_products',
                                    translate: true,
                                  )
                              ),

                              /// AUDIT STATE
                              if (_model.flyerSearchModel?.auditState != null)
                              HistoryLine(
                                icon: Iconz.verifyFlyer,
                                verse: Verse(
                                  id: FlyerModel.getAuditStatePhid(_model.flyerSearchModel?.auditState),
                                  translate: true,
                                ),
                              ),

                              /// PUBLISH STATE
                              if (_model.flyerSearchModel?.publishState != null)
                              HistoryLine(
                                icon: Iconz.verifyFlyer,
                                verse: Verse(
                                  id: FlyerModel.getPublishStatePhid(_model.flyerSearchModel?.publishState),
                                  translate: true,
                                ),
                              ),

                              /// ONLY VERIFIED BZZ
                              if (_model.bzSearchModel?.onlyVerified == true)
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
                              if (_model.bzSearchModel?.scopePhid!= null)
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
              );
            }

          },
        )
      );
    }

  }
  // -----------------------------------------------------------------------------
}


class HistoryLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const HistoryLine({
    @required this.verse,
    @required this.icon,
    this.bigIcon = false,
    this.boldText = false,
    Key key
  }) : super(key: key);
  // --------------------
  final Verse verse;
  final String icon;
  final bool bigIcon;
  final bool boldText;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _iconFactor = bigIcon == true ? 1 : 0.6;


    return BldrsBox(
      verse: verse,
      verseWeight: boldText == true ? VerseWeight.black : VerseWeight.regular,
      height: 27,
      icon: icon,
      iconSizeFactor: _iconFactor,
      verseScaleFactor: 1 / _iconFactor,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: 5,
        bottom: 5,
      ),
      corners: 5,
      color: Colorz.white10,
      bubble: false,
    );
  }
  // -----------------------------------------------------------------------------
}
