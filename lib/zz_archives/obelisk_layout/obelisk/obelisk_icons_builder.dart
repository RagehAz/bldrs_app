import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/zz_archives/nav_model.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/zz_archives/obelisk_layout/obelisk/obelisk_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskIconsBuilder extends StatelessWidget{
  /// --------------------------------------------------------------------------
  const ObeliskIconsBuilder({
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
  @override
  Widget build(BuildContext context) {

    return Selector<UiProvider, bool>(
      key: const ValueKey<String>('ObeliskIconsBuilder'),
      selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
      builder: (_, bool expanded, Widget? child) {

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: expanded == true ? Curves.ease : Curves.easeInExpo,
          width: expanded == true ? Obelisk.circleWidth : 0,
          height: Obelisk.gotContentsScrollableHeight(
            context: context,
            navModels: navModels,
          ),
          alignment: Alignment.bottomLeft,
          child: child,
        );

      },

      child: SizedBox(
        height: Obelisk.gotContentsScrollableHeight(
          context: context,
          navModels: navModels,
        ),
        child: FloatingList(
          height: Obelisk.gotContentsScrollableHeight(
            context: context,
            navModels: navModels,
          ),
          mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
          physics: const NeverScrollableScrollPhysics(),
          columnChildren: <Widget>[

            ...List.generate(navModels.length, (index){

              final NavModel? _navModel = navModels[index];

              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                child: ObeliskIcon(
                  onTap: () => onRowTap(index),
                  progressBarModel: progressBarModel,
                  navModelIndex: index,
                  navModel: _navModel,
                  badge: null,
                ),
              );
            }),

          ],
        ),
      ),

      // child: ListView(
      //   scrollDirection: Axis.horizontal,
      //   padding: EdgeInsets.zero,
      //   children: <Widget>[
      //
      //     if (Lister.checkCanLoop(navModels) == true)
      //       SizedBox(
      //         height: Obelisk.gotContentsScrollableHeight(
      //           context: context,
      //           navModels: navModels,
      //         ),
      //         child: SingleChildScrollView(
      //           physics: const NeverScrollableScrollPhysics(),
      //           child: Column(
      //             mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
      //             // crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               ...List.generate(navModels.length, (index) {
      //                 return ObeliskIcon(
      //                   onTap: () => onRowTap(index),
      //                   progressBarModel: progressBarModel,
      //                   navModelIndex: index,
      //                   navModel: navModels[index],
      //                 );
      //               }),
      //             ],
      //           ),
      //         ),
      //       ),
      //
      //   ],
      // ),

    );

  }
  /// --------------------------------------------------------------------------
}
