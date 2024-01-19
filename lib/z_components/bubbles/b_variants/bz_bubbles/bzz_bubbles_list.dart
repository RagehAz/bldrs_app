import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/buttons/bz_buttons/bz_long_button.dart';
import 'package:flutter/material.dart';

class BzzBubblesList extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const BzzBubblesList({
    required this.bzz,
    required this.scrollController,
    this.selectedBzzIDs,
    this.onBzTap,
    this.scrollPadding,
    this.showBzzIDs = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final List<BzModel> bzz;
  final ScrollController? scrollController;
  final List<String>? selectedBzzIDs;
  final Function(BzModel bz)? onBzTap;
  final EdgeInsets? scrollPadding;
  final bool showBzzIDs;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(bzz) == true){
      return ListView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: bzz.length,
        padding: scrollPadding ?? const EdgeInsets.only(bottom: 10, top: 10,),
        itemBuilder: (BuildContext ctx, int index) {

          final BzModel _bz = bzz[index];

          return BzBubble(
            bzModel: _bz,
            // boxWidth: width ?? PageBubble.width(context),
            showAuthorsPics: true,
            onTap: onBzTap == null ? null : () => onBzTap?.call(_bz),
            isSelected: Stringer.checkStringsContainString(
              strings: selectedBzzIDs,
              string: _bz.id,
            ),
            boxWidth: Bubble.bubbleWidth(context: context),
            showID: showBzzIDs,
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
