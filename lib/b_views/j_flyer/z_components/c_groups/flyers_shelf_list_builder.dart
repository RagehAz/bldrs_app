import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/a_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersShelfListBuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersShelfListBuilder({
    @required this.flyers,
    @required this.flyerSizeFactor,
    @required this.flyerOnTap,
    @required this.shelfTitleVerse,
    this.onScrollEnd,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse shelfTitleVerse;
  final List<FlyerModel> flyers;
  final double flyerSizeFactor;
  final ValueChanged<FlyerModel> flyerOnTap;
  final Function onScrollEnd;
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
  /// TAMAM
  @override
  void dispose() {
    _controller.dispose();
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
          widget.onScrollEnd();
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

    if (Mapper.checkCanLoopList(widget.flyers) == true){

      final double _flyerBoxWidth = FlyerDim.flyerWidthByFactor(context, widget.flyerSizeFactor);

      return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.flyers.length,
        controller: _controller,
        scrollDirection: Axis.horizontal,
        padding: Scale.superPadding(
          context: context,
          enLeft: Ratioz.appBarMargin,
          enRight: _flyerBoxWidth,
        ),

        separatorBuilder: (BuildContext context, int _y) => const SizedBox(
          height: 1,
          width: Ratioz.appBarMargin,
        ),
        itemBuilder: (BuildContext context, int _x) {

          return GestureDetector(
            onTap: widget.flyerOnTap == null ? null : () => widget.flyerOnTap(widget.flyers[_x]),
            child: AbsorbPointer(
                absorbing: _absorbingFlyerTap(),
                child: Flyer(
                  flyerBoxWidth: _flyerBoxWidth,
                  flyerModel: widget.flyers[_x],
                  screenName: 'FlyersShelfListBuilder',
                ),

              ),
            );

        },
      );

    }

    else {
      return const SizedBox();
    }


  }
  // -----------------------------------------------------------------------------
}
