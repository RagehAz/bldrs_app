import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/z_add_flyer_slides_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:mediators/pic_maker/pic_maker.dart';

class ShelfSlidesPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlidesPart({
    required this.slideZoneHeight,
    required this.scrollController,
    required this.draft,
    required this.onSlideTap,
    required this.onDeleteSlide,
    required this.onAddSlides,
    required this.loading,
    required this.onReorderSlide,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final DraftFlyer draft;
  final Function(DraftSlide draft) onSlideTap;
  final Function(DraftSlide draft) onDeleteSlide;
  final Function(PicMakerType picMakerType) onAddSlides;
  final ValueNotifier<bool> loading;
  final Function(int oldIndex, int newIndex) onReorderSlide;
  /// --------------------------------------------------------------------------
  void _onReorder(int oldIndex, int newIndex){

    int _newIndex = newIndex;
    if (newIndex > oldIndex) {
      _newIndex = newIndex - 1;
    }

    onReorderSlide(oldIndex, _newIndex);

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.screenWidth(context),
      height: slideZoneHeight,
      alignment: BldrsAligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: loading,
        child: Container(
          key: const ValueKey<String>('Loading_flyer'),
          width: DraftShelfSlide.flyerBoxWidth,
          height: DraftShelfSlide.shelfSlideZoneHeight(),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(Ratioz.appBarPadding),
          child: const FlyerLoading(
            flyerBoxWidth: DraftShelfSlide.flyerBoxWidth,
            animate: false,
          ),
        ),
        builder: (_, bool isLoading, Widget? loadingWidget){

          return ReorderableListView(
              scrollController: scrollController,
              onReorder: _onReorder,
              scrollDirection: Axis.horizontal,
              itemExtent: DraftShelfSlide.flyerBoxWidth,
              physics: const BouncingScrollPhysics(),
              padding: Scale.superInsets(
                context: context,
                appIsLTR: UiProvider.checkAppIsLeftToRight(),
                enRight: DraftShelfSlide.flyerBoxWidth * 0.5,
              ),
              buildDefaultDragHandles: false,
              children: <Widget>[

                /// SLIDES
                if (Mapper.checkCanLoopList(draft.draftSlides) == true)
                ...List.generate(draft.draftSlides.length, (index){

                  final DraftSlide _draftSlide = draft.draftSlides[index];

                  return DraftShelfSlide(
                      key: ValueKey<String>('son_${_draftSlide.picModel.hashCode}'),
                      draftSlide: _draftSlide,
                      number: index + 1,
                      onTap: () => onSlideTap(_draftSlide),
                      onDeleteSlide: ()=> onDeleteSlide(_draftSlide)
                  );

                }),

                /// ADD NEW SLIDE
                if (isLoading == false && DraftFlyer.checkCanAddMoreSlides(draft) == true)
                  AddSlidesButton(
                    key: const ValueKey<String>('AddSlidesButton'),
                    onTap: onAddSlides,
                  ),

                /// LOADING WIDGET
                if (isLoading == true)
                  loadingWidget!,

              ],
          );

          },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
