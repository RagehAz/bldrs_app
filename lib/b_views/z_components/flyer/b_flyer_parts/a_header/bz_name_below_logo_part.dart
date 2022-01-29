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
    @required this.headerIsExpanded,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final ValueNotifier<bool> headerIsExpanded;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : TEMP
    return ValueListenableBuilder<bool>(
        valueListenable: headerIsExpanded,
        child: Container(
          color: Colorz.black80,
          child: BzPageHeadline(
            flyerBoxWidth: flyerBoxWidth,
            bzPageIsOn: true,
            bzModel: bzModel,
            country: bzCountry,
            city: bzCity,
          ),
        ),
        builder: (_, bool _headerIsExpanded, Widget child){

          if (_headerIsExpanded == true){
            return child;
          }

          else {
            return const SizedBox();
          }

        }
    );

  }
}
