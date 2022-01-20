import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzNameBelowLogoPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzNameBelowLogoPart({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colorz.black80,
      child: BzPageHeadline(
        flyerBoxWidth: flyerBoxWidth,
        bzPageIsOn: true,
        bzModel: bzModel,
        country: bzCountry,
        city: bzCity,
      ),
    );

  }
}
