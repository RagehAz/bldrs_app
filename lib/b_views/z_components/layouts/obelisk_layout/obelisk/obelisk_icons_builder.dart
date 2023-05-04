import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_icon.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskIconsBuilder extends StatelessWidget{
  /// --------------------------------------------------------------------------
  const ObeliskIconsBuilder({
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
      key: const ValueKey<String>('ObeliskIconsBuilder'),
      selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
      builder: (_, bool expanded, Widget child) {

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

      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        children: <Widget>[

          Column(
            mainAxisAlignment: Obelisk.stuffAlignment(isCross: false),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              ...List.generate(navModels.length, (index){

                return ObeliskIcon(
                  onTap: () => onRowTap(index),
                  progressBarModel: progressBarModel,
                  navModelIndex: index,
                  navModel: navModels[index],
                );

              }),
            ],
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
