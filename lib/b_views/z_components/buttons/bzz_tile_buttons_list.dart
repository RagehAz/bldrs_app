import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_long_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

class BzzTilesButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzzTilesButtonsList({
    required this.bzzModel,
    required this.selectedBzz,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<BzModel>> bzzModel;
  final ValueNotifier<List<BzModel>> selectedBzz;
  final ValueChanged<BzModel>? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: bzzModel,
        builder: (_, List<BzModel> foundBzz, Widget? child){

          /// FOUND BZZ
          if (Mapper.checkCanLoopList(foundBzz) == true){

            return ValueListenableBuilder(
              valueListenable: selectedBzz,
              builder: (_, List<BzModel>? selectedBzz, Widget? child){

                return SizedBox(
                  width: Scale.screenWidth(context),
                  height: Scale.screenHeight(context),
                  child: ListView.builder(
                    itemCount: foundBzz.length,
                    physics: const NeverScrollableScrollPhysics(),
                    // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
                    itemBuilder: (_, index){

                      final BzModel _bzModel = foundBzz[index];
                      final bool _isSelected = BzModel.checkBzzContainThisBz(
                        bzz: selectedBzz,
                        bzModel: _bzModel,
                      );

                      return BzLongButton(
                        bzModel: _bzModel,
                        isSelected: _isSelected,
                        onTap: () => onTap?.call(_bzModel),
                      );

                    },
                  ),
                );

              },
            );

          }

          /// NO BZZ FOUND
          else {
            return const BldrsText(
              verse: Verse(
                pseudo: 'No Businesses found',
                id: 'phid_no_bzz_found',
                translate: true,
              ),
            );
          }

        }
    );

  }
  /// --------------------------------------------------------------------------
}
