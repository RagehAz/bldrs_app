import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppBarBlurLayer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AppBarBlurLayer({
    @required this.blurIsOn,
    @required this.appBarType,
    @required this.isExpanded,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final bool blurIsOn;
  final AppBarType appBarType;
  final ValueNotifier<bool> isExpanded;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (blurIsOn == true) {

      if (isExpanded == null){
        return BlurLayer(
          width: BldrsAppBar.width(context),
          height: BldrsAppBar.collapsedHeight(context, appBarType),
          blur: BldrsAppBar.blur,
          blurIsOn: true,
          color: Colorz.nothing,
          borders: BldrsAppBar.corners,
        );
      }
      else {
        return ClipRRect(
          borderRadius: BldrsAppBar.corners,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: BldrsAppBar.blur, sigmaY: BldrsAppBar.blur),
            child: ValueListenableBuilder(
                valueListenable: isExpanded,
                builder: (_, bool expanded, Widget child) {
                  return AnimatedContainer(
                    duration: BldrsAppBar.expansionDuration,
                    curve: BldrsAppBar.expansionCurve,
                    width: BldrsAppBar.width(context),
                    height: expanded == true ?
                    BldrsAppBar.expandedHeight(
                      context: context,
                      appBarType: appBarType,
                    )
                        :
                    BldrsAppBar.collapsedHeight(context, appBarType),
                  );
                }),
          ),
        );
      }
    }

    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
