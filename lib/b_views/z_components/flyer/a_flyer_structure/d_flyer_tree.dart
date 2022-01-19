import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/new_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/a_flyer_header.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/header_controller.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    @required this.flyerModel,
    @required this.bzModel,
    this.flyerWidthFactor = 1,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerWidthFactor;
  final Function onTap;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  /// --------------------------------------------------------------------------
  static const double flyerSmallWidth = 200;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = FlyerBox.width(context, flyerWidthFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, _flyerBoxWidth);

    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);

    // blog('THE Fu*king thing is doing good aho yabn el gazma : sizeFactor : $flyerWidthFactor');

    return FlyerBox(
      flyerWidthFactor: flyerWidthFactor,
      stackWidgets: <Widget>[

        /// SLIDES
        AbsorbPointer(
          child: ZoomablePicture(
            isOn: false,
            onTap: null,
            child: Image.network(
              flyerModel.slides[0].pic,
              fit: BoxFit.fitWidth,
              width: _flyerBoxWidth,
              height: _flyerZoneHeight,
            ),
          ),
        ),

        /// HEADER
        Positioned(
          top: 0,
          child: FlyerHeader(
            flyerBoxWidth: _flyerBoxWidth,
            flyerModel: flyerModel,
            bzModel: bzModel,
          ),
        ),

        /// FOOTER
        Positioned(
          bottom: 0,
          child: Container(
            width: _flyerBoxWidth,
            height: _footerHeight,
            color: Colorz.blue255,
          ),
        ),

        /// PROGRESS BAR


        /// PRICE TAG

      ],
    );

  }
}
