import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerTree({
    this.flyerWidthFactor = 1,
    this.onTap,
    this.flyerModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerWidthFactor;
  final Function onTap;
  final FlyerModel flyerModel;
  /// --------------------------------------------------------------------------
  static const double flyerSmallWidth = 200;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = OldFlyerBox.width(context, flyerWidthFactor);
    final double _flyerZoneHeight = OldFlyerBox.height(context, _flyerBoxWidth);
    final double _headerHeight = OldFlyerBox.headerBoxHeight(
      flyerBoxWidth: _flyerBoxWidth,
      bzPageIsOn: false,
    );

    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);

    blog('THE Fu*king thing is doing good aho yabn el gazma : sizeFactor : $flyerWidthFactor');

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
          child: Container(
            width: _flyerBoxWidth,
            height: _headerHeight,
            color: Colorz.yellow255,
            child: Row(
              // children: const [
              //
              //   // Container(
              //   //   width: _headerHeight,
              //   //   height: _headerHeight,
              //   //   color: Colorz.white50,
              //   // ),
              //   //
              //   // const Expander(),
              //
              // ],
            ),
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
