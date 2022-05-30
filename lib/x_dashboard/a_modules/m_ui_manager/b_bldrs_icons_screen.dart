import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class IconsViewerScreen extends StatelessWidget {

  const IconsViewerScreen({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<String> _icons = UiProvider.proGetLocalAssetsPaths(context); //Iconz.allIconz();

    const double _gridSpacing = Ratioz.appBarMargin;

    const int _numberOfIconsInARow = 3;

    final double _iconBoxSize = Scale.getUniformRowItemWidth(
        context: context,
        numberOfItems: _numberOfIconsInARow,
    );

    final SliverGridDelegate _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      childAspectRatio: 1 / 1.25,
      mainAxisExtent: _iconBoxSize * 1.25,
      crossAxisCount: _numberOfIconsInARow,
    );

    return MainLayout(
      skyType: SkyType.black,
      sectionButtonIsOn: false,
      zoneButtonIsOn: false,
      pageTitle: 'UI Manager',
      appBarType: AppBarType.basic,
      layoutWidget: Scroller(
        child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
                top: Ratioz.stratosphere,
                bottom: Ratioz.horizon,
                left: Ratioz.appBarMargin,
                right: Ratioz.appBarMargin),
            gridDelegate: _gridDelegate,
            itemCount: _icons.length,
            itemBuilder: (BuildContext ctx, int index) {

              return Column(
                children: <Widget>[

                  DreamBox(
                    height: _iconBoxSize,
                    width: _iconBoxSize,
                    icon: _icons[index],
                    corners: 0,
                    color: Colorz.bloodTest,
                    bubble: false,
                    onTap: () => copyToClipboard(
                        context: context,
                        copy: _icons[index],
                    ),
                  ),

                  DreamBox(
                    width: _iconBoxSize,
                    height: _iconBoxSize * 0.25,
                    color: Colorz.black255,
                    verse: TextMod.removeTextBeforeLastSpecialCharacter(_icons[index], '/'),
                    verseWeight: VerseWeight.thin,
                    verseScaleFactor: 0.5,
                  ),

                ],
              );
            }),
      ),
    );
  }
}
