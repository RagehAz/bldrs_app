import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class HeaderLabelsPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderLabelsPart({
    @required this.tinyMode,
    @required this.headerLabelsWidthTween,
    @required this.logoMinWidth,
    @required this.logoSizeRatioTween,
    @required this.flyerBoxWidth,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool tinyMode;
  final Animation<double> headerLabelsWidthTween;
  final double logoMinWidth;
  final Animation<double> logoSizeRatioTween;
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: tinyMode == true ? 0 : 1,
      duration: Ratioz.duration150ms,
      child: Center(
        child: SizedBox(
          width: headerLabelsWidthTween.value,
          height: logoMinWidth * logoSizeRatioTween.value,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[

              HeaderLabels(
                flyerBoxWidth: flyerBoxWidth  * logoSizeRatioTween.value,
                authorID: flyerModel.authorID,
                bzCity: bzCity,
                bzCountry: bzCountry,
                bzModel: bzModel,
                headerIsExpanded: false, //_headerIsExpanded,
                flyerShowsAuthor: flyerModel.showsAuthor,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
