import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FlagBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlagBox({
    @required this.countryID,
    this.onTap,
    this.size = 35,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryID;
  final Function onTap;
  final double size;
  static const double corner = Ratioz.boxCorner12;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _flagIcon = Flag.getFlagIconByCountryID(countryID);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            // color: Colorz.bloodTest,
            borderRadius: BorderRadius.circular(corner),
            boxShadow: <BoxShadow>[
              Shadowz.CustomBoxShadow(
                  color: Colorz.black230,
                  blurRadius: size * 0.12,
                  style: BlurStyle.outer),
            ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(corner)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// FLAG
                WebsafeSvg.asset(_flagIcon, width: size),

              ///  BUTTON GRADIENT
              Container(
                height: size,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colorz.Grey,
                  borderRadius: BorderRadius.circular(corner),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colorz.black0, Colorz.black200],
                      stops: <double>[0.65, 1]),
                ),
              ),

              ///  BUTTON HIGHLIGHT
              Container(
                height: size,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colorz.Grey,
                  borderRadius: BorderRadius.circular(corner),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[Colorz.nothing, Colorz.white80],
                      stops: <double>[0.75, 1]
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
