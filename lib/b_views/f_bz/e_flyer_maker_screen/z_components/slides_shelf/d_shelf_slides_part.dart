import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/z_add_flyer_slides_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/draft_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  final DraftFlyer? draft;
  final Function(DraftSlide draft) onSlideTap;
  final Function(DraftSlide draft) onDeleteSlide;
  final Function(PicMakerType picMakerType) onAddSlides;
  final Function(int oldIndex, int newIndex) onReorderSlide;
  final ValueNotifier<bool> loading;
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

    const double _flyerBoxWidth = DraftShelfSlide.flyerBoxWidth;
    final double _shelfSlideZoneHeight = DraftShelfSlide.shelfSlideZoneHeight();
    final int _numberOfSlides = draft?.draftSlides?.length ?? 0;
    const double _spacing = Ratioz.appBarMargin;
    final double _shelfSlidesZoneWidth = (_flyerBoxWidth + _spacing) * _numberOfSlides + 10;
    // final double _allShelfSlidesWidth = (_flyerBoxWidth + _spacing) + _shelfSlidesZoneWidth;

    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool isLoading, Widget? slides){

        return FloatingList(
          width: Bubble.clearWidth(context: context),
          height: _shelfSlideZoneHeight,
          scrollDirection: Axis.horizontal,
          boxCorners: 5,
          mainAxisAlignment: MainAxisAlignment.start,
          boxAlignment: BldrsAligners.superCenterAlignment(context),
          columnChildren: [

            if (Mapper.checkCanLoopList(draft?.draftSlides) == true)
            slides!,

            /// ADD NEW SLIDE
            if (isLoading == false && DraftFlyer.checkCanAddMoreSlides(draft) == true)
              AddSlidesButton(
                key: const ValueKey<String>('AddSlidesButton'),
                onTap: onAddSlides,
              ),


            /// LOADING WIDGET
            if (isLoading == true)
              Container(
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

          ],
        );

        },
      child: Container(
        width: _shelfSlidesZoneWidth,
        height: _shelfSlideZoneHeight,
        decoration: const BoxDecoration(
          borderRadius: Borderers.constantCornersAll15,
          color: Colorz.white10
        ),
        child: ReorderableListView.builder(
          scrollController: scrollController,
          scrollDirection: Axis.horizontal,
          /// this adds this width when dragging and messes everything
          // itemExtent: DraftShelfSlide.flyerBoxWidth,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          buildDefaultDragHandles: false,
          itemCount: _numberOfSlides,
          dragStartBehavior: DragStartBehavior.down,
          onReorder: _onReorder,
          itemBuilder: (_, int index){

            final DraftSlide _draftSlide = draft!.draftSlides![index];

            return DraftShelfSlide(
                key: ValueKey<String>('son_${_draftSlide.picModel.hashCode}'),
                draftSlide: _draftSlide,
                number: index + 1,
                onTap: () => onSlideTap(_draftSlide),
                onDeleteSlide: ()=> onDeleteSlide(_draftSlide)
            );

            },

        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
