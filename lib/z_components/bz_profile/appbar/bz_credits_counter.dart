import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class BzCreditsCounterX extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzCreditsCounterX({
    required this.width,
    required this.slidesCredit,
    required this.ankhsCredit,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double width;
  final String slidesCredit;
  final String ankhsCredit;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      height: Ratioz.appBarButtonSize,
      width: width,
      decoration: BoxDecoration(
        // color: Colorz.White30,
        borderRadius: Borderers.cornerAll(Ratioz.appBarButtonCorner * 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          CreditsRow(
            width: width,
            icon: Iconz.love,
            value: ankhsCredit,
          ),

          CreditsRow(
            width: width,
            icon: Iconz.flyer,
            value: slidesCredit,
          ),

        ],
      ),
    );

  }
  /// --------------------------------------------------------------------------
}

class CreditsRow extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CreditsRow({
    required this.icon,
    required this.value,
    required this.width,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String icon;
  final String value;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        Container(
          width: width * 0.65,
          height: Ratioz.appBarButtonSize * 0.4,
          alignment: BldrsAligners.superInverseCenterAlignment(context),
          child: BldrsText(
            verse: Verse(
              id: value,
              translate: false,
            ),
            size: 1,
            italic: true,
            weight: VerseWeight.thin,
          ),
        ),

        BldrsBox(
          width: width * 0.35,
          height: Ratioz.appBarButtonSize * 0.4,
          icon: icon,
          iconSizeFactor: 0.9,
          bubble: false,
          // color: Colorz.BloodTest,
        ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
