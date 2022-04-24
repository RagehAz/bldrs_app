import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ShelfSlidesPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ShelfSlidesPart({
    @required this.slideZoneHeight,
    @required this.scrollController,
    @required this.mutableSlides,
    @required this.flyerHeaderController,
    @required this.onSlideTap,
    @required this.onAddNewSlides,
    @required this.loading,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final List<MutableSlide> mutableSlides;
  final TextEditingController flyerHeaderController;
  final ValueChanged<MutableSlide> onSlideTap;
  final Function onAddNewSlides;
  final ValueNotifier<bool> loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.superScreenWidth(context),
      height: slideZoneHeight,
      alignment: superCenterAlignment(context),
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

            return ListView.builder(
              controller: scrollController,
              itemCount: mutableSlides.length + 1,
              scrollDirection: Axis.horizontal,
              itemExtent: ShelfSlide.flyerBoxWidth,
              physics: const BouncingScrollPhysics(),
              padding: Scale.superInsets(
                context: context,
                enRight: ShelfSlide.flyerBoxWidth * 0.5,
              ),
              itemBuilder: (ctx, index){

                final bool _atLastIndex = index == mutableSlides.length;

                /// PRE LAST INDEX : ADD SLIDE BUTTON
                if (_atLastIndex == true){

                  if (isLoading == true){
                    return loadingWidget;
                  }

                  else {
                    return ShelfSlide(
                      mutableSlide: null,
                      headline: null,
                      number: index + 1,
                      onTap: onAddNewSlides,
                    );
                  }

                }

                /// AT SLIDES INDEXES : SLIDES
                else {

                  final MutableSlide _mutableSlide = mutableSlides[index];
                  final bool _hasSlides = mutableSlides.isNotEmpty;

                  return ShelfSlide(
                    mutableSlide: _mutableSlide,
                    headline: _hasSlides && index == 0 ? flyerHeaderController : null,
                    number: index + 1,
                    onTap: () => onSlideTap(_mutableSlide),
                  );
                }

              },
            );

      },
      ),

    );
  }
}
