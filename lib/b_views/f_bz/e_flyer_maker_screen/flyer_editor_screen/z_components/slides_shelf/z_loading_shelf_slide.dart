import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class LoadingShelfSlide extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const LoadingShelfSlide({
    this.animate = false,
    this.verse,
    super.key
  });
  // -----------------------------
  final bool animate;
  final Verse? verse;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    // --------------------
    return Container(
      width: _flyerBoxWidth,
      height: DraftShelfSlide.shelfSlideZoneHeight(),
      margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding,),
      child: Column(
        children: <Widget>[

          /// SPACER
          const SizedBox(
            height: Ratioz.appBarPadding,
          ),

          /// FLYER NUMBER FOOT PRINT
          Container(
            width: _flyerBoxWidth,
            height: DraftShelfSlide.slideNumberBoxHeight,
            alignment: BldrsAligners.superCenterAlignment(context),
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

          /// SLIDE
          FlyerLoading(
            flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
            animate: animate,
            verse: verse,
          ),

          /// SPACER
          const SizedBox(height: Ratioz.appBarPadding,),

        ],
      ),
    );
    // --------------------
  }
}
