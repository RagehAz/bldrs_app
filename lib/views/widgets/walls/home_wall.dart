import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/bubbles/bzz_bubble.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/stacks/flyer_stack.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:bldrs/views/widgets/walls/sequences_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWall extends StatefulWidget {

  @override
  _HomeWallState createState() => _HomeWallState();
}

class _HomeWallState extends State<HomeWall> {

  @override
  Widget build(BuildContext context) {

// -----------------------------------------------------------------------------
    FlyersProvider _prof = Provider.of<FlyersProvider>(context, listen: true);
    List<TinyBz> _userTinyBzz = _prof.getUserTinyBzz;
// -----------------------------------------------------------------------------
    Widget _spacer = SizedBox(height: Ratioz.appBarMargin, width: Ratioz.appBarMargin,);
// -----------------------------------------------------------------------------
    List<Widget> _homeWallWidgets = <Widget>[

      /// BUSINESSES
      BzzBubble(
        tinyBzz: _userTinyBzz,
        numberOfRows: 1,
        numberOfColumns: 5,
        onTap: (value){print(value);},
        title: '${TextGenerator.bldrsTypePageTitle(context, BzType.Designer)} in Province',
      ),

      _spacer,

      /// PROMOTED
      Container(
        width: Scale.superScreenWidth(context),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SuperVerse(
              verse: 'Promoted',
              size: 1,
              centered: false,
              italic: true,
              color: Colorz.White125,
            ),

            _spacer,

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[

                //         // Ask(
                //         //   tappingAskInfo: () {print('Ask info is tapped aho');},
                //         // ),

                FlyerZoneBox(
                  flyerSizeFactor: 0.45,
                  onFlyerZoneTap: null,
                ),

                _spacer,

                FlyerZoneBox(
                  flyerSizeFactor: 0.45,
                  onFlyerZoneTap: null,
                ),

              ],
            ),

          ],
        ),
      ),

      _spacer,
      _spacer,

      /// NEW FLYERS
      FlyerStack(
        flyersType: FlyerType.Property,
        title: 'New By section flyers in Heliopolis',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
      ),

      _spacer,
      _spacer,

      /// SEQUENCES
      SequencesBubble(
        gridZoneWidth: Scale.superBubbleClearWidth(context),
        onTap: (){},
        numberOfColumns: 3,
      ),

      _spacer,
      _spacer,

      /// RECENTLY VIEWED
      FlyerStack(
        flyersType: FlyerType.Property,
        title: 'Recently viewed flyers',
        tinyFlyers: TinyFlyer.dummyTinyFlyers(),
      ),

      PyramidsHorizon(heightFactor: 5,),


    ];
// -----------------------------------------------------------------------------

    return ListView.builder(
      padding: EdgeInsets.only(top: Ratioz.stratosphere),
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
