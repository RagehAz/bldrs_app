import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FlyerBuilder extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerBuilder({
    @required this.flyerID,
    @required this.builder,
    @required this.flyerBoxWidth,
    this.flyerModel,
    this.onFlyerNotFound,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final double flyerBoxWidth;
  final Function onFlyerNotFound;
  final FlyerModel flyerModel;
  final Widget Function(FlyerModel flyerModel) builder;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (flyerModel != null) {
      return builder(flyerModel);
    }

    else {

      return _FutureFlyerBuilder(
        flyerID: flyerID,
        flyerBoxWidth: flyerBoxWidth,
        onFlyerNotFound: onFlyerNotFound,
        builder: builder,
      );

    }

  }
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilder extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const _FutureFlyerBuilder({
    @required this.flyerID,
    @required this.builder,
    @required this.flyerBoxWidth,
    this.onFlyerNotFound,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final double flyerBoxWidth;
  final Function onFlyerNotFound;
  final Widget Function(FlyerModel flyerModel) builder;
  // -----------------------------------------------------------------------------
  @override
  State<_FutureFlyerBuilder> createState() => _FutureFlyerBuilderState();
  // -----------------------------------------------------------------------------
}

class _FutureFlyerBuilderState extends State<_FutureFlyerBuilder> {
  // -----------------------------------------------------------------------------
  FlyerModel _flyerModel;
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        final FlyerModel _flyer = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: widget.flyerID,
        );

        if (_flyer != null) {
          if (mounted == true){
            setState(() {
              _flyerModel = _flyer;
            });
          }
        }

        else {
          if (widget.onFlyerNotFound != null) {
            widget.onFlyerNotFound();
          }
        }

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      key: const ValueKey<String>('FlyerBuilder'),
      valueListenable: _loading,
      builder: (_, bool loading, Widget child) {

        if (loading == true) {
          return FlyerLoading(
            flyerBoxWidth: widget.flyerBoxWidth,
            animate: true,
            direction: Axis.vertical,
          );
        }

        else {
          return widget.builder(_flyerModel);
        }

      },
    );

    // return FlyerSelectionStack(
    //   flyerModel: _flyerModel,
    //   flyerBoxWidth: widget.flyerBoxWidth,
    //   screenName: widget.screenName,
    //   onSelectFlyer: widget.onSelectFlyer == null ? null : () => widget.onSelectFlyer(_flyerModel),
    //   onFlyerOptionsTap: widget.onFlyerOptionsTap == null ? null : () => widget.onFlyerOptionsTap(_flyerModel),
    //   isSelected: widget.isSelected,
    //   child: HeroicFlyer(
    //               // key: ValueKey<String>('FlyerSelectionStack${flyerModel.id}'),
    //               flyerModel: flyerModel,
    //               flyerBoxWidth: flyerBoxWidth,
    //               screenName: screenName,
    //             ),
    // );

  }
  // -----------------------------------------------------------------------------
}
