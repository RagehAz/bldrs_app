import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:flutter/material.dart';

class BtSearch extends StatelessWidget {
  final bool btSearchIsBackBt;
  final Function tappingBack;

  BtSearch({
    this.btSearchIsBackBt = false,
    this.tappingBack,
});

  @override
  Widget build(BuildContext context) {

      // double authorPictureCornerValue = MediaQuery.of(context).size.height * 0.015;
      double box1Width = 40;
      double box1Height = 40;

      String btIcon = btSearchIsBackBt == true ? superBackIcon(context) : Iconz.Search ;

      void tappingTheGodDamnSearchButton(){
        btSearchIsBackBt == true ?
        tappingBack() :
        goToRoute(context, Routez.Search);
      }

    return Container(
      width: Ratioz.ddAppBarHeight,
      height: Ratioz.ddAppBarHeight,
      child: DreamBox(
        height: box1Height,
        width: box1Width,
        icon: btIcon,
        boxMargins: EdgeInsets.symmetric(horizontal: (Ratioz.ddAppBarHeight - box1Height)/2),
        corners: Ratioz.ddAppBarButtonCorner,
        iconSizeFactor: btSearchIsBackBt == true ? 1 : 0.5,
        iconRounded: false,
        boxFunction: tappingTheGodDamnSearchButton,
      ),
    );
  }
}
