import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/zone_line.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class BzBanner extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzBanner({
    this.bzModel,
    this.size = 100,
    this.margins = 30,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double size;
  final dynamic margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = bzModel ?? BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

    final EdgeInsets _margins = superMargins(margins: margins);

    return Padding(
      padding: _margins,
      child: Column(
        children: <Widget>[

          /// LOGO
          BzLogo(
            width: size,
            image: _bzModel?.logo,
          ),

          /// NAME
          SuperVerse(
            verse: _bzModel?.name,
            size: 4,
            maxLines: 3,
          ),

          /// ZONE
          ZoneLine(
            zoneModel: _bzModel.zone,
          ),

        ],
      ),
    );
  }
}
