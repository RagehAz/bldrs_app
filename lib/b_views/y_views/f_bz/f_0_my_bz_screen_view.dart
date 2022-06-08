import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_1_my_bz_screen_view_pages.dart';
import 'package:bldrs/b_views/z_components/tab_bars/my_bz_screen_tab_bar.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBzScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreenView({
    @required this.tabController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){

        return <Widget>[

          /// MY BZ SCREEN SLIVER TABS
          Consumer<UiProvider>(
            builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {

              final BzTab _currentBzTab = uiProvider.currentBzTab;

              return MyBzScreenTabBar(
                tabController: tabController,
                currentBzTab: _currentBzTab,
              );

            },
          ),
          
        ];

      },

      /// MY BZ SCREEN PAGES
      body: MyBzScreenViewPages(
        tabController: tabController,
      ),

    );
  }
}
