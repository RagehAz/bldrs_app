import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlidesPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlidesPart({
    @required this.slideZoneHeight,
    @required this.scrollController,
    @required this.draft,
    @required this.onSlideTap,
    @required this.onAddNewSlides,
    @required this.loading,
    @required this.isEditingFlyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final DraftFlyerModel draft;
  final ValueChanged<MutableSlide> onSlideTap;
  final Function onAddNewSlides;
  final ValueNotifier<bool> loading; /// p
  final bool isEditingFlyer;
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
                    isEditingFlyer: isEditingFlyer,
                    onTap: () => onSlideTap(_mutableSlide),
                  );

                }),

                /// ADD SLIDE BUTTON
                if (isLoading == false && isEditingFlyer == false)
                  ShelfSlide(
                    mutableSlide: null,
                    number: null,
                    onTap: onAddNewSlides,
                    isEditingFlyer: isEditingFlyer,
                    publishTime: PublishTime.getPublishTimeFromTimes(
                      state: PublishState.published,
                      times: draft.times,
                    )?.time,
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
}
