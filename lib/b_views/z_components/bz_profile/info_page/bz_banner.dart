import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_slate/b_bz_logo/d_bz_logo.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/b_views/z_components/texting/customs/zone_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class BzBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzBanner({
    @required this.boxWidth,
    @required this.bigName,
    @required this.bzModel,
    this.boxHeight,
    this.corners,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double boxWidth;
  final double boxHeight;
  final double corners;
  final bool bigName;
  /// --------------------------------------------------------------------------
  /*
  static double getHeight(){

  }

  static double getWidth(){

  }
   */
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double logoSize = (boxWidth ?? 100) * 0.35;
    final double _bigNameFactor = bigName == true ? 0.0035 : 0.0028;

    return Center(
      child: Container(
        width: boxWidth,
        height: boxHeight,
        decoration: BoxDecoration(
          color: Colorz.white10,
          borderRadius: Borderers.cornerAll(context, corners ?? boxWidth * 0.1),
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
                verse: Verse(
                  id: bzModel?.name ?? '',
                  translate: false,
                ),
                size: 3,
                scaleFactor: boxWidth * _bigNameFactor,
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
