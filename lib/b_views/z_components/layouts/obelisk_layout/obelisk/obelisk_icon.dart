import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';

class ObeliskIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskIcon({
    @required this.navModel,
    @required this.progressBarModel,
    @required this.navModelIndex,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NavModel navModel;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final int navModelIndex;
  final Function onTap;
  /// --------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ObeliskIcon'),
        valueListenable: progressBarModel,
        builder: (_, ProgressBarModel progressBarModel, Widget child){

          final bool _isSelected = progressBarModel?.index == navModelIndex;

          /// BUTTON CIRCLE
          if (navModel?.canShow == true){
            return GestureDetector(
              onTap: onTap,
              child: Container(
                height: Obelisk.circleWidth,
                width: Obelisk.circleWidth,
                color: Colorz.nothing,
                alignment: Alignment.centerLeft,
                child: Selector<NotesProvider, int>(
                  selector: (_, NotesProvider notesProvider){

                    final List<MapModel> _mapModels = notesProvider.obeliskBadges;

                    final MapModel _mapModel = MapModel.getModelByKey(
                        models: _mapModels,
                        key: navModel.id,
                    );

                    return _mapModel?.value;
                  },
                  shouldRebuild: (int last, int next){
                    return last != next;
                  },
                  builder: (_, int count, Widget child){

                    return NoteRedDotWrapper(
                      redDotIsOn: navModel?.forceRedDot == true || (count != null && count > 0),
                      count: count,
                      childWidth: Obelisk.circleWidth,
                      shrinkChild: true,
                      child: child,
                    );

                  },
                  child: DreamBox(
                    width: Obelisk.circleWidth,
                    height: Obelisk.circleWidth,
                    corners: Obelisk.circleWidth * 0.5,
                    color: _isSelected ? Colorz.yellow255 : Colorz.black255,
                    icon: navModel.icon,
                    iconColor: navModel.iconColor == Colorz.nothing ? null : _isSelected ? Colorz.black255 : Colorz.white255,
                    iconSizeFactor: navModel.iconSizeFactor ?? 0.45,
                    // margins: const EdgeInsets.only(bottom: 5),
                  ),
                ),
              ),
            );
          }

          /// NOTHING
          else if (navModel?.canShow == false){
            return const SizedBox();
          }

          /// SEPARATOR
          else {

            // final double rightShrinkage = NoteRedDotWrapper.getShrinkageDX(
            //     childWidth: Obelisk.circleWidth,
            //     isNano: false
            // );

            return AbsorbPointer(
              child: SizedBox(
                width: Obelisk.circleWidth,
                height: SeparatorLine.standardThickness + 10,
                // color: Colorz.bloodTest,
                // padding: EdgeInsets.only(right: rightShrinkage),
                // alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Transform.scale(
                    scale: NoteRedDotWrapper.getShrinkageScale(
                      isNano: false,
                      childWidth: Obelisk.circleWidth,
                    ),
                    alignment: BldrsAligners.superBottomAlignment(context),
                    child: const SeparatorLine(
                      width: Obelisk.circleWidth * 0.4,
                      color: Colorz.yellow200,
                    ),
                  ),
                ),
              ),
            );

          }

        }
    );

  }
/// --------------------------------------------------------------------------
}
