import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class BzCreditsCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzCreditsCounter({
    @required this.width,
    @required this.slidesCredit,
    @required this.ankhsCredit,
    Key key,
  }) : super(key: key);
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
        borderRadius: Borderers.cornerAll(context, Ratioz.appBarButtonCorner * 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          CreditsRow(
            width: width,
            icon: Iconz.save,
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
    @required this.icon,
    @required this.value,
    @required this.width,
    Key key,
  }) : super(key: key);
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
