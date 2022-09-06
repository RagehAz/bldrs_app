import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class WideCityButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideCityButton({
    @required this.city,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel city;
  final ValueChanged<String> onTap;
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
      verse: _cityNameValue,
      bubble: false,
      margins: const EdgeInsets.symmetric(vertical: 5),
      verseScaleFactor: 0.8,
      color: Colorz.white10,
      // textDirection: superTextDirection(context),
      onTap: () => onTap(city.cityID),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
