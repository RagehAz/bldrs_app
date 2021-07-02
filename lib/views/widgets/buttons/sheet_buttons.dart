import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dream_box.dart';

enum MapValueIs{
  icon,
  flag,
  String,
}

class SheetButtons extends StatelessWidget {
  final List<Map<String, String>> listOfMaps;
  final MapValueIs mapValueIs;
  final Alignment alignment;
  final Function buttonTap;
  final CountryProvider provider;
  final BottomSheetType sheetType;

  SheetButtons({
    @required this.listOfMaps,
    this.mapValueIs = MapValueIs.String,
    @required this.alignment,
    @required this.buttonTap,
    @required this.provider,
    this.sheetType = BottomSheetType.Country,
  });

  @override
  Widget build(BuildContext context) {

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    double _abPadding =  Ratioz.appBarPadding;
    double _inBarClearWidth = Scale.superScreenWidth(context)
        - (Ratioz.appBarMargin * 2)
        - (_abPadding * 2);
    /// standard is Ratioz.ddAppBarHeight;
    double _abHeight = Scale.superScreenHeight(context) - Ratioz.pyramidsHeight;
    double _listHeight = _abHeight - Ratioz.appBarSmallHeight - (_abPadding) - 55 - 55; // each 55 is for confirm button & title, 50 +5 margin
    double _listCorner = Ratioz.appBarCorner - _abPadding;

    // double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);
    // double _countryNameButtonWidth = _inBarClearWidth - _abPadding*3 - 35;


    return Container(
      height: _listHeight,
      width: _inBarClearWidth,
      margin: EdgeInsets.only(top: _abPadding),
      decoration: BoxDecoration(
        color: Colorz.WhiteAir,
        borderRadius: Borderers.superBorderAll(context, _listCorner),
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
                    icon: mapValueIs == MapValueIs.flag ? Flagz.getFlagByIso3(id) : null,
                    iconSizeFactor: 0.8,
                    verse: value,
                    bubble: false,
                    margins: const EdgeInsets.all(5),
                    verseScaleFactor: 0.8,
                    color: Colorz.WhiteAir,
                    textDirection: sheetType == BottomSheetType.BottomSheet? superTextDirection(context) : superInverseTextDirection(context),
                    boxFunction: () => buttonTap(id),
                ),
              ),
            );
        },
      ),

    );
  }
}
