import 'dart:async';

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FutureFlyer extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const FutureFlyer({
    @required this.flyerID,
    @required this.screenName,
    @required this.flyerBoxWidth,
    this.isSelected = false,
    this.onFlyerNotFound,
    this.onFlyerOptionsTap,
    this.onSelectFlyer,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final String flyerID;
  final String screenName;
  final double flyerBoxWidth;
  final bool isSelected;
  final ValueChanged<FlyerModel> onSelectFlyer;
  final ValueChanged<FlyerModel> onFlyerOptionsTap;
  final Function onFlyerNotFound;
  // -----------------------------------------------------------------------------
  @override
  State<FutureFlyer> createState() => _FutureFlyerState();
  // -----------------------------------------------------------------------------
}

class _FutureFlyerState extends State<FutureFlyer> {
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

    return FlyerSelectionStack(
      flyerModel: _flyerModel,
      flyerBoxWidth: widget.flyerBoxWidth,
      screenName: widget.screenName,
      onSelectFlyer: widget.onSelectFlyer == null ? null : () => widget.onSelectFlyer(_flyerModel),
      onFlyerOptionsTap: widget.onFlyerOptionsTap == null ? null : () => widget.onFlyerOptionsTap(_flyerModel),
      isSelected: widget.isSelected,
    );

  }
  // -----------------------------------------------------------------------------
}
