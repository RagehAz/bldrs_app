import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTileButton({
    @required this.bzModel,
    this.height,
    this.width,
    this.color = Colorz.white10,
    this.onTap,
    this.secondLine,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final Color color;
  final Function onTap;
  final BzModel bzModel;
  final Verse secondLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return TileButton(
      width: width,
      height: height,
      color: color,
      onTap: onTap,
      icon: bzModel?.logo,
      verse: Verse.plain(bzModel?.name),
      secondLine: secondLine,
    );

  }
/// --------------------------------------------------------------------------
}
