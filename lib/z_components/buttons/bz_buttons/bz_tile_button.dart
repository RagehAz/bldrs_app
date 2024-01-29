import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class BzTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTileButton({
    required this.bzModel,
    this.height,
    this.width,
    this.color = Colorz.white10,
    this.onTap,
    this.secondLine,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? height;
  final double? width;
  final Color color;
  final Function? onTap;
  final BzModel? bzModel;
  final Verse? secondLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = height ?? TileButton.defaultHeight;

    return Stack(
      alignment: BldrsAligners.superCenterAlignment(context),
      children: <Widget>[

        TileButton(
          width: width,
          height: _height,
          color: color,
          onTap: onTap,
          icon: Iconz.dvBlankSVG,
          verse: Verse.plain(bzModel?.name),
          secondLine: secondLine,
          margins: EdgeInsets.zero,
        ),

        SizedBox(
          width: _height,
          height: _height,
          child: BzLogo(
            width: _height,
            isVerified: bzModel?.isVerified,
            onTap: onTap,
            // zeroCornerIsOn: false,
            shadowIsOn: true,
            image: bzModel?.logoPath,
          ),
        ),

      ],

    );

  }
/// --------------------------------------------------------------------------
}
