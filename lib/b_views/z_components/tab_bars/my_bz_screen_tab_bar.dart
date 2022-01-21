import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/b_views/z_components/tab_bars/bldrs_sliver_tab_bar.dart';
import 'package:bldrs/c_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';


class MyBzScreenTabBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreenTabBar({
    @required this.tabController,
    @required this.currentBzTab,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final BzTab currentBzTab;
  /// --------------------------------------------------------------------------
  bool _isSelected({
    @required BuildContext context,
    @required BzTab bzTab
  }){

    bool _isSelected = false;

    if (currentBzTab == bzTab){
      _isSelected = true;
    }

    return _isSelected;
  }
// -----------------------------------------------------------------------------
  String _bzTabIcon(BzTab bzTab){
    switch(bzTab){
      case BzTab.flyers   : return Iconz.flyerGrid  ; break;
      case BzTab.about    : return Iconz.info       ; break;
      case BzTab.authors  : return Iconz.bz         ; break;
      case BzTab.targets  : return Iconz.target     ; break;
      case BzTab.powers   : return Iconz.power      ; break;
      case BzTab.network  : return Iconz.follow     ; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsSliverTabBar(
      tabController: tabController,
      tabs: <Widget>[

        /// IT HAS TO BE LIST.GENERATE ma3lesh
        ...List.generate(bzTabsList.length, (index){

          final BzTab _bzTab = bzTabsList[index];
          final String _bzTabString = BzModel.bzPagesTabsTitlesInEnglishOnly[index];

          return
            TabButton(
              key: ValueKey<String>('bz_tab_button_$_bzTabString'),
              verse: _bzTabString,
              icon: _bzTabIcon(_bzTab),
              isSelected: _isSelected(
                context: context,
                bzTab: _bzTab,
              ),
              onTap: () => onChangeMyBzScreenTabIndex(
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
