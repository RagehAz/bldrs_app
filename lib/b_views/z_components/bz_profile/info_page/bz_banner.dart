import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_types_line.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/zone_line.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzBanner({
    this.bzModel,
    this.boxWidth = 100,
    this.margins = 30,
    this.corners,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double boxWidth;
  final dynamic margins;
  final double corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    final double logoSize = (boxWidth ?? 100) * 0.5;

    return Container(
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.superBorderAll(context, corners ?? boxWidth * 0.1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      margin: superMargins(margins: margins),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// LOGO
          BzLogo(
            width: logoSize,
            image: _bzModel?.logo,
          ),

          /// NAME
          SuperVerse(
            verse: _bzModel?.name,
            size: 4,
            maxLines: 3,
          ),

          /// COMPANY TYPE AND FORM
          BzTypesLine(
            bzModel: _bzModel,
            width: logoSize * 2,
          ),

          /// ZONE
          if (_bzModel?.zone != null)
          ZoneLine(
            zoneModel: _bzModel?.zone,
          ),


        ],
      ),
    );
  }
}
