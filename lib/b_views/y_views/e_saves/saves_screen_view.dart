

import 'package:bldrs/b_views/z_components/layouts/tab_bar_view_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/tab_layout_model.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreenView({
    @required this.tabController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, List<TabModel>>(
        selector: (_, UiProvider uiProvider) => uiProvider.savedFlyersTabModels,
        // child: ,
        // shouldRebuild: ,
        builder: (BuildContext context, List<TabModel> tabModels, Widget child){

          return TabBarViewLayout(
            tabModels: tabModels,
            tabController: tabController,
          );

        }
        );
  }
}
