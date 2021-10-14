import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/providers/zones/old_zone_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum MapValueIs{
  icon,
  flag,
  String,
}

class BottomDialogButtons extends StatelessWidget {
  final List<Map<String, String>> listOfMaps;
  final MapValueIs mapValueIs;
  final Alignment alignment;
  final Function buttonTap;
  final OldCountryProvider provider;
  final BottomSheetType sheetType;

  const BottomDialogButtons({
    @required this.listOfMaps,
    this.mapValueIs = MapValueIs.String,
    @required this.alignment,
    @required this.buttonTap,
    @required this.provider,
    this.sheetType = BottomSheetType.Country,
  });

  @override
  Widget build(BuildContext context) {

    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);

    const double _abPadding =  Ratioz.appBarPadding;
    final double _dialogClearWidth = BottomDialog.dialogClearWidth(context);
    /// standard is Ratioz.ddAppBarHeight;
    final double _abHeight = Scale.superScreenHeight(context) - Ratioz.pyramidsHeight;
    final double _listHeight = _abHeight - Ratioz.appBarSmallHeight - (_abPadding) - 55 - 55; // each 55 is for confirm button & title, 50 +5 margin
    const double _listCorner = Ratioz.appBarCorner - _abPadding;

    // double _languageButtonHeight = Ratioz.ddAppBarHeight - (_abPadding *2);
    // double _countryNameButtonWidth = _dialogClearWidth - _abPadding*3 - 35;

    return Container(
      height: _listHeight - 256,
      width: _dialogClearWidth,
      margin: const EdgeInsets.only(top: _abPadding),
      decoration: BoxDecoration(
        color: Colorz.White10,
        borderRadius: Borderers.superBorderAll(context, _listCorner),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: listOfMaps.length,
        itemBuilder: (context, index){

          final String id = listOfMaps[index]['id'];
          final String value = listOfMaps[index]['value'];

          return
            ChangeNotifierProvider.value(
              value: provider,
              child: Align(
                alignment: alignment,
                child: DreamBox(
                    height: 35,
                    icon: mapValueIs == MapValueIs.flag ? Flagz.getFlagByCountryID(id) : null,
                    iconSizeFactor: 0.8,
                    verse: value,
                    bubble: false,
                    margins: const EdgeInsets.all(5),
                    verseScaleFactor: 0.8,
                    color: Colorz.White10,
                    textDirection: sheetType == BottomSheetType.BottomSheet? superTextDirection(context) : superInverseTextDirection(context),
                    onTap: () => buttonTap(id),
                ),
              ),
            );
        },
      ),

    );
  }
}
