import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/tab_bars/saved_flyers_screen_tab_bar.dart';
import 'package:bldrs/c_controllers/e_saves_controller.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreenView({
    @required this.tabController,
    @required this.selectionMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MaxBounceNavigator(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){

          return <Widget>[
            /// SAVED FLYER SCREEN SLIVER TABS
            Consumer<UiProvider>(
              builder: (BuildContext ctx, UiProvider uiProvider, Widget child) {

                final FlyerType _currentFlyerTypeTab = uiProvider.currentSavedFlyerTypeTab;

                return SavedFlyersTabBar(
                  tabController: tabController,
                  currentFlyerTypeTab: _currentFlyerTypeTab,
                );

              },
            ),
          ];

        },

        /// FLYERS GRIDS PAGES
        body: Consumer<FlyersProvider>(
          builder: (_, FlyersProvider flyersProvider, Widget child){

            final List<FlyerModel> _savedFlyers = flyersProvider.savedFlyers;
            final List<FlyerModel> _selectedFlyers = flyersProvider.selectedFlyers;

            return

              TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabController,
                children: <Widget>[

                  /// IT HAS TO BE LIST.GENERATE (ma3lesh agebha ymeen shmal mesh gayya)
                  ...List.generate(sectionsList.length, (index){

                    final FlyerType _flyerType = sectionsList[index];
                    final String _flyerTypeString = cipherFlyerType(_flyerType);

                    final List<FlyerModel> _flyersOfThisType = FlyerModel.filterFlyersByFlyerType(
                      flyers: _savedFlyers,
                      flyerType: _flyerType,
                    );

                    return
                      SavedFlyersGrid(
                        key: ValueKey<String>('Saved_flyers_page_$_flyerTypeString'),
                        selectionMode: selectionMode,
                        onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
                          context: context,
                          flyer: flyer,
                        ),
                        selectedFlyers: _selectedFlyers,
                        flyers: _flyersOfThisType,
                      );

                  }),

                ],
              );

          },
        ),

      ),
    );
  }
}
