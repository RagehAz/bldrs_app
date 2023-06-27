import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/bz_long_button.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

class BzzList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BzzList({
    required this.bzz,
    required this.scrollController,
    required this.width,
    this.selectedBzzIDs,
    this.onBzTap,
    this.scrollPadding,
    super.key
  });
  // -----------------------------------------------------------------------------
  final List<BzModel> bzz;
  final ScrollController scrollController;
  final double width;
  final List<String> selectedBzzIDs;
  final Function(BzModel bz) onBzTap;
  final EdgeInsets scrollPadding;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(bzz) == true){
      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: bzz.length,
        padding: scrollPadding ?? const EdgeInsets.only(bottom: 10, top: 10,),
        itemBuilder: (BuildContext ctx, int index) {

          final BzModel _bz = bzz[index];

          return BzLongButton(
            bzModel: _bz,
            boxWidth: width ?? PageBubble.width(context),
            showAuthorsPics: true,
            onTap: onBzTap == null ? null : () => onBzTap(_bz),
            isSelected: Stringer.checkStringsContainString(
              strings: selectedBzzIDs,
              string: _bz?.id,
            ),
          );

        },
      );
    }

    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
