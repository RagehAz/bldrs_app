import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/animators/widget_waiter.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/z_components/loading/linear_loading_box.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';

class LoadingTiles extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LoadingTiles({
    this.tileWidth,
    this.tileHeight,
    this.corners = Borderers.constantCornersAll12,
    this.color = Colorz.white20,
    this.hasStratosphere = true,
    super.key
  });
  // --------------------
  final double? tileWidth;
  final double? tileHeight;
  final dynamic corners;
  final Color color;
  final bool hasStratosphere;
  // --------------------------------------------------------------------------
  Widget _getTile({
    required Color color,
  }){

    final double _height = tileHeight ?? TileButton.defaultHeight;
    final double _width = Bubble.bubbleWidth(context: getMainContext(), bubbleWidthOverride: tileWidth);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: LinearLoadingBox(
        borderRadius: Borderers.superCorners(corners: corners),
        loadingColor: color,
        boxColor: color.withOpacity(color.opacity * 0.25),
        direction: Axis.vertical,
        height: _height * 2,
        width: _width,
      ),
    );

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return Column(
      children: <Widget>[

        if (hasStratosphere)
          const Stratosphere(),

        _getTile(
          color: color.withOpacity(0.09),
        ),

        WidgetWaiter(
          waitDuration: const Duration(milliseconds: 500),
          child: _getTile(
            color: color.withOpacity(0.06),
          ),
        ),

        WidgetWaiter(
          waitDuration: const Duration(milliseconds: 1000),
          child: _getTile(
            color: color.withOpacity(0.03),
          ),
        ),

      ],
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
