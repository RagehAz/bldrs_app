import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class WideCityButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideCityButton({
    @required this.city,
    @required this.onSingleTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel city;
  final Function onSingleTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _cityNameValue = CityModel.getTranslatedCityNameFromCity(
        context: context,
        city: city,
    );
    // --------------------
    return DreamBox(
      height: 40,
      width: Bubble.clearWidth(context) - 10,
      iconSizeFactor: 0.8,
      verse: Verse.plain(_cityNameValue),
      bubble: false,
      margins: const EdgeInsets.symmetric(vertical: 5),
      verseScaleFactor: 0.8,
      color: Colorz.white10,
      // textDirection: superTextDirection(context),
      onTap: onSingleTap,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
