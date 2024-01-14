import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:basics/components/layers/blur_layer.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppBarBlurLayer extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const AppBarBlurLayer({
    required this.blurIsOn,
    required this.appBarType,
    required this.isExpanded,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool blurIsOn;
  final AppBarType? appBarType;
  final ValueNotifier<bool?>? isExpanded;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (blurIsOn == true) {

      if (isExpanded == null){
        return BlurLayer(
          width: BldrsAppBar.width(),
          height: BldrsAppBar.collapsedHeight(context, appBarType),
          blur: BldrsAppBar.blur,
          blurIsOn: true,
          color: kIsWeb == true ? Colorz.white10 : Colorz.nothing,
          borders: BldrsAppBar.corners,
        );
      }

      else {
        return ClipRRect(
          borderRadius: BldrsAppBar.corners,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: BldrsAppBar.blur, sigmaY: BldrsAppBar.blur),
            child: ValueListenableBuilder(
                valueListenable: isExpanded!,
                builder: (_, bool? expanded, Widget? child) {
                  return AnimatedContainer(
                    duration: BldrsAppBar.expansionDuration,
                    curve: BldrsAppBar.expansionCurve,
                    width: BldrsAppBar.width(),
                    height: Mapper.boolIsTrue(expanded) == true ?
                    BldrsAppBar.expandedHeight(
                      context: context,
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
