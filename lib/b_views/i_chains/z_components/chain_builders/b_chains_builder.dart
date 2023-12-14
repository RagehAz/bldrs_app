import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/i_chains/z_components/chain_builders/a_chain_splitter.dart';
import 'package:flutter/material.dart';

class ChainsBuilder extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainsBuilder({
    required this.sons,
    required this.previousPath,
    required this.width,
    required this.level,
    required this.selectedPhids,
    required this.initiallyExpanded,
    required this.secondLinesType,
    required this.searchText,
    required this.onPhidTap,
    required this.onPhidDoubleTap,
    required this.onPhidLongTap,
    required this.onExportSpecs,
    required this.zone,
    required this.onlyUseZoneChains,
    required this.isMultipleSelectionMode,
    required this.onDataCreatorKeyboardSubmitted,
    required this.isCollapsable,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic sons;
  final String? previousPath;
  final double width;
  final int? level;
  final List<String> selectedPhids;
  final bool initiallyExpanded;
  final ValueNotifier<dynamic> searchText;
  final ChainSecondLinesType secondLinesType;
  final Function(String? path, String? phid)? onPhidTap;
  final Function(String? path, String? phid)? onPhidDoubleTap;
  final Function(String? path, String? phid)? onPhidLongTap;
  final ValueChanged<List<SpecModel>>? onExportSpecs;
  final ZoneModel? zone;
  final ValueChanged<String?>? onDataCreatorKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseZoneChains;
  final bool isCollapsable;
  /// --------------------------------------------------------------------------
  static double getBottomMargin({
    required BuildContext context,
    required bool isCollapsable,
    required int? level,
  }){

    if (isCollapsable == true) {

      if (level == 0){
        return Ratioz.appBarPadding + MediaQuery.of(context).viewInsets.bottom;
      }

      else {
        return Ratioz.appBarPadding;
      }

    }

    else {
      return Ratioz.appBarPadding;
    }

  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _sonWidth = ChainButtonBox.getSonWidth(
      parentWidth: width,
      level: level,
    );

    if (Lister.checkCanLoop(sons) == false){
      return const SizedBox();
    }

    else {

      final double _bottomMargin = getBottomMargin(
        context: context,
        isCollapsable: isCollapsable,
        level: level,
      );

      return SizedBox(
        key: const ValueKey<String>('ChainsBuilder'),
        width: width,
        // height: /// TASK : YOU CAN CONCLUDE THIS : BUT ITS FUCKING DAMN HARD : BUT WILL DO IT SOME DAY, WE WILL MEET AGAIN ISA,
        child: ListView.builder(
          shrinkWrap: true, /// TASK : SO UNTIL YOU DEFINE THE LIST HEIGHT : WE WILL TOLERATE SHRINK WRAP UNTIL THEN
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: Ratioz.appBarPadding,
            bottom: _bottomMargin,
          ),
          itemCount: sons.length,
          itemBuilder: (_, int index){

            final dynamic son = sons[index];

            return Container(
              width: _sonWidth,
              margin: const EdgeInsets.only(
                bottom: Ratioz.appBarPadding,
                left: Ratioz.appBarPadding,
                right: Ratioz.appBarPadding,
              ),
              child: ChainSplitter(
                isCollapsable: isCollapsable,
                previousPath: previousPath,
                chainOrChainsOrSonOrSons: son,
                width: _sonWidth,
                selectedPhids: selectedPhids,
                initiallyExpanded: initiallyExpanded,
                level: (level??0)+1,
                searchText: searchText,
                secondLinesType: secondLinesType,
                onPhidTap: onPhidTap,
                onPhidDoubleTap: onPhidDoubleTap,
                onPhidLongTap: onPhidLongTap,
                onExportSpecs: onExportSpecs,

                isMultipleSelectionMode: isMultipleSelectionMode,
                onlyUseZoneChains: onlyUseZoneChains,
                zone: zone,
                onDataCreatorKeyboardSubmitted: onDataCreatorKeyboardSubmitted,

              ),
            );

          },

        ),

      );
    }

  }
  // -----------------------------------------------------------------------------
}
