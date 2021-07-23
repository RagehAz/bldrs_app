import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SearchHistoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    List<String> _searchList = <String>['Interior', 'Architecture', 'sallab', 'grohe', 'hanafeya', 'tagamoo'];

    return MainLayout(
      appBarType: AppBarType.Basic,
      pageTitle: 'Search History',
      // appBarBackButton: true,
      pyramids: Iconz.DvBlankSVG,
      layoutWidget: ListView.builder(
          itemCount: _searchList.length,
          padding: const EdgeInsets.only(top: Ratioz.stratosphere),
          itemBuilder: (context, index){

            String _searchWord = _searchList[index];

            return TileBubble(
              verse: _searchWord,
              icon: Iconz.DvBlankSVG,
              iconSizeFactor: 0.9,
              btOnTap: (){
                Nav.goBack(context, argument: _searchWord);
                },
            );

          }
      ),
    );
  }
}
