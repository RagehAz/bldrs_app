import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
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

      double _box1Width = 40;
      double _box1Height = 40;

      String _btIcon = btSearchIsBackBt == true ? Iconizer.superBackIcon(context) : Iconz.Search ;

      void _tappingTheGodDamnSearchButton(){
        btSearchIsBackBt == true ?
        tappingBack() :
        Nav.goToRoute(context, Routez.Search);
      }

    return
      btSearchIsBackBt == false ?

      Container(
        width: Ratioz.ddAppBarHeight,
        height: Ratioz.ddAppBarHeight,
        child: DreamBox(
          height: _box1Height,
          width: _box1Width,
          icon: _btIcon,
          boxMargins: EdgeInsets.symmetric(horizontal: (Ratioz.ddAppBarHeight - _box1Height)/2),
          corners: Ratioz.ddAppBarButtonCorner,
          iconSizeFactor: btSearchIsBackBt == true ? 1 : 0.5,
          iconRounded: false,
          boxFunction: _tappingTheGodDamnSearchButton,
        ),
      )

          :

      Container(
        width: Ratioz.ddAppBarHeight,
        height: Ratioz.ddAppBarHeight,
        alignment: Alignment.topCenter,
          child: BldrsBackButton(
            onTap: _tappingTheGodDamnSearchButton,
          )
      );

  }
}
