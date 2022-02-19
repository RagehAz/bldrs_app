import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_2_bz_flyers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_3_bz_about_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_4_bz_authors_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_5_bz_targets_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_6_bz_powers_page.dart';
import 'package:bldrs/b_views/y_views/f_bz/f_7_bz_network_page.dart';
import 'package:flutter/material.dart';

class MyBzScreenViewPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreenViewPages({
    @required this.tabController,
    @required this.bzModel,
    @required this.bzFlyers,
    @required this.bzCountry,
    @required this.bzCity,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final TabController tabController;
  final BzModel bzModel;
  final List<FlyerModel> bzFlyers;
  final CountryModel bzCountry;
  final CityModel bzCity;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: <Widget>[

        BzFlyersPage(
            key: const PageStorageKey('BzFlyersPage'),
            bzModel: bzModel,
            flyers: bzFlyers,
            bzCountry: bzCountry,
            bzCity: bzCity
        ),

        BzAboutPage(
          bzModel: bzModel,
        ),

        BzAuthorsPage(
          bzModel: bzModel,
        ),

        BzTargetsPage(
          bzModel: bzModel,
        ),

        BzPowersPage(
          bzModel: bzModel,
        ),

        BzNetworkPage(
          bzModel: bzModel,
        ),

      ],
    );
  }
}
