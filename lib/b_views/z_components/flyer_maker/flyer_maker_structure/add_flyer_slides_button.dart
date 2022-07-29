import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AddSlidesButton extends StatelessWidget {

  const AddSlidesButton({
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double _flyerBoxHeight = FlyerBox.height(context, ShelfSlide.flyerBoxWidth);

    return Container(
      width: ShelfSlide.flyerBoxWidth,
      height: ShelfSlide.shelfSlideZoneHeight(context),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER
          Container(
            width: ShelfSlide.flyerBoxWidth,
            height: ShelfSlide.slideNumberBoxHeight,
            alignment: Aligners.superCenterAlignment(context),
            child: const SizedBox()
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// SLIDE
          FlyerBox(
            key: const ValueKey<String>('shelf_slide_flyer_box'),
            flyerBoxWidth: ShelfSlide.flyerBoxWidth,
            boxColor: Colorz.white10,
            stackWidgets: <Widget>[


              /// ADD SLIDE PLUS ICON
                SizedBox(
                  width: ShelfSlide.flyerBoxWidth,
                  height: _flyerBoxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      /// PLUS ICON
                      const DreamBox(
                        height: ShelfSlide.flyerBoxWidth * 0.5,
                        width: ShelfSlide.flyerBoxWidth * 0.5,
                        icon: Iconz.plus,
                        iconColor: Colorz.white20,
                        bubble: false,
                      ),

                      const SizedBox(
                        height: ShelfSlide.flyerBoxWidth * 0.05,
                      ),

                      SizedBox(
                        width: ShelfSlide.flyerBoxWidth * 0.95,
                        child: SuperVerse(
                          verse: superPhrase(context, 'phid_add_images'),
                          color: Colorz.white20,
                          maxLines: 2,
                        ),
                      ),


                    ],
                  ),
                ),

            ],
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

        ],
      ),
    );

  }
}
