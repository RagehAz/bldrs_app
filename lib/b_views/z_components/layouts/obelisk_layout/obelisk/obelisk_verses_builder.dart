import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_verse.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_fader/widget_fader.dart';

class ObeliskVersesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVersesBuilder({
    @required this.navModels,
    @required this.progressBarModel,
    @required this.onRowTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<NavModel> navModels;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ValueChanged<int> onRowTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
      key: const ValueKey<String>('ObeliskVersesBuilder'),
      selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
      builder: (_, bool expanded, Widget child) {

          return WidgetFader(
            fadeType: expanded == null ? FadeType.stillAtMin : expanded == true ? FadeType.fadeIn : FadeType.fadeOut,
            curve: expanded == true ? Curves.easeOutQuart : Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            builder: (double value, Widget child){

              // blog('value is : $value : is Big is : $isBig');

              return Transform.scale(
                scaleX: value,
                alignment: Alignment.centerLeft,
                child: child,
              );

            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: expanded == true ? 150 : 500),
              curve: expanded == true ? Curves.easeOutBack : Curves.easeOutQuart,
              opacity: expanded == true ? 1 : 0.5,
              child: child,
            ),

          );

        },

      child: SizedBox(
        // color: Colorz.white20,
        height: Obelisk.gotContentsScrollableHeight(
          context: context,
          navModels: navModels,
        ),
        child: Column(
          mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
          crossAxisAlignment: UiProvider.checkAppIsLeftToRight(context) ?
          CrossAxisAlignment.start
              :
          CrossAxisAlignment.end,
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
      ),
    );

  }
/// --------------------------------------------------------------------------
}
