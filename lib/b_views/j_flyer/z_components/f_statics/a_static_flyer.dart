import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/b_static_header.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/static_footer.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class StaticFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticFlyer({
    @required this.bzModel,
    @required this.flyerModel,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FlyerBox(
      // key: const ValueKey<String>('StaticTinyFlyer'),
      flyerBoxWidth: flyerBoxWidth,
      // boxColor: Colorz.bloodTest,
      stackWidgets: <Widget>[

        StaticHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: bzModel,
          authorID: flyerModel.authorID,
          flyerShowsAuthor: flyerModel.showsAuthor,
          // opacity: 1,
          // onTap: ,
        ),

        Container(
          color: Colorz.bloodTest,
          child: StaticFooter(
            flyerBoxWidth: flyerBoxWidth,
          ),
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
