import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/ask/new_questions_stuff/components/question_separator_line.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ObeliskIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ObeliskIcon({
    @required this.navModel,
    @required this.currentTabIndex,
    @required this.navModelIndex,
    @required this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NavModel navModel;
  final ValueNotifier<int> currentTabIndex;
  final int navModelIndex;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        key: const ValueKey<String>('ObeliskIcon'),
        valueListenable: currentTabIndex,
        builder: (_, int _tabIndex, Widget child){

          final bool _isSelected = _tabIndex == navModelIndex;

          /// BUTTON CIRCLE
          if (navModel?.canShow == true){
            return GestureDetector(
              onTap: onTap,
              child: Selector<NotesProvider, List<MapModel>>(
                selector: (_, NotesProvider notesProvider) => notesProvider.obeliskNotesNumber,
                shouldRebuild: (List<MapModel> a, List<MapModel> b){

                  // List<MapModel> _fromThere = NotesProvider.proGetObeliskNotesNumbers(context: context, listen: false);

                  MapModel.blogMapModels(
                    mapModels: a,
                    methodName: 'aaaaaaaaaaaaaaa',
                  );


                  MapModel.blogMapModels(
                    mapModels: b,
                    methodName: 'BBB',
                  );

                  return true;
                },
                builder: (_, List<MapModel> mapsModels, Widget child){

                  final MapModel _mapModel = MapModel.getModelByKey(
                      key: navModel.id,
                      models: mapsModels,
                  );

                  _mapModel?.blogMapModel();

                  return NoteRedDotWrapper(
                    redDotIsOn: _mapModel?.value != null,
                    count: _mapModel?.value,
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
                  margins: const EdgeInsets.only(bottom: 5),
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

            return const AbsorbPointer(
              child: SeparatorLine(
                width: Obelisk.circleWidth,
                margins: EdgeInsets.only(bottom: 10, top: 5),
              ),
            );

          }

        }
    );

  }
}
