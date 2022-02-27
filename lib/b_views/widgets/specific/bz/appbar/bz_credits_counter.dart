import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

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
        borderRadius:
            Borderers.superBorderAll(context, Ratioz.appBarButtonCorner * 0.5),
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
      children: <Widget>[
        DreamBox(
          width: width * 0.35,
          height: Ratioz.appBarButtonSize * 0.4,
          icon: icon,
          iconSizeFactor: 0.8,
          bubble: false,
          // color: Colorz.BloodTest,
        ),
        SizedBox(
          width: width * 0.65,
          height: Ratioz.appBarButtonSize * 0.4,
          child: SuperVerse(
            verse: value,
            size: 1,
            italic: true,
            centered: false,
          ),
        ),
      ],
    );
  }
}
