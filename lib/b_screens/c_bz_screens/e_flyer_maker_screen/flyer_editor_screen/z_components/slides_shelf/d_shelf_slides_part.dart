import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/e_draft_shelf_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/z_add_slides_button.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/z_loading_shelf_slide.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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
  final Function(MediaOrigin mediaOrigin) onAddSlides;
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
          scrollController: scrollController,
          columnChildren: <Widget>[

            if (Lister.checkCanLoop(draft?.draftSlides) == true)
            slides!,

            /// LOADING WIDGET
            if (isLoading == true)
              const LoadingShelfSlide(
                animate: true,
                verse: Verse(
                  id: 'phid_loading',
                  translate: true,
                ),
              ),

            /// ADD NEW SLIDE
            if (DraftFlyer.checkCanAddMoreSlides(draft) == true)
              AddPhotosButton(
                onTap: onAddSlides,
                isDisabled: isLoading,
              ),

            /// ADD NEW SLIDE
            if (DraftFlyer.checkCanAddMoreSlides(draft) == true)
              AddVideosButton(
                onTap: onAddSlides,
                isDisabled: isLoading,
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
          // scrollController: scrollController,
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
                key: ValueKey<String>('son_${_draftSlide.bigPic.hashCode}'),
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
