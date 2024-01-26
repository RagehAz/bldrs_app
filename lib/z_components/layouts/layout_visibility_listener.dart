import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutVisibilityListener extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LayoutVisibilityListener({
    required this.isOn,
    required this.child,
    this.ignorePointer = false,
    super.key
  });
  // --------------------
  final bool? isOn;
  final Widget child;
  final bool ignorePointer;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (Mapper.boolIsTrue(isOn) == false){
      return child;
    }

    else {

      return Selector<UiProvider, bool>(
        selector: (_, UiProvider uiProvider) => uiProvider.layoutIsVisible,
        builder: (_, bool isVisible, Widget? theChild) {

          return IgnorePointer(
            ignoring: (!isVisible) || ignorePointer,
            child: WidgetFader(
              fadeType: isVisible == false ? FadeType.fadeOut : FadeType.fadeIn,
              duration: const Duration(milliseconds: 300),
              child: theChild,
            ),
          );

        },

        child: child,
      );

    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
