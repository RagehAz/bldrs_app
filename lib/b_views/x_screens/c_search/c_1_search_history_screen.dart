import 'package:bldrs/b_views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SearchHistoryScreen extends StatelessWidget {
  const SearchHistoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _searchList = <String>[
      'Interior',
      'Architecture',
      'sallab',
      'grohe',
      'hanafeya',
      'tagamoo'
    ];

    return MainLayout(
      appBarType: AppBarType.basic,
      pageTitle: 'Search History',
      // appBarBackButton: true,
      pyramidsAreOn: true,
      layoutWidget: ListView.builder(
          itemCount: _searchList.length,
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          itemBuilder: (BuildContext context, int index) {

            final String _searchWord = _searchList[index];

            return TileBubble(
              verse: _searchWord,
              icon: Iconz.dvBlankSVG,
              iconSizeFactor: 0.9,
              btOnTap: () {
                Nav.goBack(context, argument: _searchWord);
              },
            );
          }),
    );
  }
}
