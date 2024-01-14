import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class BzBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzBanner({
    required this.boxWidth,
    required this.bigName,
    required this.bzModel,
    this.boxHeight,
    this.corners,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final double? boxWidth;
  final double? boxHeight;
  final double? corners;
  final bool bigName;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _boxWidth = boxWidth ?? 100;
    final double logoSize = _boxWidth * 0.35;
    final double _bigNameFactor = bigName == true ? 0.0035 : 0.0028;

    return Center(
      child: Container(
        width: _boxWidth,
        height: boxHeight,
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: Borderers.cornerAll(corners ?? _boxWidth * 0.1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              /// LOGO
              BzLogo(
                width: logoSize,
                image: bzModel?.logoPath,
                isVerified: bzModel?.isVerified,
              ),

              /// NAME
              BldrsText(
                maxWidth: _boxWidth - 20,
                verse: Verse(
                  id: bzModel?.name ?? '',
                  translate: false,
                ),
                size: 3,
                scaleFactor: _boxWidth * _bigNameFactor,
                maxLines: 3,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              ),

              /// COMPANY TYPE AND FORM
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BzTypesLine(
                  bzModel: bzModel,
                  width: logoSize * 2,
                ),
              ),

              /// ZONE
              if (bzModel?.zone != null)
              ZoneLine(
                width: _boxWidth,
                zoneModel: bzModel?.zone,
              ),


            ],
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
