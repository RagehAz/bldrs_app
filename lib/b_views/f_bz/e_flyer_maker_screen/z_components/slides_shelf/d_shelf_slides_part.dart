import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/add_flyer_slides_button.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
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
    @required this.onAddSlides,
    @required this.loading,
    @required this.isEditingFlyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final DraftFlyerModel draft;
  final ValueChanged<MutableSlide> onSlideTap;
  final ValueChanged<ImagePickerType> onAddSlides;
  final ValueNotifier<bool> loading;
  final ValueNotifier<bool> isEditingFlyer;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.superScreenWidth(context),
      height: slideZoneHeight,
      alignment: Aligners.superCenterAlignment(context),
      child: ValueListenableBuilder(
        valueListenable: loading,
        child: Container(
          width: ShelfSlide.flyerBoxWidth,
          height: ShelfSlide.shelfSlideZoneHeight(context),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(Ratioz.appBarPadding),
          child: const FlyerLoading(
              flyerBoxWidth: ShelfSlide.flyerBoxWidth
          ),
        ),
        builder: (_, bool isLoading, Widget loadingWidget){

            return ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemExtent: ShelfSlide.flyerBoxWidth,
              physics: const BouncingScrollPhysics(),
              padding: Scale.superInsets(
                context: context,
                enRight: ShelfSlide.flyerBoxWidth * 0.5,
              ),
              children: <Widget>[

                /// SLIDES
                if (Mapper.checkCanLoopList(draft.mutableSlides) == true)
                ...List.generate(draft.mutableSlides.length, (index){

                  final MutableSlide _mutableSlide = draft.mutableSlides[index];

                  return ShelfSlide(
                    mutableSlide: _mutableSlide,
                    number: index + 1,
                    onTap: () => onSlideTap(_mutableSlide),
                  );

                }),

                /// ADD SLIDE BUTTON
                ValueListenableBuilder(
                  valueListenable: isEditingFlyer,
                  builder: (_, bool isEditing, Widget child){

                    if (isLoading == false && isEditing == false){
                      return AddSlidesButton(
                        onTap: onAddSlides,
                      );
                    }

                    else {
                      return const SizedBox();
                    }

                  },
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
