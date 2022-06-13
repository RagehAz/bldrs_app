import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verse.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskVersesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVersesBuilder({
    @required this.isExpanded,
    @required this.navModels,
    @required this.tabIndex,
    @required this.onRowTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final List<NavModel> navModels;
  final ValueNotifier<int> tabIndex;
  final ValueChanged<int> onRowTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskVersesBuilder'),
      valueListenable: isExpanded,
      builder: (_, bool isBig, Widget xChild){

          return WidgetFader(
            fadeType: isBig == null ? FadeType.stillAtMin : isBig == true ? FadeType.fadeIn : FadeType.fadeOut,
            curve: isBig == true ? Curves.easeInCirc : Curves.easeOutQuart,
            duration: const Duration(milliseconds: 250),
            builder: (double value, Widget child){

              return Transform.scale(
                scaleX: value,
                alignment: Alignment.centerLeft,
                child: child,
              );

            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: isBig == true ? 500 : 500),
              curve: Curves.easeOutQuint,
              opacity: isBig == true ? 1 : 0.5,
              child: xChild,
            ),

          );

        },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          ...List.generate(navModels.length, (index){

            return ObeliskVerse(
              onTap: () => onRowTap(index),
              currentTabIndex: tabIndex,
              navModelIndex: index,
              navModel: navModels[index],
            );

          }),

        ],
      ),
    );

  }
}
