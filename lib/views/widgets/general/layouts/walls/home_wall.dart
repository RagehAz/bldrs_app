import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/old_flyers_provider.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/general/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/general/layouts/walls/sequences_bubble.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyers_shelf.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWall extends StatefulWidget {

  @override
  _HomeWallState createState() => _HomeWallState();

  static const Widget spacer = const SizedBox(height: Ratioz.appBarMargin, width: Ratioz.appBarMargin,);

}

class _HomeWallState extends State<HomeWall> {

  @override
  Widget build(BuildContext context) {

    final OldFlyersProvider _prof = Provider.of<OldFlyersProvider>(context, listen: true);
    final List<TinyBz> _userTinyBzz = _prof.getUserTinyBzz;
    final double _sponsoredFlyerWidth = FlyerBox.width(context, 0.45);

    final List<Widget> _homeWallWidgets = <Widget>[

      /// BUSINESSES
      BzzBubble(
        tinyBzz: _userTinyBzz,
        numberOfRows: 1,
        numberOfColumns: 5,
        onTap: (value){print(value);},
        title: '${TextGenerator.bldrsTypePageTitle(context, BzType.Designer)} in Province',
      ),

      HomeWall.spacer,

      /// PROMOTED
      Container(
        width: Scale.superScreenWidth(context),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
              child: const SuperVerse(
                verse: 'Promoted',
                size: 1,
                centered: false,
                italic: true,
                color: Colorz.White125,
              ),
            ),

            HomeWall.spacer,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                //         // Ask(
                //         //   tappingAskInfo: () {print('Ask info is tapped aho');},
                //         // ),

                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(
                    flyerBoxWidth: _sponsoredFlyerWidth,
                    goesToEditor: false,
                  ),
                  onFlyerZoneTap: null,
                ),

                HomeWall.spacer,

                FlyerBox(
                  flyerBoxWidth: _sponsoredFlyerWidth,
                  superFlyer: SuperFlyer.createEmptySuperFlyer(
                    flyerBoxWidth: _sponsoredFlyerWidth,
                    goesToEditor: false
                  ),
                  onFlyerZoneTap: null,
                ),

              ],
            ),

          ],
        ),
      ),

      HomeWall.spacer,
      HomeWall.spacer,

      /// NEW FLYERS
      FlyersShelf(
        flyersType: FlyerType.rentalProperty,
        title: 'New By section flyers in Heliopolis',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
      ),

      HomeWall.spacer,
      HomeWall.spacer,

      /// SEQUENCES
      SequencesBubble(
        gridZoneWidth: Bubble.clearWidth(context),
        onTap: (){},
        numberOfColumns: 3,
      ),

      HomeWall.spacer,
      HomeWall.spacer,

      /// RECENTLY VIEWED
      FlyersShelf(
        flyersType: FlyerType.rentalProperty,
        title: 'Recently viewed flyers',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
      ),

      const PyramidsHorizon(),


    ];
// -----------------------------------------------------------------------------

    return ListView.builder(
      padding: const EdgeInsets.only(top: Ratioz.stratosphere),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
        itemCount: _homeWallWidgets.length,

        itemBuilder: (ctx, index){

        return
            _homeWallWidgets[index];
        },
    );
  }
}
