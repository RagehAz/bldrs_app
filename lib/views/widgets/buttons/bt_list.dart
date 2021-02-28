import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/text_directionerz.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/appbar/ab_localizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dream_box.dart';

enum MapValueIs{
  icon,
  flag,
  String,
}

class ButtonsList extends StatelessWidget {
  final List<Map<String, String>> listOfMaps;
  final MapValueIs mapValueIs;
  final Alignment alignment;
  final Function buttonTap;
  final CountryProvider provider;
  final LocalizerPage localizerPage;

  ButtonsList({
    @required this.listOfMaps,
    this.mapValueIs = MapValueIs.String,
    @required this.alignment,
    @required this.buttonTap,
    @required this.provider,
    this.localizerPage = LocalizerPage.Country,
  });

  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double _abPadding =  Ratioz.ddAppBarPadding;
    double _inBarClearWidth = superScreenWidth(context)
        - (Ratioz.ddAppBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = superScreenHeight(context) - Ratioz.ddPyramidsHeight;
    double _listHeight = _abHeight - Ratioz.ddAppBarHeight - (_abPadding) - 55 - 55; // each 55 is for confirm button & title, 50 +5 margin
    double _listCorner = Ratioz.ddAppBarCorner - _abPadding;

    // double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);
    // double _countryNameButtonWidth = _inBarClearWidth - _abPadding*3 - 35;


    return Container(
      height: _listHeight,
      width: _inBarClearWidth,
      margin: EdgeInsets.only(top: _abPadding),
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: superBorderAll(context, _listCorner),
      ),
      child: ListView.builder(
        itemCount: listOfMaps.length,

        itemBuilder: (context, index){

          String id = listOfMaps[index]['id'];
          String value = listOfMaps[index]['value'];

          return
            ChangeNotifierProvider.value(
              value: provider,
              child: Align(
                alignment: alignment,
                child: DreamBox(
                    height: 35,
                    icon: mapValueIs == MapValueIs.flag ? getFlagByIso3(id) : null,
                    iconSizeFactor: 0.8,
                    verse: value,
                    bubble: false,
                    boxMargins: EdgeInsets.all(5),
                    verseScaleFactor: 0.8,
                    color: Colorz.WhiteAir,
                    textDirection: localizerPage == LocalizerPage.BottomSheet? superTextDirection(context) : superInverseTextDirection(context),
                    boxFunction: () => buttonTap(id),
                ),
              ),
            );
        },
      ),

    );
  }
}
