import 'package:animators/animators.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/page_bubble/page_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:widget_fader/widget_fader.dart';

class CornerWidgetMaximizer extends StatelessWidget {
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
  Widget build(BuildContext context) {

    final double _maxAllowableWidth = PageBubble.width(context);

    return _Maximizer(
      minWidth: minWidth,
      maxWidth: maxWidth,
      childWidth: childWidth,
      maxAllowableWidth: _maxAllowableWidth,
      topChild: topChild,
      child: child,
    );

  }
}


class _Maximizer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _Maximizer({
    @required this.child,
    @required this.minWidth,
    @required this.maxWidth,
    @required this.childWidth,
    @required this.maxAllowableWidth,
    this.topChild,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final double minWidth;
  final double maxWidth;
  final double childWidth;
  final Widget topChild;
  final double maxAllowableWidth;
  /// --------------------------------------------------------------------------
  @override
  State<_Maximizer> createState() => _MaximizerState();
  /// --------------------------------------------------------------------------
}

class _MaximizerState extends State<_Maximizer> with SingleTickerProviderStateMixin {
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
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _initialize();

  }
  // --------------------
  void _initialize(){
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
      begin: _getBeginRatio(),
      end: _getEndRatio(),
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
  void didUpdateWidget(covariant _Maximizer oldWidget) {

    if (
    oldWidget.minWidth != widget.minWidth ||
    oldWidget.maxWidth != widget.maxWidth ||
    oldWidget.maxAllowableWidth != widget.maxAllowableWidth ||
    oldWidget.childWidth != widget.childWidth
    ){
      setState(() {
        _scaleAnimation = Animators.animateDouble(
          begin: _getBeginRatio(),
          end: _getEndRatio(),
          controller: _animationController,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        );
      });
    }

    super.didUpdateWidget(oldWidget);
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
  double _getBeginRatio(){
    return widget.minWidth / widget.childWidth;
  }
  // --------------------
  double _getEndRatio(){
    // final double _maxWidth = widget.maxWidth > widget.maxAllowableWidth ? widget.maxAllowableWidth : widget.maxWidth;
    return widget.maxWidth / widget.childWidth;
  }
  // -----------------------------------------------------------------------------
  Future<void> _animate() async {

    if (_scaleAnimation.value >= _getEndRatio()){

      await _animationController.reverse();
      setNotifier(notifier: _isExpanded, mounted: mounted, value: false);

    }
    else {

      await _animationController.forward();
      setNotifier(notifier: _isExpanded, mounted: mounted, value: true);

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
                width: Scale.screenWidth(context),
                height: Scale.screenHeight(context),
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
          appIsLTR: UiProvider.checkAppIsLeftToRight(context),
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
                        // constraints: BoxConstraints(
                        // maxHeight: PageBubble.height(
                        //     appBarType: AppBarType.basic,
                        //     context: context,
                        //     screenHeight: Scale.superScreenHeight(context),
                        // ) - 20,
                        // maxWidth: widget.maxAllowableWidth,
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: Bubble.borders(context),
                          color: Colorz.black255,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              /// TOP ARROW
                              BldrsBox(
                                height: 35,
                                width: 35,
                                icon: expanded == true ? Iconz.arrowDown : Iconz.arrowUp,
                                iconSizeFactor: 0.6,
                                bubble: false,
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
