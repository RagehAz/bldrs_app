import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk_expanding_pyramid.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk_pyramids.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basics/animators/widgets/widget_fader.dart';

class SuperPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperPyramids({
    required this.progressBarModel,
    required this.onRowTap,
    required this.navModels,
    required this.mounted,
    this.isYellow = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final ValueChanged<int> onRowTap;
  final List<NavModel?> navModels;
  final bool isYellow;
  final bool mounted;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('SuperPyramids.build() : ${context.hashCode}');

    return Selector<UiProvider, bool>(
      key: const ValueKey('SuperPyramids_tree'),
      selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
      builder: (_, bool isVisible, Widget? child) {

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
        key: const ValueKey('SuperPyramids_stack'),
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
