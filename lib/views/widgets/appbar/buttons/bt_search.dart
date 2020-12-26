import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
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
      final dynamic boxesColor = Colorz.Nothing;
      double box1Width = 40;
      double box1Height = 40;

      String btIcon = btSearchIsBackBt == true ? Iconz.Back : Iconz.Search ;

      void tappingTheGodDamnSearchButton(){
        btSearchIsBackBt == true ?
        tappingBack() :
        Navigator.pushNamed(context, Routez.Search) ;
      }

    return GestureDetector(
      onTap: tappingTheGodDamnSearchButton,

      child: Padding(
        padding: EdgeInsets.all(Ratioz.ddAppBarMargin * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            DreamBox(
              height: box1Height,
              width: box1Width,
              icon: btIcon,
              // iconColor: Colorz.BlackBlack,
              corners: Ratioz.ddAppBarButtonCorner,
              iconSizeFactor: btSearchIsBackBt == true ? 1 : 0.5,
              color: boxesColor,
              iconRounded: false,
            ),

          ],
        ),
      ),
    );
  }
}
