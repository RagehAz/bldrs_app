import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/z_archives/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_archives/obelisk_layout/obelisk/obelisk_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basics/animators/widgets/widget_fader.dart';

class ObeliskVersesBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskVersesBuilder({
    required this.navModels,
    required this.progressBarModel,
    required this.onRowTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<NavModel?> navModels;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final ValueChanged<int> onRowTap;
  /// --------------------------------------------------------------------------
  CrossAxisAlignment _getCrossAlignment(BuildContext context) {
    CrossAxisAlignment _crossAlignment;

    final bool _isWideScreen = Obelisk.isWideScreenObelisk(context);

    if (_isWideScreen == true) {
      _crossAlignment = CrossAxisAlignment.end;
    } else {
      if (UiProvider.checkAppIsLeftToRight() == true) {
        _crossAlignment = CrossAxisAlignment.start;
      } else {
        _crossAlignment = CrossAxisAlignment.end;
      }
    }

    return _crossAlignment;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final bool _isWideScreen = Obelisk.isWideScreenObelisk(context);
    final CrossAxisAlignment _crossAlignment = _getCrossAlignment(context);

    return Selector<UiProvider, bool>(
      key: const ValueKey<String>('ObeliskVersesBuilder'),
      selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
      builder: (_, bool? expanded, Widget? child) {

        final bool _isExpanded = Mapper.boolIsTrue(expanded);

          return WidgetFader(
            fadeType: expanded == null ? FadeType.stillAtMin : expanded == true ? FadeType.fadeIn : FadeType.fadeOut,
            curve: _isExpanded  == true ? Curves.easeOutQuart : Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            builder: (double value, Widget? child){

              // blog('value is : $value : is Big is : $isBig');

              return Transform.scale(
                scaleX: value,
                alignment: _isWideScreen == true ? Alignment.centerRight : Alignment.centerLeft,
                child: child,
              );

            },
            child: AnimatedOpacity(
              duration: Duration(milliseconds: _isExpanded == true ? 150 : 500),
              curve: _isExpanded == true ? Curves.easeOutBack : Curves.easeOutQuart,
              opacity: _isExpanded == true ? 1 : 0.5,
              child: child,
            ),

          );

        },

      child: FloatingList(
        height: Obelisk.gotContentsScrollableHeight(
          context: context,
          navModels: navModels,
        ),
        width: 200,
        mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
        crossAxisAlignment: _crossAlignment,
        physics: const NeverScrollableScrollPhysics(),
        columnChildren: <Widget>[

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

      // child: SizedBox(
      //   height: Obelisk.gotContentsScrollableHeight(
      //     context: context,
      //     navModels: navModels,
      //   ),
      //   child: SingleChildScrollView(
      //     physics: const NeverScrollableScrollPhysics(),
      //     child: Column(
      //       mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
      //       crossAxisAlignment: _crossAlignment,
      //       children: <Widget>[
      //
      //         ...List.generate(navModels.length, (index){
      //
      //           return ObeliskVerse(
      //             onTap: () => onRowTap(index),
      //             progressBarModel: progressBarModel,
      //             navModelIndex: index,
      //             navModel: navModels[index],
      //
      //           );
      //
      //         }),
      //
      //       ],
      //     ),
      //   ),
      // ),
    );

  }
/// --------------------------------------------------------------------------
}
