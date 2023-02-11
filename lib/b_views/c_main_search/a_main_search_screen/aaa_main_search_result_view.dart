import 'package:bldrs/a_models/x_secondary/search_result.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyers_shelf/flyers_shelf.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/search_provider.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SearchResultView({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<SearchProvider, List<SearchResult>>(
      selector: (_, SearchProvider searchProvider) => searchProvider.searchResult,
      // child: Container(),
      // shouldRebuild: ,
      builder: (BuildContext context, List<SearchResult> searchResult, Widget child){

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: searchResult.length,
          padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
          itemBuilder: (BuildContext ctx, int index) {

            final SearchResult _result = searchResult[index];

            return FlyersShelf(
              titleVerse: Verse(
                id: _result.title,
                translate: false,
              ),
              flyerSizeFactor: 0.45,
              titleIcon: _result.icon,
              // flyerOnTap: (FlyerModel flyerModel) {
              //   blog('flyer tapped : ${flyerModel.id}');
              // },
              onScrollEnd: () {
                blog('scroll ended');
              },
              flyers: _result.flyers,
            );
          },
        );
      }
      ,
    );

  }
  // -----------------------------------------------------------------------------
}
