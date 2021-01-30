import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalizerButton extends StatelessWidget {
  final Function onTap;

  LocalizerButton({
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _lastCountry = _countryPro.currentCountry;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              // width: 40,
              height: 40,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Ratioz.ddAppBarButtonCorner)),
                  color: Colorz.WhiteAir),
              child: ChangeNotifierProvider.value(
                value: _countryPro,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    // --- COUNTRY & CITY NAMES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.5),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            SuperVerse(
                              verse: translate(context, _lastCountry),
                              size: 1,
                            ),
                            SuperVerse(
                              verse: 'City Name',
                              size: 1,
                              scaleFactor: 0.8,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --- FLAG
                    DreamBox(
                      height: 30,
                      icon: _countryPro.superFlag(_lastCountry),
                      corners: Ratioz.ddBoxCorner,
                      boxMargins: EdgeInsets.symmetric(horizontal: 2.5),
                      boxFunction: onTap,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
