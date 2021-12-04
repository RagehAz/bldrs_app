import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/views/screens/f_bz/f_2_deactivated_flyers_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/tab_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/tab_layout.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/gallery.dart';
import 'package:flutter/material.dart';

class BzFlyersTab extends StatelessWidget {
  final BzModel bzModel;
  final List<FlyerModel> flyers;
  final CountryModel bzCountry;
  final CityModel bzCity;

  const BzFlyersTab({
    @required this.bzModel,
    @required this.flyers,
    @required this.bzCountry,
    @required this.bzCity,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  static TabModel flyersTabModel({
    @required Function onChangeTab,
    @required BzModel bzModel,
    @required List<FlyerModel> tinyFlyers,
    @required bool isSelected,
    @required int tabIndex,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
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
        page: BzFlyersTab(
          bzModel: bzModel,
          flyers: tinyFlyers,
          bzCountry: bzCountry,
          bzCity: bzCity,
        ),

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
        if (bzModel.flyersIDs != null)
          Bubble(
            title: 'Published Flyers',
            centered: false,
            actionBtIcon: Iconz.Clock,
            actionBtFunction: () => _showOldFlyersOnTap(context, bzModel),
            columnChildren: <Widget>[

              if (Mapper.canLoopList(flyers))
              Gallery(
                galleryBoxWidth: Bubble.clearWidth(context),
                superFlyer: SuperFlyer.getSuperFlyerFromBzModelOnly(
                  bzModel: bzModel,
                  onHeaderTap: () => print('on header tap in f 0 my bz Screen'),
                  bzCity: bzCity,
                  bzCountry: bzCountry,
                ),
                showFlyers: true,
                // tinyFlyers: tinyFlyers,
              ),

              if (flyers == null)
                Container(
                  width: Bubble.clearWidth(context),
                  alignment: Alignment.center,
                  child: const Loading(loading: true,)),

            ],
          ),

        const PyramidsHorizon(),

      ],
    );
  }
}
