import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/screens/f_bz/f_2_deactivated_flyers_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/gallery.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:flutter/material.dart';

class BzFlyersTab extends StatelessWidget {
  final BzModel bzModel;

  const BzFlyersTab({
    @required this.bzModel,
  });
// -----------------------------------------------------------------------------
  static TabModel flyersTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required bool isSelected,
    @required int tabIndex,
  }) {
    return
      TabModel(
        tabButton: TabButton(
          verse: BzModel.bzPagesTabsTitles[tabIndex],
          icon: Iconz.FlyerGrid,
          isSelected: isSelected,
          onTap: () => onChangeTab(tabIndex),
          iconSizeFactor: 0.7,
          triggerIconColor: false,
        ),
        page: BzFlyersTab(bzModel: bzModel,),

      );
  }
// -----------------------------------------------------------------------------
  void _showOldFlyersOnTap(BuildContext context, BzModel bzModel){
    Nav.goToNewScreen(context, DeactivatedFlyerScreen(bz: bzModel));
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[

        /// --- PUBLISHED FLYERS
        if (bzModel.nanoFlyers != null)
          Bubble(
            title: 'Published Flyers',
            centered: false,
            actionBtIcon: Iconz.Clock,
            actionBtFunction: () => _showOldFlyersOnTap(context, bzModel),
            columnChildren: <Widget>[

              Gallery(
                galleryBoxWidth: Bubble.clearWidth(context),
                superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                  bzModel: bzModel,
                  onHeaderTap: () => print('on header tap in f 0 my bz Screen'),
                ),
                showFlyers: true,
              ),

            ],
          ),

        const PyramidsHorizon(),

      ],
    );
  }
}
