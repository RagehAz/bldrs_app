import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';

class ListPusher extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ListPusher({
    required this.maxHeight,
    this.width,
    this.duration,
    this.expand = true,
    this.curve = Curves.easeOut,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double maxHeight;
  final double? width;
  final Duration? duration;
  final bool expand;
  final Curve curve;
  /// --------------------------------------------------------------------------
  @override
  State<ListPusher> createState() => _ListPusherState();
  /// --------------------------------------------------------------------------
}

class _ListPusherState extends State<ListPusher> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  late Duration _duration;
  late Animation<double> _heightTween;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _duration = widget.duration ?? const Duration(milliseconds: 800);

    _animationController = AnimationController(
        reverseDuration: _duration,
        duration: _duration,
        vsync: this
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
      reverseCurve: widget.curve,
    );

  }
  // --------------------
  @override
  void dispose() {
    _animationController.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _animate() async {

    if (widget.expand == true){
      blog('should forward animation');
      await _animationController.forward();
    }
    else {
      blog('should reverse animation');
      await _animationController.reverse(from: 1);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _width = widget.width ?? Scale.screenWidth(context);
    // --------------------
    _animationController.reset();
    // --------------------
    _heightTween = Tween<double>(
      begin: widget.expand == true ? 0 : 1,
      end: widget.expand == true ? 1 : 0,
    ).animate(_curvedAnimation);
    // --------------------
    _animate();
    // --------------------
    return AnimatedBuilder(
        animation: _animationController.view,
        builder: (_, Widget? child){

          // final double _height = _heightTween.evaluate(_animation);

          final double _value = widget.maxHeight * _heightTween.value;

          return Container(
            width: _width,
            height: _value,
            color: Colorz.bloodTest,
          );

        }
        );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
