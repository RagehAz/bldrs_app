import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:flutter/material.dart';

class FlyersShelfListBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersShelfListBuilder({
    required this.flyersIDs,
    required this.flyerBoxWidth,
    required this.gridWidth,
    required this.gridHeight,
    required this.flyerOnTap,
    required this.shelfTitleVerse,
    this.onScrollEnd,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse? shelfTitleVerse;
  final List<String> flyersIDs;
  final double flyerBoxWidth;
  final double gridWidth;
  final double gridHeight;
  final Function(String? flyerID)? flyerOnTap;
  final Function? onScrollEnd;
  /// --------------------------------------------------------------------------
  @override
  _FlyersShelfListBuilderState createState() => _FlyersShelfListBuilderState();
  /// --------------------------------------------------------------------------
  }

class _FlyersShelfListBuilderState extends State<FlyersShelfListBuilder> {
  // -----------------------------------------------------------------------------
  final ScrollController _controller = ScrollController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _controller.addListener(listenToScrolling);
  }
  // --------------------
  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(listenToScrolling);
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  void listenToScrolling() {
    if (_controller.position.atEdge) {
      blog('at edge');
      final bool isTop = _controller.position.pixels == 0;
      blog('isTOp is : $isTop');

      if (isTop) {
        blog('we reached the scroll start');
      } else {
        blog('we reached the scroll end');
        if (widget.onScrollEnd != null) {
          widget.onScrollEnd!.call();
        }
      }
    }
  }
  // --------------------
  bool _absorbingFlyerTap() {
    bool _absorbing;

    if (widget.flyerOnTap == null) {
      _absorbing = false;
    } else {
      _absorbing = true;
    }

    return _absorbing;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(widget.flyersIDs) == true){

      final double _flyerBoxWidth = widget.flyerBoxWidth;

      return SizedBox(
        width: widget.gridWidth,
        height: widget.gridHeight,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.flyersIDs.length,
          controller: _controller,
          scrollDirection: Axis.horizontal,
          padding: Scale.superInsets(
            context: context,
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enLeft: Ratioz.appBarMargin,
            enRight: _flyerBoxWidth,
          ),

          separatorBuilder: (BuildContext context, int _y) => const SizedBox(
            height: 1,
            width: Ratioz.appBarMargin,
          ),
          itemBuilder: (BuildContext context, int _x) {

            return GestureDetector(
              onTap: widget.flyerOnTap == null ? null : () => widget.flyerOnTap!.call(widget.flyersIDs[_x]),
              child: AbsorbPointer(
                  absorbing: _absorbingFlyerTap(),
                  child: FlyerBuilder(
                    flyerID: widget.flyersIDs[_x],
                    flyerBoxWidth: _flyerBoxWidth,
                    onlyFirstSlide: true,
                    slidePicType: SlidePicType.small,
                    renderFlyer: RenderFlyer.firstSlide,
                    builder: (bool loading, FlyerModel? flyerModel) {

                      if (loading == true){
                        return FlyerLoading(
                          flyerBoxWidth: _flyerBoxWidth,
                          animate: true,
                        );
                      }

                      else {
                        return HeroicFlyer(
                          flyerBoxWidth: _flyerBoxWidth,
                          flyerModel: flyerModel,
                          screenName: 'FlyersShelfListBuilder',
                          gridWidth: widget.gridWidth,
                          gridHeight: widget.gridHeight,
                        );
                      }

                    }
                  ),

                ),
              );

          },
        ),
      );

    }

    else {
      return const SizedBox();
    }


  }
  // -----------------------------------------------------------------------------
}
