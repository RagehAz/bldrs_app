import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
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
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/search_protocols/search_protocols.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_timers.dart';
import 'package:bldrs/super_fire/super_fire.dart';
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

                      final SearchModel _model = _models[index];

                      return TileBubble(
                        bubbleHeaderVM: BubbleHeaderVM(
                          headlineText: _model.text ?? '...',
                          headlineHeight: 25,
                          leadingIcon: Iconz.clock,
                          leadingIconSizeFactor: 0.7,
                        ),
                        secondLine: BldrsTimers.generateString_hh_i_mm_ampm_day_dd_month_yyyy(context: context, time: _model.time),
                        secondLineTextHeight: 20,
                        child: SizedBox(
                          width: TileBubble.childWidth(context: context),
                          child: Wrap(
                            // runAlignment: WrapAlignment.end,
                            // crossAxisAlignment: WrapCrossAlignment.start,
                            // alignment: WrapAlignment.start,
                            textDirection: UiProvider.getAppTextDir(context),
                            children: <Widget>[

                              HistoryText(text: _model.zone?.countryName),
                              HistoryText(text: _model.zone?.cityName),



                                      /// bzSearchModel?.bzType
                                      /// bzSearchModel?.bzForm
                                      /// bzSearchModel?.bzAccountType
                                      /// bzSearchModel?.scopePhid
                                      /// bzSearchModel?.onlyShowingTeams
                                      /// bzSearchModel?.onlyVerified

                              // if (_model.flyerSearchModel?.flyerType == != null)
                              HistoryIcon(
                                  icon: FlyerTyper.flyerTypeIcon(
                                      flyerType: _model.flyerSearchModel?.flyerType,
                                      isOn: false
                                  )
                              ),

                                      // xxx

                                      /// flyerSearchModel?.auditState
                                      /// flyerSearchModel?.publishState

                              // if (_model.flyerSearchModel?.phid == != null)
                              HistoryText(text: Verse.transBake(_model.flyerSearchModel?.phid)),

                              // if (_model.flyerSearchModel?.onlyAmazonProducts == true)
                              const HistoryIcon(icon: Iconz.amazon),

                              // if (_model.flyerSearchModel?.onlyShowingAuthors == true)
                              const HistoryIcon(icon: Iconz.bz),

                              // if (_model.flyerSearchModel?.onlyWithPDF == true)
                              const HistoryIcon(icon: Iconz.pfd),

                              // if (_model.flyerSearchModel?.onlyWithPrices == true)
                              const HistoryIcon(icon: Iconz.dollar),




                              HistoryText(text: _model.flyerSearchModel?.onlyAmazonProducts == true ?
                              'Only Amazon Products' : null,
                              ),


                              HistoryText(text: _model.id),

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

class HistoryText extends StatelessWidget {

  const HistoryText({
    @required this.text,
    Key key
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return BldrsText(
      verse: Verse.plain(text),
      labelColor: Colorz.black200,
      margin: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: 5,
      ),
    );
  }
}

class HistoryIcon extends StatelessWidget {

  const HistoryIcon({
    @required this.icon,
    Key key
  }) : super(key: key);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return BldrsBox(
      height: 23,
      width: 23,
      icon: icon,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: 5,
      ),
      corners: 5,
      color: Colorz.white10,
      bubble: false,
    );
  }
}
