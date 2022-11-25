import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:flutter/material.dart';

class CountryTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryTileButton({
    @required this.onTap,
    @required this.countryID,
    this.width,
    this.height,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String countryID;
  final double width;
  final double height;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileButton(
      height: height,
      width: width ?? Bubble.clearWidth(context),
      icon: Flag.getFlagIcon(countryID),
      verse: Verse.plain(Flag.getCountryNameByCurrentLang(context: context, countryID: countryID)),
      onTap: onTap,
    );


  }
  /// --------------------------------------------------------------------------
}
