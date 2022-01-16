
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class AbstractFlyer extends StatelessWidget {

  const AbstractFlyer({
    this.sizeFactor = 1,
    this.onTap,
    this.flyerModel,
    Key key,
  }) : super(key: key);

  final double sizeFactor;
  final Function onTap;
  final FlyerModel flyerModel;

  static const double flyerSmallWidth = 200;

  @override
  Widget build(BuildContext context) {

    final double _flyerBoxWidth = FlyerBox.width(context, sizeFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, _flyerBoxWidth);
    final double _headerHeight = FlyerBox.headerBoxHeight(
      flyerBoxWidth: _flyerBoxWidth,
      bzPageIsOn: false,
    );

    final BorderRadius _flyerBorders = FlyerBox.borders(context, _flyerBoxWidth);

    final double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);

    blog('THE Fu*king thing is doing good aho yabn el gazma : sizeFactor : $sizeFactor');

    return Container(
      width: _flyerBoxWidth,
      height: _flyerZoneHeight,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colorz.white20,
        borderRadius: _flyerBorders,
        // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
      ),
      child: ClipRRect(
        borderRadius: _flyerBorders,
        child: Stack(
          alignment: Alignment.topCenter,
          // children: stackWidgets ?? <Widget>[],
          children: <Widget>[

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
                  children: [

                    // Container(
                    //   width: _headerHeight,
                    //   height: _headerHeight,
                    //   color: Colorz.white50,
                    // ),
                    //
                    // const Expander(),

                  ],
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


          ],
        ),
      ),
    );

    return Container(
      width: _flyerBoxWidth,
      height: _flyerZoneHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          /// HEADER
          Positioned(
            top: 0,
            child: Container(
              width: _flyerBoxWidth,
              height: _headerHeight,
              color: Colorz.yellow255,
              child: Row(
                children: [

                  // Container(
                  //   width: _headerHeight,
                  //   height: _headerHeight,
                  //   color: Colorz.white50,
                  // ),
                  //
                  // const Expander(),

                ],
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

        ],
      ),
    );

  }
}
