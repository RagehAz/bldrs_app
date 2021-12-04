import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BzCreditsCounter extends StatelessWidget {
  final double width;
  final String slidesCredit;
  final String ankhsCredit;

  const BzCreditsCounter({
    @required this.width,
    @required this.slidesCredit,
    @required this.ankhsCredit,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Ratioz.appBarButtonSize,
      width: width,
      decoration: BoxDecoration(
        // color: Colorz.White30,
        borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner * 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          CreditsRow(
            width: width,
            icon: Iconz.Save,
            value: ankhsCredit,
          ),

          CreditsRow(
            width: width,
            icon: Iconz.Flyer,
            value: slidesCredit,
          ),

        ],
      ),
    );
  }
}

class CreditsRow extends StatelessWidget {
  final String icon;
  final String value;
  final double width;

  const CreditsRow({
    @required this.icon,
    @required this.value,
    @required this.width,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        DreamBox(
          width: width * 0.35,
          height: Ratioz.appBarButtonSize * 0.4,
          icon: icon,
          iconSizeFactor: 0.8,
          bubble: false,
          // color: Colorz.BloodTest,
        ),

        Container(
          width: width * 0.65,
          height: Ratioz.appBarButtonSize * 0.4,
          child: SuperVerse(
            verse: '$value',
            size: 1,
            weight: VerseWeight.bold,
            italic: true,
            centered: false,
          ),
        ),

      ],
    );
  }
}
