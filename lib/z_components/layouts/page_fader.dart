import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:flutter/material.dart';

class PageFader extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PageFader({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('should restart fade');
    // --------------------
    return WidgetFader(
      fadeType: FadeType.fadeIn,
      duration: const Duration(milliseconds: 800),
      restartOnRebuild: true,
      child: child,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
