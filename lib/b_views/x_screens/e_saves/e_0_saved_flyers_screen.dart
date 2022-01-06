import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/tab_layout_model.dart';
import 'package:bldrs/c_controllers/e_saves_controller.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// SCREEN
class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  /// --------------------------------------------------------------------------
  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _tabController = TabController(vsync: this, length: sectionsTabs.length, initialIndex: getInitialTabIndex(context));

    /// LISTENS TO TAB CHANGE AFTER SWIPE ANIMATION ENDS
    // _tabController.addListener(() => _onChangeTabIndex(_tabController.index));

    /// LISTEN TO TAB CHANGE WHILE ANIMATION
    _tabController.animation.addListener(
        () => onChangeTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        )
    );

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void didChangeDependencies() {
    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

    _uiProvider.startController((){

      // createSavedFlyersTabModels(
      //   context: context,
      //   tabController: _tabController,
      //   selectionMode: widget.selectionMode,
      //   allFlyers: [],
      // );

    });

    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void _passSelectedFlyersBack(){

    Nav.goBack(context, argument:
    // _selectedFlyers
    [],
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidsAreOn: true,
      pageTitle: 'Saved flyers',
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      onBack: widget.selectionMode ? _passSelectedFlyersBack : null,
      layoutWidget: SavedFlyersScreenView(
        tabController: _tabController,
        selectionMode: widget.selectionMode,
      ),

    );

  }
}

/// VIEW
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
                  ...List.generate(sectionsTabs.length, (index){

                    final FlyerType _flyerType = sectionsTabs[index];
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

/// SAVED FLYERS TAB BAR COMPONENT
class SavedFlyersTabBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersTabBar({
    @required this.tabController,
    @required this.currentFlyerTypeTab,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerType currentFlyerTypeTab;
  final TabController tabController;
  /// --------------------------------------------------------------------------
  bool _isSelected(FlyerType flyerType){

    bool _isSelected = false;

    if (currentFlyerTypeTab == flyerType){
      _isSelected = true;
    }

    return _isSelected;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return BldrsSliverTabBar(
      tabController: tabController,
      tabs: <Widget>[

        /// IT HAS TO BE LIST.GENERATE ma3lesh
        ...List.generate(sectionsTabs.length, (index){

          final FlyerType _flyerType = sectionsTabs[index];
          final String _flyerTypeString = cipherFlyerType(_flyerType);

          return
            TabButton(
              key: ValueKey<String>('saved_flyer_tab_button_$_flyerTypeString'),
              verse: TextGen.flyerTypePluralStringer(context, _flyerType),
              icon: Iconizer.flyerTypeIconOff(_flyerType),
              isSelected: _isSelected(_flyerType),
              onTap: () => onChangeTabIndex(
                context: context,
                tabController: tabController,
                index: index,
              ),
            );

        }),

      ],
    );
  }
}

/// COMPONENT
class BldrsSliverTabBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsSliverTabBar({
    @required this.tabs,
    @required this.tabController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> tabs;
  final TabController tabController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: SliverAppBar(
        collapsedHeight: Ratioz.stratosphere,
        backgroundColor: Colorz.blackSemi230,
        leadingWidth: 0,
        leading: Container(),
        floating: true,
        bottom: TabBar(
          controller: tabController,
          physics: const BouncingScrollPhysics(),
          // labelColor: Colorz.BloodTest,

          // indicatorColor: Colorz.BloodTest,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 0,
          indicator: BoxDecoration(
            color: Colorz.yellow255,
            borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner12 + 2.5),
          ),

          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          labelPadding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),

          onTap: (int x){
            blog('x is : $x');
          },

          tabs: tabs,
        ),
      ),
    );
  }
}
