import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_initializer.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/c_flyer_hero.dart';
import 'package:bldrs/b_views/z_components/flyer/flyer_full_screen.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheFlyerScreenForCreation extends StatelessWidget {

  const TheFlyerScreenForCreation({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _flyerBoxWidth = 200;

    final double gridZoneWidth = Scale.superScreenWidth(context);
    const double spacingRatioToGridWidth = 0.03;
    const int numberOfColumns = 3;
    final double gridFlyerWidth = gridZoneWidth / (numberOfColumns + (numberOfColumns * spacingRatioToGridWidth) + spacingRatioToGridWidth);



    final double gridSpacing = gridFlyerWidth * spacingRatioToGridWidth;


    final EdgeInsets _gridPadding = EdgeInsets.all(gridSpacing);

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    final double _minWidthFactor =  gridFlyerWidth / gridZoneWidth;

    return MainLayout(
      historyButtonIsOn: false,
      pyramidsAreOn: true,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      layoutWidget: Container(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeight(context),
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        color: Colorz.blue10,
        // child: Column(
        //   children: <Widget>[
        //     const Stratosphere(),
        //     HeroFlyerWidget(
        //       flyer: _flyer2,
        //       color: Colorz.green255,
        //     ),
        //     const Spacer(),
        //     HeroFlyerWidget(
        //       flyer: _flyer3,
        //       color: Colorz.red255,
        //     ),
        //   ],
        // ),

        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: _gridPadding,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
              maxCrossAxisExtent: gridFlyerWidth,
            ),
            itemCount: _flyersProvider.savedFlyers.length,
            itemBuilder: (BuildContext ctx, int index){

              const List<Color> _colorz = <Color>[
                Colorz.red255,
                Colorz.black255,
                Colorz.green255,
                Colorz.blue80,
                Colorz.white200,
                Colorz.darkRed255,
                Colorz.yellow200,
                Colorz.skyLightBlue,
                Colorz.grey50,
                Colorz.green125,
                Colorz.linkedIn,
                Colorz.cyan50,
                Colorz.yellow50,
              ];

              final Color _color = _colorz[index];

              final FlyerModel _flyer = _flyersProvider.savedFlyers[index];

              return
                  FlyerStarter(
                    flyerModel: _flyer,
                    isFullScreen: false,
                    minWidthFactor: _minWidthFactor,
                  );

            }
        ),

      ),
    );
  }
}
