import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class IconsViewerScreen extends StatelessWidget {
  const IconsViewerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<String> _icons = Iconz.allIconz();

    const double _gridSpacing = Ratioz.appBarMargin;

    const int _numberOfIconsInARow = 3;

    final double _iconBoxSize = Scale.getUniformRowItemWidth(context, _numberOfIconsInARow);

    final SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1.25,
      mainAxisExtent: _iconBoxSize * 1.25,
      crossAxisCount: _numberOfIconsInARow,
    );

    return MainLayout(
      skyType: SkyType.Black,
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
          itemBuilder: (BuildContext ctx, int index){

            return

                Column(
                  children: <Widget>[

                    DreamBox(
                      height: _iconBoxSize,
                      width: _iconBoxSize,
                      icon: _icons[index],
                      iconSizeFactor: 1,
                      corners: 0,
                      color: Colorz.bloodTest,
                      bubble: false,
                    ),

                    Container(
                      width: _iconBoxSize,
                      height: _iconBoxSize * 0.25,
                      color: Colorz.black255,
                      child: SuperVerse(
                        verse: TextMod.removeTextBeforeLastSpecialCharacter(_icons[index], '/'),
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
