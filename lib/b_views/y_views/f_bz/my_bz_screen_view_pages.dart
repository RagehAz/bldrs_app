import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/bz_about_tab.dart';
import 'package:bldrs/b_views/y_views/f_bz/bz_flyers_tab.dart';
import 'package:bldrs/b_views/y_views/f_bz/bz_powers_tab.dart';
import 'package:bldrs/b_views/y_views/f_bz/bz_targets_tab.dart';
import 'package:flutter/material.dart';

class MyBzScreenViewPages extends StatelessWidget {

  const MyBzScreenViewPages({
    @required this.tabController,
    @required this.bzModel,
    @required this.bzFlyers,
    @required this.bzCountry,
    @required this.bzCity,
    Key key
  }) : super(key: key);

  final TabController tabController;
  final BzModel bzModel;
  final List<FlyerModel> bzFlyers;
  final CountryModel bzCountry;
  final CityModel bzCity;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: <Widget>[

        BzFlyersTab(
            bzModel: bzModel,
            flyers: bzFlyers,
            bzCountry: bzCountry,
            bzCity: bzCity
        ),

        BzAboutTab(
          bzModel: bzModel,
        ),

        BzTargetsTab(
          bzModel: bzModel,
        ),

        BzPowersTab(
          bzModel: bzModel,
        ),

      ],
    );
  }
}
