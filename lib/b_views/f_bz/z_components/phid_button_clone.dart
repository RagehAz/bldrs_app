import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/f_phid_button.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class PhidButtonClone extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidButtonClone({
    required this.onTap,
    required this.isSelected,
    this.verse,
    this.icon,
    super.key
  });
  // --------------------
  final Verse? verse;
  final dynamic icon;
  final bool isSelected;
  final Function onTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
      height: PhidButton.getHeight(),
      verse: verse,
      icon: icon,
      iconSizeFactor: PhidButton.getVerseScaleFactor(xIsOn: false),
      color: isSelected == true ? Colorz.yellow125 : Colorz.white20,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enRight: 5,
      ),
      onTap: onTap,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
