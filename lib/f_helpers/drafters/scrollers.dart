import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  // --------------------
  /*
  static ScrollPhysics superScroller({
    @required bool trigger,
  }) {
    return trigger == true ?
    const BouncingScrollPhysics()
        :
    const NeverScrollableScrollPhysics();
  }
   */
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkIsAtTop(ScrollController scrollController) {
    return scrollController.offset == scrollController.position.minScrollExtent;
  }
  // --------------------
  static bool checkIsAtBottom(ScrollController scrollController) {
    return scrollController.offset == scrollController.position.maxScrollExtent;
  }
  // --------------------
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
  // --------------------
  static bool checkIsGoingUp(ScrollController scrollController) {
    return scrollController.position.userScrollDirection == ScrollDirection.reverse;
  }
  // --------------------
  static bool checkIsAtPercentFromTop({
    ScrollController scrollController,
    double percent,
    double maxHeight,
  }) {
    final double _min = scrollController.position.minScrollExtent;
    final double _max = maxHeight; //scrollController.position.maxScrollExtent;
    final double _fraction = percent / 100;
    return scrollController.offset <= (_min + (_max * _fraction));
  }
  // --------------------
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
    final double _nextLimit = (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));


    if (details.metrics.axis != axis) {
      return false;
    }
    else if (goesBackOnly == true) {
      return _offset < _backLimit;
    }
    else {
      return _offset < _backLimit || _offset > _nextLimit;
    }

  }
  // -----------------------------------------------------------------------------

  /// SCROLL TO

  // --------------------
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

    await controller.animateTo(controller.position.minScrollExtent,
      duration: Ratioz.durationSliding400,
      curve: Curves.easeInOutCirc,
    );

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogScrolling({
    @required ScrollController scrollController,
    @required double paginationHeight,
    @required bool isPaginating,
    @required bool canKeepReading,
  }) {

    final double max = scrollController.position.maxScrollExtent;
    final double current = scrollController.position.pixels;

    final bool _canPaginate = canPaginate(
      scrollController: scrollController,
      paginationHeight: paginationHeight,
      isPaginating: isPaginating,
      canKeepReading: canKeepReading,
    );

    final double _max = Numeric.roundFractions(max, 1);
    final double _current = Numeric.roundFractions(current, 1);
    final double _diff = Numeric.roundFractions(max-current, 1);
    blog('SHOULD LOAD : (max $_max - current $_current) = $_diff : canPaginate $_canPaginate');

  }
  // -----------------------------------------------------------------------------

  /// PAGINATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool canPaginate({
    @required ScrollController scrollController,
    @required double paginationHeight,
    @required bool isPaginating,
    @required bool canKeepReading,
  }){

    if (isPaginating == true){
      return false;
    }
    else if (canKeepReading == false){
      return false;
    }
    else {

      final double max = scrollController.position.maxScrollExtent;
      final double current = scrollController.position.pixels;

      return max - current <= paginationHeight;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void createPaginationListener({
    @required ScrollController controller,
    @required ValueNotifier<bool> isPaginating,
    @required ValueNotifier<bool> canKeepReading,
    @required Function onPaginate,
    @required bool mounted,
  }){

    controller.addListener(() async {

      final bool _canPaginate = Scrollers.canPaginate(
        scrollController: controller,
        isPaginating: isPaginating.value,
        canKeepReading: canKeepReading.value,
        paginationHeight: 100,
      );

      // Scrollers.blogScrolling(
      //   scrollController: controller,
      //   isPaginating: isPaginating.value,
      //   canKeepReading: canKeepReading.value,
      //   paginationHeight: 0,
      // );

      if (_canPaginate == true){

        setNotifier(
            notifier: isPaginating,
            mounted: mounted,
            value: true,
        );

        await onPaginate();

        setNotifier(
          notifier: isPaginating,
          mounted: mounted,
          value: false,
        );

      }

    });


  }
// -----------------------------------------------------------------------------
}
