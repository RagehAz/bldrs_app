import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:flutter/material.dart';

class BzBuilder extends StatefulWidget {
  // --------------------------------------------------------------------------
  const BzBuilder({
    required this.bzID,
    required this.builder,
    this.child,
    this.initialModel,
    super.key
  });
  // --------------------
  final String? bzID;
  final Widget Function(bool loading, BzModel? bzModel, Widget? child) builder;
  final Widget? child;
  final BzModel? initialModel;
  // --------------------
  @override
  _BzBuilderState createState() => _BzBuilderState();
// --------------------------------------------------------------------------
}

class _BzBuilderState extends State<BzBuilder> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<BzModel?> _bzModelNotifier = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    if (
        widget.initialModel != null
        &&
        TextCheck.isEmpty(widget.bzID) == false
        &&
        widget.initialModel?.id == widget.bzID
    ){
      setNotifier(
          notifier: _bzModelNotifier,
          mounted: mounted,
          value: widget.initialModel
      );
    }

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        if (_bzModelNotifier.value == null){
          await _loadBz(widget.bzID);
        }



      });

    }
    super.didChangeDependencies();
  }
  // --------------------

  @override
  void didUpdateWidget(BzBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.bzID != widget.bzID) {
      unawaited(_loadBz(widget.bzID));
    }

    if (
        oldWidget.initialModel != widget.initialModel
        &&
        widget.initialModel != null
        &&
        widget.initialModel?.id == widget.bzID
    ){
      setNotifier(
        notifier: _bzModelNotifier,
        mounted: mounted,
        value: widget.initialModel,
      );
    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _bzModelNotifier.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> _loadBz(String? bzID) async {

    await _triggerLoading(setTo: true);

    final BzModel? _bz = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    setNotifier(
      notifier: _bzModelNotifier,
      mounted: mounted,
      value: _bz,
    );

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: _loading,
      child: widget.child,
      builder: (_, bool isLoading, Widget? child){

        return ValueListenableBuilder(
          valueListenable: _bzModelNotifier,
          child: child,
          builder: (_, BzModel? bzModel, Widget? ch){

            return widget.builder(isLoading, bzModel, ch);

          },
        );

      },
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}


/// DEPRECATED
// class BzBuilder extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const BzBuilder({
//     required this.bzID,
//     required this.builder,
//     super.key
//   });
//   // ------------------------
//   final String? bzID;
//   final Widget Function(bool loading, BzModel? bzModel) builder;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return FutureBuilder(
//         future: BzProtocols.fetchBz(bzID: bzID),
//         builder: (context, AsyncSnapshot<BzModel?> snap) {
//
//           return builder(snap.connectionState == ConnectionState.waiting, snap.data);
//
//         }
//         );
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
