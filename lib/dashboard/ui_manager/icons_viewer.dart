import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/dashboard/widgets/wide_button.dart';
import 'package:bldrs/views/screens/a_4_loading_screen.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/dashboard_layout.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BldrsIconsViewer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    List<String> _icons = Iconz.allIconz();

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

    double _gridSpacing = Ratioz.appBarMargin;

    int _numberOfIconsInARow = 3;

    double _iconBoxSize = Scale.getUniformRowItemWidth(context, _numberOfIconsInARow);

    SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1.25,
      mainAxisExtent: _iconBoxSize * 1.25,
      crossAxisCount: _numberOfIconsInARow,
    );

    return MainLayout(
      sky: Sky.Black,
      pageTitle: 'UI Manager',
      loading: false,
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Basic,
      layoutWidget: GridView.builder(
        physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon, left: Ratioz.appBarMargin, right: Ratioz.appBarMargin),
          gridDelegate: _gridDelegate,
          itemCount: _icons.length,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          shrinkWrap: false,
          itemBuilder: (ctx, index){

            return

                Column(
                  children: <Widget>[

                    DreamBox(
                      height: _iconBoxSize,
                      width: _iconBoxSize,
                      icon: _icons[index],
                      iconSizeFactor: 1,
                      corners: 0,
                      color: Colorz.BloodTest,
                      bubble: false,
                    ),

                    Container(
                      width: _iconBoxSize,
                      height: _iconBoxSize * 0.25,
                      color: Colorz.Black255,
                      child: SuperVerse(
                        verse: TextMod.trimTextBeforeLastSpecialCharacter(_icons[index], '/'),
                        size: 1,
                        maxLines: 2,
                      ),
                    ),

                  ],
                );

          }
      ),
    );
  }
}
