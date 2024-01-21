import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/buttons/expander_button/b_expanding_tile.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PhidsButtonsList extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidsButtonsList({
    required this.buttonWidth,
    required this.phids,
    required this.onPhidTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double buttonWidth;
  final List<String> phids;
  final Function onPhidTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: buttonWidth,
      height: BldrsExpandingButton.collapsedTileHeight * phids.length,
      margin: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      color: Colorz.bloodTest,
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: phids.length,
        itemExtent: BldrsExpandingButton.collapsedTileHeight + Ratioz.appBarPadding,
        // shrinkWrap: false,
        // padding: EdgeInsets.zero, /// AGAIN => ENTA EBN WES5A
        itemBuilder: (BuildContext ctx, int index) {

          final String _phid = phids[index];

          final String? _icon = StoragePath.phids_phid(_phid);

          /// DO_THE_TRANSLATE_PHID_to_second_lang
          const String? _arName = null;
          // _chainsProvider.translateChainPhid(
          //   phid: _phid,
          //   langCode: 'ar',
          // );

          return BldrsBox(
            height: BldrsExpandingButton.collapsedTileHeight,
            width: buttonWidth - (Ratioz.appBarMargin * 2),
            icon: _icon,
            verse: getVerse(_phid),
            secondLine: Verse.plain(_arName),
            verseScaleFactor: 0.7,
            verseCentered: false,
            bubble: false,
            color: Colorz.white20,
            margins: const EdgeInsets.only(
                bottom: BldrsExpandingButton.buttonVerticalPadding
            ),
            onTap: () async {
              await onPhidTap(_phid);
            },
          );

        },
      ),
    );

  }
/// --------------------------------------------------------------------------
}
