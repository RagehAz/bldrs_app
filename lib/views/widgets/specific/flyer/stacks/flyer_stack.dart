import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyers_provider.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/stacks/flyer_stack_list.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyerStack extends StatelessWidget {
  final FlyerType flyersType;
  final double flyerSizeFactor;
  final String title;
  final List<TinyFlyer> tinyFlyers;
  final String titleIcon;
  final Function flyerOnTap;
  final Function onScrollEnd;


  const FlyerStack({
    this.flyersType,
    this.flyerSizeFactor = 0.3,
    this.title,
    this.tinyFlyers,
    this.titleIcon,
    this.flyerOnTap,
    this.onScrollEnd,
});

  @override
  Widget build(BuildContext context) {
    final FlyersProvider _pro = Provider.of<FlyersProvider>(context, listen: true);
    final List<TinyFlyer> _tinyFlyers = tinyFlyers == null ? _pro.getTinyFlyersByFlyerType(flyersType) : tinyFlyers;
    // final List<TinyBz> _tinyBzz = _pro.getTinyBzzOfTinyFlyersList(_tinyFlyers);

// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final double _titleSpacing = Ratioz.appBarMargin;
    final double flyerBoxWidth = FlyerBox.width(context, flyerSizeFactor);
    final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
//     bool _slidingIsOn = false;
    final double _titleIconWidth = Ratioz.appBarButtonSize;
    final double _titleIconCorner = Ratioz.appBarButtonCorner;
    final double _titleIconMargin = 0;
    final double _titleIconWidthWithMargin = _titleIconWidth + _titleIconMargin;
// -----------------------------------------------------------------------------
    return

      _tinyFlyers.length == 0 ? Container() :
      Container(
        width: _screenWidth,
        // height: _collectionHeight + 2*_titleSpacing + (_screenHeight * Ratioz.fontSize3) + 12,
        color: Colorz.White10,
        // decoration: BoxDecoration(
        //   // color: Colorz.BlackLingerie,
        //   //   border: Border.symmetric(
        //   //       vertical: BorderSide(width: 0.5, color: Colorz.BabyBlueAir, ),
        //   //   )
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            /// ---  ABOVE TITLE SPACING
            if (title != null)
              SizedBox(
                width: _screenWidth,
                height: _titleSpacing,
              ),

            /// --- COLLECTION TITLE
            if (title != null)
              GestureDetector(
                onTap: onScrollEnd,
                child: Container(
                  width: _screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  // color: Colorz.BloodTest,
                  child: Row(
                    children: <Widget>[

                      if (titleIcon != null)
                        DreamBox(
                          height: _titleIconWidth,
                          icon: titleIcon,
                          margins: EdgeInsets.symmetric(horizontal: _titleIconMargin),
                          corners: _titleIconCorner,
                        ),

                      if (titleIcon != null)
                        const SizedBox(width: Ratioz.appBarMargin,),

                      Container(
                        width: _screenWidth - (Ratioz.appBarMargin * 5) - _titleIconWidthWithMargin,
                        child: SuperVerse(
                          verse: title,
                          size: 2,
                          weight: VerseWeight.bold,
                          centered: false,
                          shadow: true,
                          italic: true,
                          maxLines: 3,
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            /// --- BENEATH TITLE SPACING
            if (title != null)
              SizedBox(
                width: _screenWidth,
                height: _titleSpacing,
              ),

            /// --- COLLECTION FLYER'S ZONE
            Container(
              width: _screenWidth,
              height: _flyerZoneHeight,
              // color: Colorz.WhiteAir,
              child: FlyerStackList(
                tinyFlyers: _tinyFlyers,
                flyerSizeFactor: flyerSizeFactor,
                flyerOnTap: flyerOnTap,
                onScrollEnd: onScrollEnd,
              ),


            ),


            /// --- BENEATH FLYERS SPACING
            SizedBox(
                width: _screenWidth,
                height: _titleSpacing,
              ),

          ],
        ),
      );
  }
}