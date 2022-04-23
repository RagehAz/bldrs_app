import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/e_shelf_slide.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double slideZoneHeight;
  final ScrollController scrollController;
  final List<MutableSlide> mutableSlides;
  final TextEditingController flyerHeaderController;
  final ValueChanged<MutableSlide> onSlideTap;
  final Function onAddNewSlides;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('ShelfSlidesPart'),
      width: Scale.superScreenWidth(context),
      height: slideZoneHeight,
      child: ListView.builder(
        controller: scrollController,
        itemCount: mutableSlides.length + 1,
        scrollDirection: Axis.horizontal,
        itemExtent: ShelfSlide.flyerBoxWidth,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, index){

          final bool _atLastIndex = mutableSlides.length == index;
          final MutableSlide _mutableSlide = _atLastIndex ? null : mutableSlides[index];
          final bool _hasSlides = mutableSlides.isNotEmpty;

          return ShelfSlide(
              mutableSlide: _mutableSlide,
              headline: _hasSlides && index == 0 ? flyerHeaderController : null,
              number: index + 1,
              onTap: () async {

                if (_atLastIndex == true){
                  onAddNewSlides();
                }
                else {
                  onSlideTap(_mutableSlide);
                }

              }
          );

        },
      ),

    );
  }
}
