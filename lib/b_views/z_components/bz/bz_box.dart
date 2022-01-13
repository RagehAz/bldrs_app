import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzLogoBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzLogoBox({
    @required this.width,
    this.bzModel,
    this.showName = true,
    this.logoColor = Colorz.white10,
    this.zeroCornerIsOn = false,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final BzModel bzModel;
  final bool showName;
  final Color logoColor;
  final bool zeroCornerIsOn;
  final Function onTap;
  /// --------------------------------------------------------------------------
  static const double _boxAspectRatio = 1.25;
  static const double _nameHeightRatio = _boxAspectRatio - 1;
// -----------------------------------------------------------------------------
  static double boxHeight({@required double width, @required bool showName}){
    double _height = width;

    if (showName == true){
      _height = width * 1.25;
    }

    return _height;
  }
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    final double _boxHeight = boxHeight(
      width: width,
      showName: showName,
    );

    final dynamic _bzLogo = bzModel == null ? logoColor : bzModel.logo;
    final String _bzName = bzModel == null ? '...' : bzModel.name;

    return SizedBox(
      width: width,
      height: _boxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // /// LOGO
          // Container(
          //   width: width,
          //   height: width,
          //   decoration: BoxDecoration(
          //       color: logoColor,
          //       borderRadius: Borderers.superBorderAll(
          //           context,
          //           BzLogo.cornersValue(_logoWidth))),
          // ),

          /// BZ LOGO
          BzLogo(
            width: width,
            image: _bzLogo,
            zeroCornerIsOn: zeroCornerIsOn,
            onTap: onTap,
          ),


          /// BZ NAME FOOTPRINT
          if (showName == true)
          SizedBox(
            width: width,
            height: width * _nameHeightRatio,
            child: SuperVerse(
              verse: _bzName,
              weight: VerseWeight.black,
              scaleFactor: width / 120,
            ),
          ),

        ],
      ),
    );
  }
}
