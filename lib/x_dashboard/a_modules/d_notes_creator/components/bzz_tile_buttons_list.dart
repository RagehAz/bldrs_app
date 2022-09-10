import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/x_dashboard/a_modules/f_bzz_manager/bz_long_button.dart';
import 'package:flutter/material.dart';

class BzzTilesButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzzTilesButtonsList({
    @required this.bzzModel,
    this.selectedBzz,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<BzModel>> bzzModel;
  final ValueNotifier<List<BzModel>> selectedBzz;
  final ValueChanged<BzModel> onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: bzzModel,
        builder: (_, List<BzModel> foundBzz, Widget child){

          /// FOUND BZZ
          if (Mapper.checkCanLoopList(foundBzz) == true){

            return ValueListenableBuilder(
              valueListenable: selectedBzz,
              builder: (_, List<BzModel> selectedBzz, Widget child){

                return SizedBox(
                  width: Scale.superScreenWidth(context),
                  height: Scale.superScreenHeight(context),
                  child: ListView.builder(
                    itemCount: foundBzz.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index){

                      final BzModel _bzModel = foundBzz[index];
                      final bool _isSelected = BzModel.checkBzzContainThisBz(
                        bzz: selectedBzz,
                        bzModel: _bzModel,
                      );

                      return BzLongButton(
                        bzModel: _bzModel,
                        isSelected: _isSelected,
                        onTap: () => onTap(_bzModel),
                      );

                    },
                  ),
                );

              },
            );

          }

          /// NO BZZ FOUND
          else {
            return const SuperVerse(
              verse:  'No Businesses found',
            );
          }

        }
    );

  }
  /// --------------------------------------------------------------------------
}
