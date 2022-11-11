import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/z_add_flyer_slides_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlidesPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlidesPart({
    @required this.slideZoneHeight,
    @required this.scrollController,
    @required this.draft,
    @required this.onSlideTap,
    @required this.onDeleteSlide,
    @required this.onAddSlides,
    @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final DraftFlyer draft;
  final ValueChanged<DraftSlide> onSlideTap;
  final ValueChanged<DraftSlide> onDeleteSlide;
  final ValueChanged<PicMakerType> onAddSlides;
  final ValueNotifier<bool> loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.screenWidth(context),
      height: slideZoneHeight,
      alignment: Aligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: loading,
        child: Container(
          width: DraftShelfSlide.flyerBoxWidth,
          height: DraftShelfSlide.shelfSlideZoneHeight(context),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(Ratioz.appBarPadding),
          child: const FlyerLoading(
              flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
            animate: false,
          ),
        ),
        builder: (_, bool isLoading, Widget loadingWidget){

            return ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemExtent: DraftShelfSlide.flyerBoxWidth,
              physics: const BouncingScrollPhysics(),
              padding: Scale.superInsets(
                context: context,
                enRight: DraftShelfSlide.flyerBoxWidth * 0.5,
              ),
              children: <Widget>[

                /// SLIDES
                if (Mapper.checkCanLoopList(draft.draftSlides) == true)
                ...List.generate(draft.draftSlides.length, (index){

                  final DraftSlide _draftSlide = draft.draftSlides[index];

                  return DraftShelfSlide(
                    draftSlide: _draftSlide,
                    number: index + 1,
                    onTap: () => onSlideTap(_draftSlide),
                    onDeleteSlide: ()=> onDeleteSlide(_draftSlide)
                  );

                }),

                /// ADD NEW SLIDE
                if (isLoading == false && DraftFlyer.checkCanAddMoreSlides(draft) == true)
                  AddSlidesButton(
                    onTap: onAddSlides,
                  ),

                /// LOADING WIDGET
                if (isLoading == true)
                  loadingWidget,

              ],
            );

      },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
