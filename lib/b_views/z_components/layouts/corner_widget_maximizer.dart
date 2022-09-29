import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/super_positioned.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CornerWidgetMaximizer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CornerWidgetMaximizer({
    @required this.child,
    @required this.minWidth,
    @required this.maxWidth,
    @required this.childWidth,
    this.topChild,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double minWidth;
  final double maxWidth;
  final double childWidth;
  final Widget topChild;
  /// --------------------------------------------------------------------------
  @override
  State<CornerWidgetMaximizer> createState() => _CornerWidgetMaximizerState();
  /// --------------------------------------------------------------------------
}

class _CornerWidgetMaximizerState extends State<CornerWidgetMaximizer> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _scaleAnimation;
  ColorTween _backgroundColorTween;
  // --------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        reverseDuration: Ratioz.durationFading200,
        duration: Ratioz.durationFading200,
        vsync: this,
    );

    _backgroundColorTween = ColorTween(
      begin: Colorz.black0,
      end: Colorz.black150,
    );

    _animation = Animators.animateDouble(
      begin: 0,
      end: 1,
      controller: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

    _scaleAnimation = Animators.animateDouble(
      begin: _getBegin(),
      end: _getEnd(),
      controller: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _animationController.dispose();
    _isExpanded.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  double _getBegin(){
    return widget.minWidth / widget.childWidth;
  }
  // --------------------
  double _getEnd(){
    return widget.maxWidth / widget.childWidth;
  }
  // -----------------------------------------------------------------------------
  Future<void> _animate() async {

    if (_scaleAnimation.value >= _getEnd()){
      await _animationController.reverse();
      _isExpanded.value = false;
    }
    else {
      await _animationController.forward();
      _isExpanded.value = true;
    }

  }

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        /// BACKGROUND,
        IgnorePointer(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, Widget child){

              final Color _backgroundColor = _backgroundColorTween.evaluate(_animation);

              return Container(
                width: Scale.superScreenWidth(context),
                height: Scale.superScreenHeightWithoutSafeArea(context),
                color: _backgroundColor,
              );

            },

          ),
        ),

        /// WIDGET
        SuperPositioned(
          enAlignment: Alignment.bottomLeft,
          horizontalOffset: 10,
          verticalOffset: MediaQuery.of(context).viewInsets.bottom + 5,
          child: ScaleTransition(
              alignment: Alignment.bottomLeft,
              scale: _scaleAnimation,
              child: GestureDetector(
                onTap: _animate,
                child: SingleChildScrollView(
                  child: ValueListenableBuilder(
                    valueListenable: _isExpanded,
                    builder: (_, bool expanded, Widget child){

                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: Bubble.borders(context),
                          color: Colorz.black255,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[

                              SizedBox(
                                width: widget.maxWidth,
                                child: DreamBox(
                                  height: 35,
                                  width: 35,
                                  icon: expanded == true ? Iconz.arrowDown : Iconz.arrowUp,
                                  iconSizeFactor: 0.6,
                                  bubble: false,
                                ),
                              ),

                              /// TOP CHILD
                              if (expanded == true && widget.topChild != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: WidgetFader(
                                    fadeType: FadeType.fadeIn,
                                    duration: const Duration(milliseconds: 200),
                                    child: widget.topChild,
                                  ),
                                ),

                              /// BOTTOM CHILD
                              AbsorbPointer(
                                absorbing: !expanded,
                                child: child,
                              ),

                            ],
                          ),
                        ),
                      );

                    },
                    child: widget.child,
                  ),
                ),
              ),
            ),
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
