import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:bldrs/b_views/widgets/general/loading/loading.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/final_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HomeScreenView({Key key}) : super(key: key);
  /// --------------------------------------------------------------------------
  static const Widget doubleSpacer = SizedBox(
    height: Ratioz.appBarMargin * 2,
    width: Ratioz.appBarMargin * 2,
  );
// -----------------------------------------------------------------------------
  static const Widget spacer = SizedBox(
    height: Ratioz.appBarMargin,
    width: Ratioz.appBarMargin,
  );
// -----------------------------------------------------------------------------
  static List<Widget> _getSignedInUserHomeWallWidgets(BuildContext context){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final List<BzModel> _userBzz = _bzzProvider.myBzz;
    final double _sponsoredFlyerWidth = FlyerBox.width(context, 0.45);

    final List<Widget> _homeWallWidgets = <Widget>[
      /// BUSINESSES
      BzzBubble(
        bzzModels: _userBzz,
        numberOfRows: 1,
        onTap: (String value) {
          blog(value);
        },
        title:
        '${TextGen.bldrsTypePageTitle(context, BzType.designer)} in Province',
      ),

      HomeScreenView.spacer,

      /// PROMOTED
      Container(
        width: Scale.superScreenWidth(context),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child: SuperVerse(
                verse: 'Promoted',
                size: 1,
                centered: false,
                italic: true,
                color: Colorz.white125,
              ),
            ),
            HomeScreenView.spacer,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //         // Ask(
                //         //   tappingAskInfo: () {blog('Ask info is tapped aho');},
                //         // ),

                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(
                    flyerBoxWidth: _sponsoredFlyerWidth,
                    goesToEditor: false,
                  ),
                  onFlyerZoneTap: null,
                ),

                HomeScreenView.spacer,

                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(
                      flyerBoxWidth: _sponsoredFlyerWidth, goesToEditor: false),
                  onFlyerZoneTap: null,
                ),
              ],
            ),
          ],
        ),
      ),

      HomeScreenView.spacer,
      HomeScreenView.spacer,

      /// NEW FLYERS
      FlyersShelf(
        // flyersType: FlyerType.rentalProperty,
        title: 'New By section flyers in Heliopolis',
        flyers: FlyerModel.dummyFlyers(),
      ),

      HomeScreenView.spacer,
      HomeScreenView.spacer,

      /// RECENTLY VIEWED
      FlyersShelf(
        // flyersType: FlyerType.rentalProperty,
        title: 'Recently viewed flyers',
        flyers: FlyerModel.dummyFlyers(),
      ),

      const Horizon(),
    ];

    return _homeWallWidgets;
  }
// -----------------------------------------------------------------------------
  static List<Widget> _getAnonymousUserHomeWallWidgets(BuildContext context){

    // final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: true);
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final String _cityName = _zoneProvider.getCurrentCityName(context);

    final double _sponsoredFlyerWidth = FlyerBox.width(context, 0.45);

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: true);
    final List<FlyerModel> _promotedFlyers = _flyersProvider.promotedFlyers;

    final List<Widget> _homeWallWidgets = <Widget>[

      /// PROMOTED
      Container(
        width: Scale.superScreenWidth(context),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child: SuperVerse(
                verse: 'Promoted',
                size: 1,
                centered: false,
                italic: true,
                color: Colorz.white125,
              ),
            ),

            HomeScreenView.spacer,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                //         // Ask(
                //         //   tappingAskInfo: () {blog('Ask info is tapped aho');},
                //         // ),

                if (canLoopList(_promotedFlyers) == true)
                  FinalFlyer(
                    flyerBoxWidth: _sponsoredFlyerWidth,
                    onSwipeFlyer: (){},
                    flyerModel: _promotedFlyers[0],
                  ),

                if (canLoopList(_promotedFlyers) == false)
                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(
                    flyerBoxWidth: _sponsoredFlyerWidth,
                    goesToEditor: false,
                  ),
                  onFlyerZoneTap: null,
                ),

                HomeScreenView.spacer,

                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: _sponsoredFlyerWidth, goesToEditor: false),
                  onFlyerZoneTap: null,
                ),

              ],
            ),

          ],
        ),
      ),

      HomeScreenView.doubleSpacer,

      /// NEW FLYERS
      FlyersShelf(
        // flyersType: FlyerType.rentalProperty,
        title: 'New Flyers in $_cityName',
        flyers: FlyerModel.dummyFlyers(),
      ),

      HomeScreenView.doubleSpacer,

      /// RECENTLY VIEWED
      FlyersShelf(
        // flyersType: FlyerType.rentalProperty,
        title: 'Recently viewed flyers',
        flyers: FlyerModel.dummyFlyers(),
      ),

      const Horizon(),
    ];

    return _homeWallWidgets;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: true);

    final List<Widget> _homeWallWidgets = userIsSignedIn() == true ?
    _getSignedInUserHomeWallWidgets(context)
        :
    _getAnonymousUserHomeWallWidgets(context);

    if (_uiProvider.isLoading == true){
      return const LoadingFullScreenLayer();
    }

    else {
      return ListView.builder(
        padding: const EdgeInsets.only(top: Ratioz.stratosphere),
        physics: const BouncingScrollPhysics(),
        itemCount: _homeWallWidgets.length,
        itemBuilder: (BuildContext ctx, int index) {
          return _homeWallWidgets[index];
        },
      );
    }

  }
}
