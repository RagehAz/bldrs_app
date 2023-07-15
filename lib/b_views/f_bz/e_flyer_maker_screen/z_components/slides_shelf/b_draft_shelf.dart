import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/d_shelf_slides_part.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/a_draft_shelf_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class SlidesShelf extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelf({
    required this.shelfNumber,
    required this.draft,
    required this.loadingSlides,
    required this.scrollController,
    required this.onAddSlides,
    required this.onReorderSlide,
    required this.onDeleteSlide,
    required this.onSlideTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final int shelfNumber;
  final DraftFlyer? draft;
  final ValueNotifier<bool> loadingSlides;
  final ScrollController scrollController;
  final Function(DraftSlide draft) onSlideTap;
  final Function(DraftSlide draft) onDeleteSlide;
  final Function(PicMakerType picMakerType) onAddSlides;
  final Function(int oldIndex, int newIndex) onReorderSlide;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _slideZoneHeight = DraftShelfSlide.shelfSlideZoneHeight();

    if (draft == null){
      return Container(
        width: Scale.screenWidth(context),
        height: DraftShelfBox.height(),
        decoration: BoxDecoration(
          // color: Colorz.white10,
          borderRadius: Borderers.cornerAll(Bubble.clearCornersValue),
        ),
        alignment: BldrsAligners.superCenterAlignment(context),
        child: Container(
          width: DraftShelfSlide.flyerBoxWidth,
          height: _slideZoneHeight,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(Ratioz.appBarPadding),
          child: const FlyerLoading(
            flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
            animate: false,
          ),
        ),
      );
    }

    else {
      return Container(
        width: Scale.screenWidth(context),
        height: DraftShelfBox.height(),
        decoration: BoxDecoration(
          // color: Colorz.white10,
          borderRadius: Borderers.cornerAll(Bubble.clearCornersValue),
        ),
        alignment: BldrsAligners.superCenterAlignment(context),
        child: ShelfSlidesPart(
          loading: loadingSlides,
          slideZoneHeight: _slideZoneHeight,
          scrollController: scrollController,
          draft: draft,
          onSlideTap: onSlideTap,
          onDeleteSlide: onDeleteSlide,
          onAddSlides: onAddSlides,
          onReorderSlide: onReorderSlide,
        ),
      );
    }

  }
  /// --------------------------------------------------------------------------
}
