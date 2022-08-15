import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verse.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskVersesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVersesBuilder({
    @required this.isExpanded,
    @required this.navModels,
    @required this.progressBarModel,
    @required this.onRowTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final List<NavModel> navModels;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ValueChanged<int> onRowTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('ObeliskVersesBuilder'),
      valueListenable: isExpanded,
      builder: (_, bool isBig, Widget xChild){

        // return Container();

          return WidgetFader(
            fadeType: isBig == null ? FadeType.stillAtMin : isBig == true ? FadeType.fadeIn : FadeType.fadeOut,
            curve: isBig == true ? Curves.easeOutBack : Curves.easeOutQuart,
            duration: const Duration(milliseconds: 200),
            builder: (double value, Widget child){

              return Transform.scale(
                scaleX: value,
                alignment: Alignment.centerLeft,
                child: child,
              );

            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: isBig == true ? 150 : 500),
              curve: isBig == true ? Curves.easeOutBack : Curves.easeOutQuart,
              opacity: isBig == true ? 1 : 0.5,
              child: xChild,
            ),

          );

        },

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          ...List.generate(navModels.length, (index){

            return ObeliskVerse(
              onTap: () => onRowTap(index),
              progressBarModel: progressBarModel,
              navModelIndex: index,
              navModel: navModels[index],
            );

          }),

        ],
      ),
    );

  }
}
