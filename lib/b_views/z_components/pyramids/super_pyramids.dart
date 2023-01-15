import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_expanding_pyramid.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_pyramids.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_fader/widget_fader.dart';

class SuperPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperPyramids({
    @required this.progressBarModel,
    @required this.onRowTap,
    @required this.navModels,
    @required this.mounted,
    this.isYellow = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ValueChanged<int> onRowTap;
  final List<NavModel> navModels;
  final bool isYellow;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
      selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
      builder: (_, bool isVisible, Widget child) {

        return IgnorePointer(
          ignoring: !isVisible,
          child: WidgetFader(
            fadeType: isVisible == false ? FadeType.fadeOut : FadeType.fadeIn,
            duration: const Duration(milliseconds: 300),
            child: child,
          ),
        );

      },

      child: Stack(
            key: const ValueKey('SuperPyramids'),
            children: <Widget>[

              /// SINGLE PYRAMID
              const ObeliskExpandingPyramid(),

              /// OBELISK
              Obelisk(
                onRowTap: onRowTap,
                progressBarModel: progressBarModel,
                navModels: navModels,
              ),

              /// PYRAMIDS
              ObeliskPyramids(
                isYellow: isYellow,
                mounted: mounted,
              ),

            ],
          ),
    );

  }
// -----------------------------------------------------------------------------
}
