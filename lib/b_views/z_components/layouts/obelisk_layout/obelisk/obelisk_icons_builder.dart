import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_icon.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskIconsBuilder extends StatelessWidget{
  /// --------------------------------------------------------------------------
  const ObeliskIconsBuilder({
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
      key: const ValueKey<String>('ObeliskIconsBuilder'),
      valueListenable: isExpanded,
      builder: (_, bool isBig, Widget xChild){

        // return Container();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: isBig == true ? Curves.ease : Curves.easeInExpo,
          width: isBig == true ? Obelisk.circleWidth : 0,
          height: Obelisk.getBoxMaxHeight(
            isBig: true,
            numberOfButtons: NavModel.getNumberOfButtons(navModels),
          ),
          alignment: Alignment.bottomLeft,
          child: xChild,
        );

      },

      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
