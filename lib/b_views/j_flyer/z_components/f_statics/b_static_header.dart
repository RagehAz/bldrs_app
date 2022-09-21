import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/a_structure/b_header_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/d_bz_logo.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/b_convertible_header/ff_header_labels.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StaticHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticHeader({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.authorID,
    @required this.flyerShowsAuthor,
    this.opacity = 1,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double opacity;
  final BzModel bzModel;
  final String authorID;
  final Function onTap;
  final bool flyerShowsAuthor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Opacity(
      key: const ValueKey<String>('StaticHeader'),
      opacity: opacity,
      child: HeaderBox(
        tinyMode: false,
        onHeaderTap: onTap,
        headerBorders: FlyerBox.superHeaderCorners(
          context: context,
          flyerBoxWidth: flyerBoxWidth,
          bzPageIsOn: false,
        ),
        flyerBoxWidth: flyerBoxWidth,
        headerColor: Colorz.black255,
        headerHeightTween: FlyerBox.headerBoxHeight(flyerBoxWidth: flyerBoxWidth),
        stackChildren: <Widget>[

          Row(
            children: <Widget>[

              BzLogo(
                width: FlyerBox.logoWidth(bzPageIsOn: false, flyerBoxWidth: flyerBoxWidth),
                image: bzModel.logo,
                tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
                corners: FlyerBox.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth),
                zeroCornerIsOn: flyerShowsAuthor,
              ),

              HeaderLabels(
                flyerBoxWidth: flyerBoxWidth,
                authorID: authorID,
                bzModel: bzModel,
                headerIsExpanded: false,
                flyerShowsAuthor: flyerShowsAuthor,
              ),

            ],
          ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
