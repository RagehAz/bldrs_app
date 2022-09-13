import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class WideCountryButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideCountryButton({
    @required this.onTap,
    @required this.countryID,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String countryID;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 50,
      width: width ?? Bubble.clearWidth(context),
      icon: Flag.getFlagIcon(countryID),
      iconSizeFactor: 0.8,
      verse: Verse.plain(CountryModel.translateCountryName(context: context, countryID: countryID)),
      bubble: false,
      margins: const EdgeInsets.symmetric(vertical: 5),
      verseScaleFactor: 0.8,
      color: Colorz.white10,
      onTap: onTap,
    );

  }
  /// --------------------------------------------------------------------------
}
