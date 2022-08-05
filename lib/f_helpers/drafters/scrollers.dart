import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// -----------------------------------------------------------------------------
enum SlidingDirection {
  next,
  back,
  freeze,
}

class Scrollers {
// -----------------------------------------------------------------------------

  const Scrollers();

// -----------------------------------------------------------------------------

  /// FUCK YOU

// -----------------------------------
  static ScrollPhysics superScroller({
    @required bool trigger,
  }) {
    final ScrollPhysics scroller = trigger == true ?
    const BouncingScrollPhysics()
        :
    const NeverScrollableScrollPhysics();

    return scroller;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -----------------------------------
  static bool checkIsAtTop(ScrollController scrollController) {
    final bool _atTop =
        scrollController.offset == scrollController.position.minScrollExtent;
    return _atTop;
  }
// -----------------------------------------------------------------------------
  static bool checkIsAtBottom(ScrollController scrollController) {
    final bool _atTop =
        scrollController.offset == scrollController.position.maxScrollExtent;
    return _atTop;
  }
// -----------------------------------------------------------------------------
  static bool checkIsGoingDown(ScrollController scrollController) {
    bool _goingDown;

    if (scrollController != null) {
      if (scrollController.position != null) {
        _goingDown = scrollController.position.userScrollDirection ==
            ScrollDirection.forward;
      }
    }

    return _goingDown;
  }
// -----------------------------------------------------------------------------
  static bool checkIsGoingUp(ScrollController scrollController) {
    final bool _goingUp =
        scrollController.position.userScrollDirection == ScrollDirection.reverse;
    return _goingUp;
  }
// -----------------------------------------------------------------------------
  static bool checkIsAtPercentFromTop({
    ScrollController scrollController,
    double percent,
    double maxHeight,
  }) {
    final double _min = scrollController.position.minScrollExtent;
    final double _max = maxHeight; //scrollController.position.maxScrollExtent;
    final double _fraction = percent / 100;

    final bool _isAtTenPercentFromTop =
        scrollController.offset <= (_min + (_max * _fraction));

    return _isAtTenPercentFromTop;
  }
// -----------------------------------------------------------------------------
  static bool checkCanSlide({
    @required ScrollUpdateNotification details,
    @required double boxDistance,
    @required bool goesBackOnly,
    @required Axis axis,
    int numberOfBoxes = 2,
  }) {
    final double _offset = details.metrics.pixels;

    const double _limitRatio = 0.2;

    final double _backLimit = boxDistance * _limitRatio * (-1);

    final double _nextLimit =
        (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));

    bool _canSlide;

    if (details.metrics.axis != axis) {
      _canSlide = false;
    } else if (goesBackOnly == true) {
      _canSlide = _offset < _backLimit;
    } else {
      _canSlide = _offset < _backLimit || _offset > _nextLimit;
    }

    // print('boxDistance * numberOfBoxes = $boxDistance * ${numberOfBoxes - 1} = ${boxDistance * (numberOfBoxes - 1)} : _backLimit : $_backLimit : _offset : $_offset');

    return _canSlide;
  }
// -----------------------------------------------------------------------------

  /// SCROLL TO

// -----------------------------------
  static Future<void> scrollTo({
    @required ScrollController controller,
    @required double offset,
  }) async {
    // if (controller.positions.isEmpty == true){
    await controller.animateTo(
      offset,
      curve: Curves.easeInOutCirc,
      duration: Ratioz.durationSliding400,
    );
    // }
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scrollToEnd({
    @required ScrollController controller,
  }) async {

    blog('scrolling to End of scroll controller ${controller.position.maxScrollExtent}');

    await controller.animateTo(controller.position.maxScrollExtent,
      duration: Ratioz.durationSliding400,
      curve: Curves.easeInOutCirc,
    );

  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> scrollToTop({
    @required ScrollController controller,
  }) async {

    blog('scrolling to Top of scroll controller ${controller.position.maxScrollExtent}');

    await controller.animateTo(controller.position.minScrollExtent,
      duration: Ratioz.durationSliding400,
      curve: Curves.easeInOutCirc,
    );

  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -----------------------------------
  static void blogScrolling({
    @required ScrollController scrollController,
    @required double paginationHeight,
    @required bool isPaginating,
  }) {

    final double max = scrollController.position.maxScrollExtent;
    final double current = scrollController.position.pixels;

    final bool _canPaginate = canPaginate(
      scrollController: scrollController,
      paginationHeight: paginationHeight,
      isPaginating: isPaginating,
    );

    final double _max = Numeric.roundFractions(max, 1);
    final double _current = Numeric.roundFractions(current, 1);
    final double _diff = Numeric.roundFractions(max-current, 1);
    blog('SHOULD LOAD : (max $_max - current $_current) = $_diff : canPaginate $_canPaginate');

  }
// -----------------------------------------------------------------------------

  /// PAGINATION

// -----------------------------------
  static bool canPaginate({
    @required ScrollController scrollController,
    @required double paginationHeight,
    @required bool isPaginating,
  }){
    final double max = scrollController.position.maxScrollExtent;
    final double current = scrollController.position.pixels;

    return (max - current <= paginationHeight) && (isPaginating == false);
  }
// -----------------------------------------------------------------------------
}
